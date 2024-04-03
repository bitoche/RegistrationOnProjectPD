package ru.bitoche.registrationonproject.repos;

import org.springframework.data.repository.CrudRepository;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.Topic;

public interface TopicRepos extends CrudRepository<Topic, Long> {
}
