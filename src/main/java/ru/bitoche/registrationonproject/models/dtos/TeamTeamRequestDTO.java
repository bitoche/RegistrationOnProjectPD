package ru.bitoche.registrationonproject.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Team;
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class TeamTeamRequestDTO {
    Team team;
    AppUser appUser;
    boolean isRequested;
}
