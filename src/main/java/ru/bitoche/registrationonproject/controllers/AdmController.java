package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.bitoche.registrationonproject.models.Topic;
import ru.bitoche.registrationonproject.models.TopicCreateRequestStatus;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserService;
import ru.bitoche.registrationonproject.services.TopicService;

import java.security.Principal;
import java.util.Date;
import java.util.Objects;

@Controller
@AllArgsConstructor
@RequestMapping("/adm")
public class AdmController{
    AppUserService userService;
    TopicService topicService;
    @GetMapping("/userList")
    public String mainAdminMainPage(Principal principal, Model model){
        if(principal!=null){
            model.addAttribute("user", userService.getByLogin(principal.getName()));
        }
        model.addAttribute("userList", userService.getAll());
        model.addAttribute("userStudyGroups", userService.getAllStudyGroups());
        model.addAttribute("userCourses", userService.getAllStudyCourses());
        model.addAttribute("userRoles", USER_ROLE.values());
        return "adm/madm_userlist";
    }
    @PostMapping("/changerole")
    public String changeRole(Principal principal, String userId, String role, Model model){
        if(userService.getByLogin(principal.getName()).getRole()==USER_ROLE.MAIN_ADMIN){
            if(!userService.changeRole(Long.parseLong(userId), role)){
                model.addAttribute("err", "ОШИБКА СМЕНЫ РОЛИ!!! пользователя (id=" +
                        userId +"; role="+userService.getById(Integer.parseInt(userId))+") на "+ role);
            }
        }
        else if(Objects.equals(role, USER_ROLE.MAIN_ADMIN.name())){
            model.addAttribute("err", "Попросите пользователя с ролью MAIN_ADMIN сменить роль пользователя (id=" +
                    userId +"; role="+userService.getById(Integer.parseInt(userId))+") на MAIN_ADMIN");
        }
        else {
            if(!userService.changeRole(Long.parseLong(userId), role)){
                model.addAttribute("err", "ОШИБКА СМЕНЫ РОЛИ!!! пользователя (id=" +
                        userId +"; role="+userService.getById(Integer.parseInt(userId))+") на "+ role);
            }
        }
        return "redirect:/adm/userList";

    }

    @GetMapping("/requests")
    public String requestsPage(Principal principal, Model m){
        if(principal!=null){
            m.addAttribute("user", userService.getByLogin(principal.getName()));
        }
        m.addAttribute("tcrequests", topicService.tcrGetAll());
        m.addAttribute("requestsOnTopics", topicService.topicRequestsGetAll());
        return "adm/requests";
    }
    @GetMapping("/approveTopic/{tcrId}")
    public String approveTopic(Principal principal, @PathVariable Long tcrId){
        var tcrequest = topicService.tcrGetAll().stream().filter(tcr->tcr.getId()==tcrId).findFirst().get();
        Topic topic = new Topic();
        topic.setApprovedUser(userService.getByLogin(principal.getName()));
        topic.setName(tcrequest.getTopicName());
        topic.setDescription(tcrequest.getTopicDescription());
        topic.setAddingDate(new Date());
        topic.setAddingRequest(tcrequest);
        topicService.save(topic);
        //todo добавить обновление статуса заявки
        return "redirect:/adm/requests";
    }
}