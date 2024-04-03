package ru.bitoche.registrationonproject.repos;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.bitoche.registrationonproject.models.Team;

@Repository
public interface TeamRepos extends CrudRepository<Team, Long> {
}
