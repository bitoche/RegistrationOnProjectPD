package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.Team;
import ru.bitoche.registrationonproject.models.Topic;
import ru.bitoche.registrationonproject.models.TopicRequest;
import ru.bitoche.registrationonproject.models.dtos.TeamTopicDTO;
import ru.bitoche.registrationonproject.models.dtos.TopicDTO;
import ru.bitoche.registrationonproject.repos.TeamRepos;
import ru.bitoche.registrationonproject.repos.TopicRepos;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class TopicService {
    private TopicRepos topicRepos;
    private TeamRepos teamRepos;
    private List<TeamTopicDTO> checkBooked(){
        List<TeamTopicDTO> output = new ArrayList<>();
        for (Team team:
             teamRepos.findAll()) {
            TeamTopicDTO dto = new TeamTopicDTO();
            dto.setBookedTeam(team);
            for (Topic topic:
                 topicRepos.findAll()) {
                if(Objects.equals(topic.getId(), team.getTopic().getId())){
                    dto.setBookedTopic(topic);
                    break;
                }
            }
            output.add(dto);
        }
        return output;
    }
    public List<TopicDTO> main_getAll(){
        var allTopics = (List<Topic>) topicRepos.findAll();
        List<TopicDTO> output = new ArrayList<>();
        for (Topic t:
             allTopics) {
            TopicDTO dto = new TopicDTO();
            dto.setAddingDate(t.getAddingDate());
            dto.setAddingRequest(t.getAddingRequest());
            dto.setApprovedUser(t.getApprovedUser());
            dto.setDescription(t.getDescription());
            dto.setName(t.getName());
            dto.setId(t.getId());
            dto.setBooked(false);
            for (Team team :
                    teamRepos.findAll()) {
                if(team.getTopic()!=null){
                    if(Objects.equals(team.getTopic().getId(), dto.getId())){
                        dto.setBooked(true);
                        dto.setBookedTeam(team);
                        break;
                    }
                }
            }
            output.add(dto);
        }
        return output;
    }
}
