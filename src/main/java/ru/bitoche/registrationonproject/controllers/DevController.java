package ru.bitoche.registrationonproject.controllers;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
        return "devpage";
    }
    @PostMapping("/adduser")
    public String adduser(@ModelAttribute("appUser") AppUser appUser){
        userService.addUser(appUser);
        return "redirect:/";
    }
}
