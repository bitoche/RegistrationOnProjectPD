package ru.bitoche.registrationonproject.models;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;

import java.util.Date;
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class TopicRequestStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private REQUEST_STATUS status;
    private Date statusDate;
    @Nullable
    private String comment;
    @Nullable
    @ManyToOne
    private AppUser reviewedAdmin;
}
