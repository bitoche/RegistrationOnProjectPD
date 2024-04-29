package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.TeamMember;
import ru.bitoche.registrationonproject.models.TeamRequest;
import ru.bitoche.registrationonproject.models.dtos.TeamTeamRequestDTO;
import ru.bitoche.registrationonproject.repos.TeamMemberRepos;
import ru.bitoche.registrationonproject.repos.TeamRepos;
import ru.bitoche.registrationonproject.repos.TeamRequestRepos;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class TeamService {
    private TeamMemberRepos teamMemberRepos;
    private TeamRepos teamRepos;
    private TeamRequestRepos teamRequestRepos;
    private AppUserService userService;

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
    public List<TeamTeamRequestDTO> getAllTeamTeamRequests(long userId){
        var requester = userService.getById(userId);
        List<TeamTeamRequestDTO> out = new ArrayList<>();
        for (Team team:
                getAllTeams()) {
            TeamTeamRequestDTO ttrDTO = new TeamTeamRequestDTO();
            ttrDTO.setTeam(team);
            ttrDTO.setAppUser(requester);
            ttrDTO.setRequested(false);
            /*todo проверка, не находится ли user в этой команде?
             *  если да, то дальше ничего не делаем, setRequested=true */
            for (TeamRequest tr:
                    getAllTeamRequests()) {
                if(Objects.equals(tr.getTeam().getId(), team.getId())){
                    if(Objects.equals(tr.getRequestingUser().getId(), requester.getId())){
                        ttrDTO.setRequested(true);
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

}
