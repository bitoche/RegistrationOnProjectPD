package ru.bitoche.registrationonproject.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.bitoche.registrationonproject.models.AppUser;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
public interface AppUserRepos extends CrudRepository<AppUser, Long> {
    Optional<AppUser> findByLogin(String login);
}
