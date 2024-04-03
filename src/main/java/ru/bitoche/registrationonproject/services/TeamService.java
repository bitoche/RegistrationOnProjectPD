package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.repos.TeamMemberRepos;
import ru.bitoche.registrationonproject.repos.TeamRepos;
import ru.bitoche.registrationonproject.repos.TeamRequestRepos;

@Service
@AllArgsConstructor
public class TeamService {
    private TeamMemberRepos teamMemberRepos;
    private TeamRepos teamRepos;
    private TeamRequestRepos teamRequestRepos;

}
