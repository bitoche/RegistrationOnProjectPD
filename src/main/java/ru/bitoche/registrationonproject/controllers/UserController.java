package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.enums.STUDY_GROUP;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.services.AppUserService;
import ru.bitoche.registrationonproject.services.TopicService;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@AllArgsConstructor
public class UserController {
    AppUserService userService;
    TopicService topicService;
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
        m.addAttribute("allStudyGroups", STUDY_GROUP.values());
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
        appUser.setRole(USER_ROLE.STANDARD);
        userService.addUser(appUser);
        return "redirect:/";
    }


}
