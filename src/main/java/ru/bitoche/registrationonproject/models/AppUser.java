package ru.bitoche.registrationonproject.models;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;
import ru.bitoche.registrationonproject.models.enums.USER_ROLE;

import java.util.Date;
@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private USER_ROLE role;
    @Column(unique = true)
    private String login;
    private String password;
    private String name;
    private String surname;
    @Nullable
    private String patronymic;
    @Nullable
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;
    @Nullable
    @ManyToOne
    private STUDY_GROUP studyGroup;
    public String getFullName(){
        String fullName = surname+" "+name+" ";
        if(patronymic!=null){
            fullName+=patronymic;
        }
        return fullName;
    }
}
