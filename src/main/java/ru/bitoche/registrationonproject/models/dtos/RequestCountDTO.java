package ru.bitoche.registrationonproject.models.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class RequestCountDTO {
    REQUEST_STATUS status;
    int countOfTCRS;
}
