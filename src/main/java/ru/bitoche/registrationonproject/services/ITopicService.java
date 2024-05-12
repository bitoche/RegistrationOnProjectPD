package ru.bitoche.registrationonproject.services;

import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import ru.bitoche.registrationonproject.models.*;
import ru.bitoche.registrationonproject.models.dtos.RequestCountDTO;
import ru.bitoche.registrationonproject.models.dtos.TCR_TCRSDTO;
import ru.bitoche.registrationonproject.models.dtos.TeamTopicDTO;
import ru.bitoche.registrationonproject.models.dtos.TopicDTO;
import ru.bitoche.registrationonproject.models.enums.REQUEST_STATUS;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public interface ITopicService {
        List<TeamTopicDTO> checkBooked();
        List<TopicDTO> main_getAll();
        List<TopicRequest> getAllTopicRequests();
        List<TopicRequestStatus> getAllTopicRequestsStatuses();
        void approveROT(long rotId);
        void deleteROTAndROTSByROTSId(long rotsId);
        void deleteAllTeamROTAndRotsByTeamId(long teamId);
        TopicRequest getTopicRequestByTeamIdAndTopicId(long teamId, long topicId);
        void createTopicRequest(long teamId, long topicId);
        boolean isTopicBooked(long topicId);
        Topic getTopicById(long id);
        List<TopicCreateRequest> tcrGetAll();
        List<TopicCreateRequestStatus> getAllTCRS();
        TopicCreateRequestStatus getTCRSByTCRId(long tcrId);
         List<TCR_TCRSDTO> getAllTCRWithStatuses();
        List<TopicCreateRequestStatus> tcrsGetAll();
        List<TopicRequest> topicRequestsGetAll();
        void saveTCR(TopicCreateRequest topicCreateRequest);
        void saveTCRS(TopicCreateRequestStatus tcrs);
        void createStatusForCreateTopic(TopicCreateRequest tcr);
        void save(Topic topic);
        void changeStatusTCR(REQUEST_STATUS status, TopicCreateRequest tcr, @Nullable String comment);
        void deleteTopic(Long topicId);
        int getCountOfActiveCreateRequests();
        List<TCR_TCRSDTO> getUserTCR_S(long userId);
        //тяжело
        List<RequestCountDTO> countEveryTypeOfTCRequests();
        //счетчики
        int countTCRSByRequestStatus(REQUEST_STATUS status);

        void declineROT(long rotId);
        List<TopicRequestStatus> getAllROTSByTeamId(long teamId);
        TopicRequest getROTByROTSId(long rotsId);
        TopicRequestStatus getROTSById(long rotsId);
        void saveROTS(TopicRequestStatus rot);
        void revokeROT(long rotId);

        long countActiveROTS();


        void createTopicAdm(String title, String description, AppUser admin);
}
