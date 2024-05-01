package ru.bitoche.registrationonproject.services;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.STUDY_GROUP;

import java.util.List;

@Service
public interface IAppUserService{
        List<AppUser> getAll();
        void update(AppUser user);
        void updateAll(List<AppUser> users);
        void deleteById(long id);
        AppUser getById(long id);
        void addUser(AppUser user);
        boolean isUsernameTaken(String username);
        AppUser getByLogin(String login);
        List<STUDY_GROUP> getAllStudyGroups();
        List<Integer> getAllStudyCourses();
        boolean changeRole(long id, String role);
}
