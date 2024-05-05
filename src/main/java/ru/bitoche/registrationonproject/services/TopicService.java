package ru.bitoche.registrationonproject.services;

import lombok.AllArgsConstructor;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.*;
import ru.bitoche.registrationonproject.models.dtos.RequestCountDTO;
import ru.bitoche.registrationonproject.models.dtos.TCR_TCRSDTO;
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
public class TopicService implements ITopicService{
    private TopicRepos topicRepos;
    private TeamRepos teamRepos;
    private TopicCreateRequestStatusRepos tcrsRepos;
    private TopicCreateRequestRepos tcrRepos;
    private TopicRequestRepos topicRequestRepos;
    public List<TeamTopicDTO> checkBooked(){
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
    public List<RequestCountDTO> countEveryTypeOfTCRequests(){
        var statuses = REQUEST_STATUS.values();
        var tcrses = getAllTCRS();
        List<RequestCountDTO> outArr = new ArrayList<>();
        for (REQUEST_STATUS s:
             statuses) {
            var dto = new RequestCountDTO(s, 0);
            for (TopicCreateRequestStatus tcrs:
                 tcrses) {
                if(tcrs.getStatus()==s){
                    dto.setCountOfTCRS(dto.getCountOfTCRS()+1);
                }
            }
            outArr.add(dto);
        }
        return outArr;
    }

    public int countTCRSByRequestStatus(REQUEST_STATUS status) {
        int ctr=0;
        for (TopicCreateRequestStatus tcrs:
             getAllTCRS()) {
            if(tcrs.getStatus()==status){
                ctr++;
            }
        }
        return ctr;
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
    public List<TopicCreateRequestStatus> getAllTCRS(){
        return (List<TopicCreateRequestStatus>) tcrsRepos.findAll();
    }
    public TopicCreateRequestStatus getTCRSByTCRId(long tcrId){
        return getAllTCRS().stream().filter(tcrs->tcrs.getRequest().getId()==tcrId).findFirst().get();
    }
    public  List<TCR_TCRSDTO> getAllTCRWithStatuses(){
        List<TCR_TCRSDTO> out = new ArrayList<>();
        for (TopicCreateRequest tcr:
             tcrGetAll()) {
            TCR_TCRSDTO tcr_tcrs = new TCR_TCRSDTO();
            tcr_tcrs.setTopicCreateRequest(tcr);
            tcr_tcrs.setTopicCreateRequestStatus(getTCRSByTCRId(tcr.getId()));
            out.add(tcr_tcrs);
        }
        return out;
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
    public int getCountOfActiveCreateRequests(){
        return getAllTCRWithStatuses().stream().filter(t->t.getTopicCreateRequestStatus().getStatus()==REQUEST_STATUS.CREATED||t.getTopicCreateRequestStatus().getStatus()==REQUEST_STATUS.REVIEWED||t.getTopicCreateRequestStatus().getStatus()==REQUEST_STATUS.RESUBMITTED).toList().size();
    }

    public List<TCR_TCRSDTO> getUserTCR_S(long userId){
        return getAllTCRWithStatuses().stream().filter(tcr_tcrsdto -> tcr_tcrsdto.getTopicCreateRequest().getRequestingUser().getId()==userId).toList();
    }

}
