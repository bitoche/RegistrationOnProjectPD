package ru.bitoche.registrationonproject.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.Topic;
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class TeamTopicDTO {
    private Team BookedTeam;
    @Nullable
    private Topic BookedTopic;
}
