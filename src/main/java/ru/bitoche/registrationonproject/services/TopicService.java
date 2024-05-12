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
    private TopicRequestStatusRepos topicRequestStatusRepos;
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
    public List<TopicRequest> getAllTopicRequests(){
        return (List<TopicRequest>) topicRequestRepos.findAll();
    }

    public List<TopicRequestStatus> getAllTopicRequestsStatuses() {
        return (List<TopicRequestStatus>) topicRequestStatusRepos.findAll();
    }

    public void approveROT(long rotId) {
        //var currROT= getAllTopicRequests().stream().filter(tr->tr.getId()==rotId).findFirst().get();//ищем запрос с таким id
        var currROTS = getAllTopicRequestsStatuses().stream().filter(trs->trs.getTopicRequest().getId()==rotId).findFirst().get();//ищем статус по этому запросу (ДОЛЖЕН БЫТЬ ВСЕГО ОДИН ТАКОЙ)
        currROTS.setStatusDate(new Date());
        currROTS.setStatus(REQUEST_STATUS.APPROVED);
        topicRequestStatusRepos.save(currROTS);
        updateTeamTopic(currROTS.getTopicRequest().getRequestingTeam(), currROTS.getTopicRequest().getTopic());
    }
    public void declineROT(long rotId){
        var currROTS = getAllTopicRequestsStatuses().stream().filter(trs->trs.getTopicRequest().getId()==rotId).findFirst().get();//ищем статус по этому запросу (ДОЛЖЕН БЫТЬ ВСЕГО ОДИН ТАКОЙ)
        currROTS.setStatusDate(new Date());
        currROTS.setStatus(REQUEST_STATUS.REJECTED);
        topicRequestStatusRepos.save(currROTS);
        updateTeamTopic(currROTS.getTopicRequest().getRequestingTeam(), null);
    }
    public List<TopicRequestStatus> getAllROTSByTeamId(long teamId){
        List<TopicRequestStatus> out = new ArrayList<>();
        for (TopicRequestStatus trs:
             getAllTopicRequestsStatuses()) {
            if(trs.getTopicRequest().getRequestingTeam().getId()==teamId){
                out.add(trs);
            }
        }
        return out;
    }
    public TopicRequest getROTByROTSId(long rotsId){
        return getROTSById(rotsId).getTopicRequest();
    }
    public TopicRequestStatus getROTSById(long rotsId){
        return getAllTopicRequestsStatuses().stream().filter(rots->rots.getId()==rotsId).findFirst().get();
    }
    public void deleteROTAndROTSByROTSId(long rotsId){
        var currROT = topicRequestStatusRepos.findById(rotsId).get().getTopicRequest();
        topicRequestStatusRepos.deleteById(rotsId);
        topicRequestRepos.deleteById(currROT.getId());
    }
    public void deleteAllTeamROTAndRotsByTeamId(long teamId){
        for (TopicRequestStatus rots:
             getAllTopicRequestsStatuses()) {
            if(rots.getTopicRequest().getRequestingTeam().getId()==teamId){
                deleteROTAndROTSByROTSId(rots.getId());
            }
        }
    }
    public void cascadeDeleteROTAndROTS(long teamId){
        var currTeamROTList = getAllTopicRequests().stream().filter(tr->tr.getRequestingTeam().getId()==teamId).toList();
        var currTeamROTSList = getAllTopicRequestsStatuses().stream().filter(trs->trs.getTopicRequest().getRequestingTeam().getId()==teamId).toList();
        for (TopicRequestStatus trs:
             currTeamROTSList) {

        }
    }

    public void updateTeamTopic(Team team, Topic topic){
        team.setTopic(topic);
        teamRepos.save(team);
    }
    public TopicRequest getTopicRequestByTeamIdAndTopicId(long teamId, long topicId){
        return getAllTopicRequests().stream().filter(topicRequest -> topicRequest.getRequestingTeam().getId()==teamId
                && topicRequest.getTopic().getId()==topicId).findFirst().get();
    }
    public TopicRequestStatus getROTSByROTId(long rotId){//rots = requestOnTopicStatus; rot = requestOnTopic
        for (TopicRequestStatus rots:
             getAllTopicRequestsStatuses()) {
            if(rots.getTopicRequest().getId()==rotId){
                return rots;
            }
        }
        return null;
    }
    public boolean isTeamRequestedToThisTopic(long teamId, long topicId){
        for (TopicRequestStatus trs:
             getAllROTSByTeamId(teamId)) {
            if(trs.getTopicRequest().getTopic().getId()==topicId){
                return true;
            }
        }
        return false;
    }
    public void deleteROTAndROTSByTeamIdAndTopicId(long teamId, long topicId){
        for (TopicRequestStatus trs:
             getAllROTSByTeamId(teamId)) {
            if(trs.getTopicRequest().getTopic().getId()==topicId){
                topicRequestStatusRepos.deleteById(trs.getId());
                topicRequestRepos.deleteById(trs.getTopicRequest().getId());
                break;
            }
        }
    }
    public void createTopicRequest(long teamId, long topicId){
        if(isTeamRequestedToThisTopic(teamId, topicId)){
            deleteROTAndROTSByTeamIdAndTopicId(teamId, topicId);
        }
        var requestedTeam =  teamRepos.findById(teamId).get();
        var requestTopic = getTopicById(topicId);
        var newTopicRequest = new TopicRequest();
        newTopicRequest.setTopic(requestTopic);
        newTopicRequest.setRequestingTeam(requestedTeam);
        topicRequestRepos.save(newTopicRequest);

        //нужно создать заявку для модера
        var newCTRS = new TopicRequestStatus();
        newCTRS.setStatus(REQUEST_STATUS.CREATED);
        newCTRS.setStatusDate(new Date());
        newCTRS.setTopicRequest(getTopicRequestByTeamIdAndTopicId(teamId, topicId));
        topicRequestStatusRepos.save(newCTRS);


    }
    public boolean isTopicBooked(long topicId){
        var allTeams = (List<Team>) teamRepos.findAll();
        for (Team team:
             allTeams) {
            if(team.getTopic()!=null && team.getTopic().getId()==topicId){ //прохожусь по всем командам, если занятая командой тема -
                                                                           // - это та, которую мы хотим проверить, то true
                return true;
            }
        }
        return false;
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
            tcr_tcrs.setTcrDate(tcr.getRequestDate());
            tcr_tcrs.setTopicCreateRequestStatus(getTCRSByTCRId(tcr.getId()));
            tcr_tcrs.setTcrsDate(getTCRSByTCRId(tcr.getId()).getDate());
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

    public void saveROTS(TopicRequestStatus rot){
        topicRequestStatusRepos.save(rot);
    }

    public void revokeROT(long rotId){
        var currROTS = getROTSByROTId(rotId);
        currROTS.setStatus(REQUEST_STATUS.REJECTED);
        currROTS.setStatusDate(new Date());
        saveROTS(currROTS);
        assert currROTS.getTopicRequest().getRequestingTeam().getTopic() != null;
        if(Objects.equals(currROTS.getTopicRequest().getRequestingTeam().getTopic().getId(), currROTS.getTopicRequest().getTopic().getId())){
            updateTeamTopic(currROTS.getTopicRequest().getRequestingTeam(), null);
        }
    }
    public long countActiveROTS(){
        long ctr = 0;
        for (TopicRequestStatus trs:
                getAllTopicRequestsStatuses()) {
            if(trs.getStatus()==REQUEST_STATUS.CREATED
                    ||trs.getStatus()==REQUEST_STATUS.RESUBMITTED
                    ||trs.getStatus()==REQUEST_STATUS.REVIEWED){
                ctr++;
            }
        }
        return ctr;
    }




    public void createTopicAdm(String title, String description, AppUser admin){
        var nTCR = new TopicCreateRequest();
        nTCR.setTopicName(title);
        nTCR.setTopicDescription(description);
        nTCR.setRequestDate(new Date());
        nTCR.setRequestingUser(admin);
        tcrRepos.save(nTCR);

        createStatusForCreateTopic(nTCR);
        var nTCRS = getTCRSByTCRId(nTCR.getId());
        nTCRS.setStatus(REQUEST_STATUS.APPROVED);
        tcrsRepos.save(nTCRS);

        var nTopic = new Topic();
        nTopic.setAddingDate(new Date());
        nTopic.setAddingRequest(nTCR);
        nTopic.setDescription(description);
        nTopic.setName(title);
        nTopic.setApprovedUser(admin);
        save(nTopic);
    }
}
