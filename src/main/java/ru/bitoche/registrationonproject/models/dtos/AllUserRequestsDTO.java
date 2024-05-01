package ru.bitoche.registrationonproject.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ru.bitoche.registrationonproject.models.TopicRequest;
import ru.bitoche.registrationonproject.models.TopicRequestStatus;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class AllUserRequestsDTO {
    List<TCR_TCRSDTO> tcrTcrsDTOList;
    List<TeamTeamRequestDTO> teamTeamRequestDTOList;

    //не проверено
    List<TopicRequestStatus> topicRequestStatusList;

}
