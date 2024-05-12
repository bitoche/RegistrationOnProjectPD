package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.TeamMember;
import ru.bitoche.registrationonproject.models.TopicCreateRequest;
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;
import ru.bitoche.registrationonproject.models.enums.TEAM_ROLE;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserService;
import ru.bitoche.registrationonproject.services.TeamService;
import ru.bitoche.registrationonproject.services.TopicService;

import java.security.Principal;
import java.util.*;

@Controller
@AllArgsConstructor
public class UserController {
    AppUserService userService;
    TopicService topicService;
    TeamService teamService;
    @GetMapping("/")
    public String main(Principal principal, Model m){
        if(principal!=null){
            m.addAttribute("user", userService.getByLogin(principal.getName()));
        }
        m.addAttribute("userRoles", USER_ROLE.values());
        m.addAttribute("allTopics", topicService.main_getAll());
        return "main";
    }
    @GetMapping("/users/register")
    public String gotoRegisterPage(Model m) {
        m.addAttribute("allStudyGroups", userService.getAllStudyGroups());
        m.addAttribute("allStudyCourses", userService.getAllStudyCourses());
        return "register";
    }
    @GetMapping("/check-username")
    @ResponseBody
    public Map<String, Boolean> checkUsernameAvailability(@RequestParam("username") String username) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", !userService.isUsernameTaken(username));
        return response;
    }

    @PostMapping("/users/register")
    public String addUser(@ModelAttribute("appUser") AppUser appUser){
        appUser.setRole(USER_ROLE.STUDENT);
        userService.addUser(appUser);
        return "redirect:/";
    }

    @PostMapping("/users/topicCreateRequest")
    public String createTopicRequest(Long userId, String topicName, String topicDesc){
        TopicCreateRequest topicCreateRequest = new TopicCreateRequest();
        topicCreateRequest.setTopicName(topicName);
        topicCreateRequest.setRequestDate(new Date());
        topicCreateRequest.setRequestingUser(userService.getById(userId));
        topicCreateRequest.setTopicDescription(topicDesc);
        topicService.saveTCR(topicCreateRequest);
        topicService.createStatusForCreateTopic(topicCreateRequest);
        return "redirect:/";
    }

    @PostMapping("/users/editRequest")
    public String editTopicRequest(long tcrId, long userId, String editedTitle, String editedDesc, Principal principal, Model model){
        var currAuthedUser = userService.getByLogin(principal.getName());
        if(currAuthedUser.getId()!=userId){
            model.addAttribute("comm", "Не вы владелец этого запроса, не вам его менять xD.");
            model.addAttribute("tit", "access denied");
            return "error";
        }
        var currTcrs =  topicService.getTCRSByTCRId(tcrId);
        currTcrs.setDate(new Date());
        currTcrs.setStatus(REQUEST_STATUS.RESUBMITTED);
        currTcrs.setComment("");
        var currTcr = currTcrs.getRequest();
        currTcr.setTopicDescription(editedDesc);
        currTcr.setTopicName(editedTitle);

        currTcrs.setRequest(currTcr);
        topicService.saveTCR(currTcr);
        topicService.saveTCRS(currTcrs);
        return "redirect:/users/profile/"+userId;
    }

    @GetMapping("/users/profile/{userId}")
    public String openUserpage(@PathVariable long userId, Model m, Principal principal){
        m.addAttribute("userData", userService.getById(userId)); //CURR
        if (teamService.isUserInTeam(userId)){
            m.addAttribute("userTeams", teamService.getUserTeams(userId));
        }
        m.addAttribute("user", userService.getByLogin(principal.getName())); //AUTHED
        m.addAttribute("allTeamRequests", teamService.getAllTeamTeamRequests(userId));
        m.addAttribute("userRequests", teamService.getAllUserRequestsById(userId));
        return "userpage";
    }

    @PostMapping("/teams/createTeam")
    public String createTeam(long userId, String teamName){
        TeamMember tm = new TeamMember();
        tm.setMember(userService.getById(userId));
        tm.setRole(TEAM_ROLE.CREATOR);
        tm.setDate(new Date());
        teamService.saveTeamMember(tm);
        Team team = new Team();
        List<TeamMember> teamMembers = new ArrayList<>();
        teamMembers.add(tm);
        team.setMembers(teamMembers);
        team.setName(teamName);
        teamService.saveTeam(team);
        return "redirect:/users/profile/"+userId;
    }
    @GetMapping("/team/{teamId}")
    public String openTeamPage(Model m, @PathVariable long teamId, Principal principal){

        m.addAttribute("user", userService.getByLogin(principal.getName()));
        m.addAttribute("currTeam", teamService.getTeamById(teamId));
        m.addAttribute("requestsToTeam", teamService.getRequestedInTeamUsers(teamId));
        m.addAttribute("requestsToTopics", topicService.getAllROTSByTeamId(teamId));
        m.addAttribute("allTeamRoles", TEAM_ROLE.values());
        m.addAttribute("amIMain", teamService.amIMainInThisTeam(userService.getByLogin(principal.getName()).getId(),teamId));
        return "teampage";
    }
    @GetMapping("/topic/{topicId}")
    public String openTopicPage(Model m, @PathVariable long topicId, Principal principal){
        //здесь уже есть principal, иначе не пустит на страницу
        m.addAttribute("user", userService.getByLogin(principal.getName()));
        m.addAttribute("myTeams", teamService.getMainUserTeamsByLogin(principal.getName()));
        m.addAttribute("currTopic", topicService.getTopicById(topicId));
        m.addAttribute("bookedTeam", teamService.getBookedTeam(topicId));
        return "topicpage";
    }

    @PostMapping("/requestToTeam")
    public String sentRequestToTeam(long teamId, long userId){
        System.out.println("СЕРВЕР УСПЕШНО ПОЛУЧИЛ teamId="+teamId+" и userId="+userId);
        teamService.createRequestToTeam(teamId, userId);
        return "redirect:/users/profile/"+userId;
    }
    @GetMapping("/team/confirmRequest/{inTeamReqId}")
    public String confirmInTeamRequest(@PathVariable long inTeamReqId){
        var currTeam = teamService.getTeamByInTeamRequestId(inTeamReqId);
        teamService.confirmInTeamRequest(inTeamReqId);
        return "redirect:/team/"+currTeam.getId();
    }
    @GetMapping("/team/cancelRequest/{inTeamReqId}")
    public String cancelInTeamRequest(@PathVariable long inTeamReqId){
        var currTeam = teamService.getTeamByInTeamRequestId(inTeamReqId);
        teamService.cancelInTeamRequest(inTeamReqId);
        return "redirect:/team/"+currTeam.getId();
    }

    @PostMapping("/team/delete")
    public String deleteTeam(long teamId, long authedUserId){
        var authedUser = userService.getById(authedUserId);
        var team = teamService.getTeamById(teamId);
        if(teamService.isUserAlreadyInThisTeam(authedUser, team) && teamService.amIMainInThisTeam(authedUserId, teamId)){
            teamService.deleteTeamById(teamId);
            return "redirect:/";
        }
        else return null;
    }
    @PostMapping("/team/changeRole")
    public String changeMemberRole(long myId, long memberId, String newRole, long teamId){
        if(teamService.getTeamMemberByUserIdAndTeamId(myId, teamId).getRole()!=TEAM_ROLE.STANDARD /*если я не стандарт*/ && teamService.getTeamMemberById(memberId).getRole()!=TEAM_ROLE.CREATOR /*и если меняем не создателя команды*/){
            if(!Objects.equals(newRole, TEAM_ROLE.CREATOR.name())){
                teamService.changeTMRoleByTMId(memberId, TEAM_ROLE.valueOf(newRole));
            }
        }
        return "redirect:/team/"+teamId;
    }

    @PostMapping("/topic/createRequest")
    public String createRequestToTopicByTeam(Principal principal, String requestedUserLogin, long selectedTeamId, long requestedTopicId){
        if(Objects.equals(userService.getByLogin(requestedUserLogin).getId(), userService.getByLogin(principal.getName()).getId())){ //если подавший заявку - это я
            if(teamService.amIMainInThisTeam(userService.getByLogin(requestedUserLogin).getId(), selectedTeamId)){ // если я имею главную роль в этой команде
                if(!topicService.isTopicBooked(requestedTopicId)){ // если тема не занята
                    topicService.createTopicRequest(selectedTeamId, requestedTopicId); //создаем заявку на тему
                }
            }
        }
        return "redirect:/topic/"+requestedTopicId; //переходим на страницу темы
    }

    @GetMapping("/team/cancelROTS/{rotsId}")
    public String cancelROTS(@PathVariable long rotsId){
        var currROTS = topicService.getROTSById(rotsId);
        var currROT = topicService.getROTByROTSId(rotsId);
        if(!currROTS.getStatus().name().equals("APPROVED")){ // если еще не утвердили тему проекта
            topicService.deleteROTAndROTSByROTSId(rotsId);
        }
        return "redirect:/team/"+currROT.getRequestingTeam().getId();
    }

    @GetMapping("/team/{teamId}/cancelTopic")
    public String teamCancelTopic(@PathVariable long teamId, Principal principal){
        if(teamService.amIMainInThisTeam(userService.getByLogin(principal.getName()).getId(), teamId)){
            teamService.cancelTopic(teamId);
        }
        return "redirect:/team/"+teamId;
    }


}
