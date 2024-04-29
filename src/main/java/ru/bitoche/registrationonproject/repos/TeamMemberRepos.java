package ru.bitoche.registrationonproject.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.bitoche.registrationonproject.models.TeamMember;

@Repository
public interface TeamMemberRepos extends JpaRepository<TeamMember, Long> {
}
