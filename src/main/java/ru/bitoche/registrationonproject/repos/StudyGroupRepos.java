package ru.bitoche.registrationonproject.repos;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.bitoche.registrationonproject.models.STUDY_GROUP;
@Repository
public interface StudyGroupRepos extends CrudRepository<STUDY_GROUP, Integer> {
}
