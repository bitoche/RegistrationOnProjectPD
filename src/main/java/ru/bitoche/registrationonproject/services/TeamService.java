package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.TeamMember;
import ru.bitoche.registrationonproject.models.TeamRequest;
import ru.bitoche.registrationonproject.models.dtos.AllUserRequestsDTO;
import ru.bitoche.registrationonproject.models.dtos.TeamTeamRequestDTO;
import ru.bitoche.registrationonproject.models.enums.TEAM_ROLE;
import ru.bitoche.registrationonproject.repos.TeamMemberRepos;
import ru.bitoche.registrationonproject.repos.TeamRepos;
import ru.bitoche.registrationonproject.repos.TeamRequestRepos;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class TeamService {
    private TeamMemberRepos teamMemberRepos;
    private TeamRepos teamRepos;
    private TeamRequestRepos teamRequestRepos;
    private IAppUserService userService;
    private ITopicService topicService;

    public List<TeamMember> getAllTeamMembers(){
        return (List<TeamMember>) teamMemberRepos.findAll();
    }
    public List<Team> getAllTeams(){
        return (List<Team>) teamRepos.findAll();
    }
    public boolean isUserInTeam(Long userId){
        return getAllTeamMembers().stream().anyMatch(tm -> tm.getMember().getId() == userId);
    }
    public List<Team> getUserTeams(long userId){
        List<Team> userTeams = new ArrayList<>();
        for (Team team:
             getAllTeams()) {
            if(team.getMembers().stream().anyMatch(tm->tm.getMember().getId()==userId)){
                userTeams.add(team);
            }
        }
        return userTeams;
    }
    public void saveTeamMember(TeamMember tm){
        teamMemberRepos.save(tm);
    }
    public void saveTeam(Team t){
        teamRepos.save(t);
    }
    public Team getTeamById(long id){
        return getAllTeams().stream().filter(t->t.getId()==id).findFirst().get();
    }

    public Team getBookedTeam(long topicId){
        for (Team t:
            getAllTeams()) {
            if(t.getTopic()!=null){
                if(t.getTopic().getId()==topicId){
                    return t;
                }
            }
        }
        return null;
    }
    public List<TeamRequest> getAllTeamRequests(){
        return (List<TeamRequest>) teamRequestRepos.findAll();
    }
    public boolean isUserAlreadyInThisTeam(AppUser user, Team team){
        if(getTeamMemberByUserIdAndTeamId(user.getId(), team.getId())!=null){
            return true;
        }
        return false;
    }
    public List<TeamTeamRequestDTO> getAllTeamTeamRequests(long userId){
        var requester = userService.getById(userId);
        List<TeamTeamRequestDTO> out = new ArrayList<>();
        for (Team team:
                getAllTeams()) {
            TeamTeamRequestDTO ttrDTO = new TeamTeamRequestDTO();
            ttrDTO.setTeam(team);
            ttrDTO.setAppUser(requester);
            ttrDTO.setRequested(false);
            if(isUserAlreadyInThisTeam(requester, team)){
                ttrDTO.setRequested(true);
            }
            else{
                for (TeamRequest tr:
                        getAllTeamRequests()) {
                    if(Objects.equals(tr.getTeam().getId(), team.getId())){
                        if(Objects.equals(tr.getRequestingUser().getId(), requester.getId())){
                            ttrDTO.setRequested(true);
                        }
                    }
                }
            }
            out.add(ttrDTO);
        }
        return out;
    }
    public void createRequestToTeam(long teamId, long userId){
        TeamRequest tr = new TeamRequest();
        tr.setTeam(getTeamById(teamId));
        tr.setDate(new Date());
        tr.setRequestingUser(userService.getById(userId));
        teamRequestRepos.save(tr);
    }
    public List<TeamRequest> getRequestedInTeamUsers(long teamId){
        return getAllTeamRequests().stream().filter(tr -> tr.getTeam().getId() == teamId).toList();
    }

    public void confirmInTeamRequest(long inTeamReqId){
        TeamRequest tr = getAllTeamRequests().stream().filter(t->t.getId()==inTeamReqId).findFirst().get();
        var trTeam = tr.getTeam();
        TeamMember newTeamMember = new TeamMember();
        newTeamMember.setMember(tr.getRequestingUser());
        newTeamMember.setDate(new Date());
        newTeamMember.setRole(TEAM_ROLE.STANDARD);
        saveTeamMember(newTeamMember);//MAIN SAVE IN DB
        trTeam.addTeamMember(newTeamMember);
        teamRequestRepos.deleteById(inTeamReqId);
        teamRepos.save(trTeam);
    }
    public void cancelInTeamRequest(long inTeamReqId){
        teamRequestRepos.deleteById(inTeamReqId);
    }

    public List<TeamMember> getAllTMsInTeam(){
        List<TeamMember> out = new ArrayList<>();
        for (Team t:
             getAllTeams()) {
            for (TeamMember tm:
                 t.getMembers()) {
                if(!out.contains(tm)){
                    out.add(tm);
                }
            }
        }
        return out;
    }


    public Team getTeamByInTeamRequestId(long inTeamReqId){
        return getAllTeamRequests().stream().filter(tr->tr.getId()==inTeamReqId).findFirst().get().getTeam();
    }
    public TeamMember getTeamMemberByUserIdAndTeamId(long userId, long teamId){
        var allUserTMs = new ArrayList<>(getAllTMsInTeam().stream().filter(tm -> tm.getMember().getId() == userId).toList());
        var userTeams = getUserTeams(userId);
        for (Team t:
             userTeams) {
            if(t.getId()==teamId){
                for (TeamMember tm:
                        allUserTMs) {
                    if(t.getMembers().contains(tm)){
                        return tm;
                    }
                }
            }
        }
        return null;
    }
    public Boolean amIMainInThisTeam(long userId, long teamId){
        if(isUserAlreadyInThisTeam(userService.getById(userId),getTeamById(teamId))){
            var userTm = getTeamMemberByUserIdAndTeamId(userId, teamId);
            return userTm.getRole() == TEAM_ROLE.CAPTAIN || userTm.getRole() == TEAM_ROLE.CREATOR;
        }
        return false;
    }
    @org.hibernate.annotations.OnDelete(action = OnDeleteAction.CASCADE)
    public void deleteTeamById(long teamId){
        var teamToDelete = getTeamById(teamId);
        //каскадное удаление teamMember'ов
        teamMemberRepos.deleteAll(teamToDelete.getMembers());
        //
        teamRepos.deleteById(teamId);

    }
    public TeamMember getTeamMemberById(long id){
        return teamMemberRepos.findById(id).get();
    }
    public void changeTMRoleByTMId(long tmId, TEAM_ROLE toRole){
        var currTM = getTeamMemberById(tmId);
        currTM.setRole(toRole);
        teamMemberRepos.save(currTM);
        System.out.println("LOG\tsuccessful changed role\t"+currTM.getId()+" to "+toRole);
    }

    public AllUserRequestsDTO getAllUserRequestsById(long userId){
        AllUserRequestsDTO out = new AllUserRequestsDTO();
        out.setTcrTcrsDTOList(topicService.getUserTCR_S(userId));
        out.setTeamTeamRequestDTOList(getAllTeamTeamRequests(userId));
        out.setTopicRequestStatusList(null); //todo сделать заявки на взятие темы командой
        return out;
    }

}
