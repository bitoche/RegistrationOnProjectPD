package ru.bitoche.registrationonproject.models.dtos;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.TopicCreateRequest;

import java.util.Date;
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class TopicDTO {
    private Long id;
    private String name;
    private String description;
    private Date addingDate;
    @Nullable
    private AppUser ApprovedUser;
    @Nullable
    private TopicCreateRequest addingRequest;
    private boolean isBooked;
    @Nullable
    private Team BookedTeam;
}
