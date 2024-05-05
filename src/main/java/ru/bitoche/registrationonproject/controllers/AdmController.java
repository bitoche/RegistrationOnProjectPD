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
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserService;
import ru.bitoche.registrationonproject.services.IAppUserService;
import ru.bitoche.registrationonproject.services.ITopicService;
import ru.bitoche.registrationonproject.services.TopicService;

import java.security.Principal;
import java.util.Date;
import java.util.Objects;

@Controller
@AllArgsConstructor
@RequestMapping("/adm")
public class AdmController{
    IAppUserService userService;
    ITopicService topicService;
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
        m.addAttribute("tcrequests", topicService.getAllTCRWithStatuses());
        m.addAttribute("allRequestStatuses", REQUEST_STATUS.values());
        m.addAttribute("countOfActiveTCR", topicService.getCountOfActiveCreateRequests());
        m.addAttribute("countOfAllTypesTCRS", topicService.countEveryTypeOfTCRequests());
        m.addAttribute("requestsOnTopics", topicService.topicRequestsGetAll());//todo сделать их  (m.addAttribute("requestsOnTopics", topicService.topicRequestsGetAll());)
        return "adm/requests";
    }
    boolean checkPrincipalPrivileges(Principal p){
        return userService.getByLogin(p.getName()).getRole().name() == "ADMIN" && userService.getByLogin(p.getName()).getRole().name() != "STUDENT";
    }
    @GetMapping("/approveTopic/{tcrId}")
    public String approveTopic(Principal principal, @PathVariable Long tcrId, Model model){
        if(checkPrincipalPrivileges(principal)){
            var tcrequest = topicService.tcrGetAll().stream().filter(tcr->tcr.getId()==tcrId).findFirst().get();
            Topic topic = new Topic();
            topic.setApprovedUser(userService.getByLogin(principal.getName()));
            topic.setName(tcrequest.getTopicName());
            topic.setDescription(tcrequest.getTopicDescription());
            topic.setAddingDate(new Date());
            topic.setAddingRequest(tcrequest);
            topicService.save(topic);
            //ставим статус заявки на одобрено без комментариев
            topicService.changeStatusTCR(REQUEST_STATUS.APPROVED, tcrequest, null);
            return "redirect:/adm/requests";
        }else {
            model.addAttribute("comm", "Для утверждения темы ("+tcrId+") необходимо иметь права доступа ADMIN, или MAIN_ADMIN.");
            model.addAttribute("tit", "access denied");
            return "error";
        }

    }

    @PostMapping("/reviewTopic")
    public String reviewTopic(Principal principal, int tcrId, String comm, Model model){
        if(checkPrincipalPrivileges(principal)){
            var tcrequest = topicService.tcrGetAll().stream().filter(tcr->tcr.getId()==tcrId).findFirst().get();
            topicService.changeStatusTCR(REQUEST_STATUS.REVIEWED, tcrequest, comm);
            return "redirect:/adm/requests";
        }else {
            model.addAttribute("comm", "Для изменения темы ("+tcrId+") необходимо иметь права доступа ADMIN, или MAIN_ADMIN.");
            model.addAttribute("tit", "access denied");
            return "error";
        }

    }

    @PostMapping("/declineTopic")
    public String declineTopic(Principal principal, int tcrId, String comm, Model model){
        if(checkPrincipalPrivileges(principal)){
            var tcrequest = topicService.tcrGetAll().stream().filter(tcr->tcr.getId()==tcrId).findFirst().get();
            topicService.changeStatusTCR(REQUEST_STATUS.REJECTED, tcrequest, comm);
            return "redirect:/adm/requests";
        }else {
            model.addAttribute("comm", "Для отмены заявки создания темы ("+tcrId+") необходимо иметь права доступа ADMIN, или MAIN_ADMIN.");
            model.addAttribute("tit", "access denied");
            return "error";
        }
    }

    @GetMapping("/deleteTopic/{topicId}")
    public String deleteTopic(Principal principal, @PathVariable Long topicId, Model model){
        if(checkPrincipalPrivileges(principal)){
            var userRole = userService.getByLogin(principal.getName()).getRole();
            if(userRole == USER_ROLE.MAIN_ADMIN || userRole == USER_ROLE.ADMIN || userRole == USER_ROLE.DEV){
                topicService.deleteTopic(topicId);
            }
            return "redirect:/";
            }
        else {
        model.addAttribute("comm", "Для удаления темы ("+topicId+") необходимо иметь права доступа ADMIN, или MAIN_ADMIN.");
        model.addAttribute("tit", "access denied");
        return "error";
        }
    }


}