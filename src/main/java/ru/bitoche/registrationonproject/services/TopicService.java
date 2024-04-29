package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.*;
import ru.bitoche.registrationonproject.models.dtos.TeamTopicDTO;
import ru.bitoche.registrationonproject.models.dtos.TopicDTO;
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;
import ru.bitoche.registrationonproject.repos.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class TopicService {
    private TopicRepos topicRepos;
    private TeamRepos teamRepos;
    private TopicCreateRequestStatusRepos tcrsRepos;
    private TopicCreateRequestRepos tcrRepos;
    private TopicRequestRepos topicRequestRepos;
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
    public Topic getTopicById(long id){
        return topicRepos.findById(id).get();
    }

    public List<TopicCreateRequest> tcrGetAll(){
        var tcrs = (List<TopicCreateRequest>) tcrRepos.findAll();
        return tcrs.stream().toList();
    }
    public List<TopicCreateRequestStatus> tcrsGetAll(){
        return (List<TopicCreateRequestStatus>) tcrsRepos.findAll();
    }
    public List<TopicRequest> topicRequestsGetAll(){
        return (List<TopicRequest>) topicRequestRepos.findAll();
    }
    public void saveTCR(TopicCreateRequest topicCreateRequest){
        tcrRepos.save(topicCreateRequest);
    }
    public void saveTCRS(TopicCreateRequestStatus tcrs){
        tcrsRepos.save(tcrs);
    }

    public void createStatusForCreateTopic(TopicCreateRequest tcr){
        TopicCreateRequestStatus tcrs = new TopicCreateRequestStatus();
        tcrs.setDate(new Date());
        tcrs.setRequest(tcr);
        tcrs.setStatus(REQUEST_STATUS.CREATED);
        saveTCRS(tcrs);
    }
    public void save(Topic topic){
        topicRepos.save(topic);
    }
    public void changeStatusTCR(REQUEST_STATUS status, TopicCreateRequest tcr, @Nullable String comment){
        if (tcrsGetAll().stream().noneMatch(tcrs-> Objects.equals(tcrs.getRequest().getId(), tcr.getId()))){
            createStatusForCreateTopic(tcr);
        }
        var currTCRS = tcrsGetAll().stream().filter(tcrs-> Objects.equals(tcrs.getRequest().getId(), tcr.getId())).findFirst().get();
        currTCRS.setStatus(status);
        currTCRS.setDate(new Date());
        if(comment!=null){
            currTCRS.setComment(comment);
        }
        saveTCRS(currTCRS);
    }

    public void deleteTopic(Long topicId){
        topicRepos.delete(getTopicById(topicId));
    }
}
