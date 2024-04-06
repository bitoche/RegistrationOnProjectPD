package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserService;
import ru.bitoche.registrationonproject.services.TopicService;

@Controller
@AllArgsConstructor
@RequestMapping("/dev")
public class DevController {
    AppUserService userService;
    TopicService topicService;
    @GetMapping("/")
    public String devPage(Model m){
        m.addAttribute("userRoles", USER_ROLE.values());
        m.addAttribute("studyGroups", userService.getAllStudyGroups());
        m.addAttribute("studyCourses", userService.getAllStudyCourses());
        return "devpage";
    }
    @PostMapping("/adduser")
    public String adduser(@ModelAttribute("appUser") AppUser appUser){
        userService.addUser(appUser);
        return "redirect:userlist";
    }
    @GetMapping("/userlist")
    public String userlist(Model m){
        m.addAttribute("users", userService.getAll());
        m.addAttribute("userRoles", USER_ROLE.values());
        m.addAttribute("studyGroups", userService.getAllStudyGroups());
        m.addAttribute("studyCourses", userService.getAllStudyCourses());
        return "dev/userlist";
    }
    @PostMapping("/dev/users/delete/{userId}")
    @ResponseBody
    public String deleteUser(@PathVariable Long userId) {
        // Здесь происходит удаление пользователя с указанным userId
        userService.deleteById(userId);
        return "success";
    }

}
