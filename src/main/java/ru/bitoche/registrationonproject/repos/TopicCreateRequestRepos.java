package ru.bitoche.registrationonproject.repos;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.bitoche.registrationonproject.models.AppUser;
import ru.bitoche.registrationonproject.models.TopicCreateRequest;
@Repository
public interface TopicCreateRequestRepos extends CrudRepository<TopicCreateRequest, Long> {
}
