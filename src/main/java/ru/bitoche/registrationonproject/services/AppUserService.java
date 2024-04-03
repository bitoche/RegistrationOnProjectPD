package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.repos.AppUserRepos;

import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class AppUserService {
    @Autowired
    private AppUserRepos appUserRepos;
    private PasswordEncoder passwordEncoder;
    public List<AppUser> getAll(){return (List<AppUser>) appUserRepos.findAll();}
    public void update(AppUser user){appUserRepos.save(user);}
    public void updateAll(List<AppUser> users){appUserRepos.saveAll(users);}
    public boolean deleteById(long id){
        return appUserRepos.findById(id).isPresent() ? deleteById(id) : false;
    }
    public AppUser getById(long id){
        if(appUserRepos.findById(id).isPresent())
            return appUserRepos.findById(id).get();
        else return null;
    }

    public void addUser(AppUser user){
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        update(user);
    }

    public boolean isUsernameTaken(String username) {
        for (AppUser user:
             getAll()) {
            if (user.getLogin().equals(username)) { // Сравниваем строки напрямую с помощью equals()
                return true;
            }
        }
        return false;
    }
    public AppUser getByLogin(String login){
        if (isUsernameTaken(login)){
            return appUserRepos.findByLogin(login).get();
        }
        else return null;
    }
}
