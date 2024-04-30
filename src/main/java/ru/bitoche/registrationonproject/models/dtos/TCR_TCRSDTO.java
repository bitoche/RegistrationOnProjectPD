package ru.bitoche.registrationonproject.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ru.bitoche.registrationonproject.models.TopicCreateRequest;
import ru.bitoche.registrationonproject.models.TopicCreateRequestStatus;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class TCR_TCRSDTO {
    TopicCreateRequest topicCreateRequest;
    TopicCreateRequestStatus topicCreateRequestStatus;
}
