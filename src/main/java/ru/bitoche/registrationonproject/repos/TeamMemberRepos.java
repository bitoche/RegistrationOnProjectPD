package ru.bitoche.registrationonproject.repos;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamMemberRepos extends CrudRepository<ru.bitoche.registrationonproject.models.TeamMember, Long> {
}
