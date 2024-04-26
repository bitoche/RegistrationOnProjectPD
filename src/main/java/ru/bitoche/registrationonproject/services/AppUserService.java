package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.STUDY_GROUP;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;
import ru.bitoche.registrationonproject.repos.AppUserRepos;
import ru.bitoche.registrationonproject.repos.StudyGroupRepos;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class AppUserService {
    @Autowired
    private AppUserRepos appUserRepos;
    private PasswordEncoder passwordEncoder;
    private StudyGroupRepos stgrRepos;
    public List<AppUser> getAll(){return (List<AppUser>) appUserRepos.findAll();}
    public void update(AppUser user){appUserRepos.save(user);}
    public void updateAll(List<AppUser> users){appUserRepos.saveAll(users);}
    public void deleteById(long id){
        if(appUserRepos.findById(id).isPresent()){
            appUserRepos.deleteById(id);
        }
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
    public List<STUDY_GROUP> getAllStudyGroups(){
        return (List<STUDY_GROUP>) stgrRepos.findAll();
    }
    public List<Integer> getAllStudyCourses(){
        List<Integer> output = new ArrayList<>();
        for (STUDY_GROUP stgr:
             getAllStudyGroups()) {
            if(!output.contains(stgr.getCourse())){
                output.add(stgr.getCourse());
            }
        }
        return output;
    }
    public boolean changeRole(long id, String role){
        if(getById(id)!=null){
            var user = getById(id);
            System.out.println("Смена роли (id="+id+";role="+user.getRole()+") на "+USER_ROLE.valueOf(role));
            user.setRole(USER_ROLE.valueOf(role));
            update(user);
            return true;
        }
        else return false;

    }
}
