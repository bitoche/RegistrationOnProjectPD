package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.TeamMember;
import ru.bitoche.registrationonproject.models.TopicCreateRequest;
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

    @GetMapping("/users/profile/{userId}")
    public String openUserpage(@PathVariable long userId, Model m, Principal principal){
        m.addAttribute("userData", userService.getById(userId));
        if (teamService.isUserInTeam(userId)){
            m.addAttribute("userTeams", teamService.getUserTeams(userId));
        }
        m.addAttribute("user", userService.getByLogin(principal.getName()));
        m.addAttribute("allTeamRequests", teamService.getAllTeamTeamRequests(userId));
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
        return "teampage";
    }
    @GetMapping("/topic/{topicId}")
    public String openTopicPage(Model m, @PathVariable long topicId, Principal principal){
        m.addAttribute("user", userService.getByLogin(principal.getName()));
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

}
