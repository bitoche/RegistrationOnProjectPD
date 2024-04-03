package ru.bitoche.registrationonproject.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.AppUserDetails;
import ru.bitoche.registrationonproject.repos.AppUserRepos;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
@Service
public class AppUserDetailsService implements UserDetailsService {
    @Autowired
    private AppUserRepos appUserRepos;
    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        Optional<AppUser> user = appUserRepos.findByLogin(login);
        return user.map(AppUserDetails::new)
                .orElseThrow(()-> new UsernameNotFoundException(login + " не найден"));
    }
}
