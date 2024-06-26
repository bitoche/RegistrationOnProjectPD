package ru.bitoche.registrationonproject.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.springframework.lang.Nullable;
import ru.bitoche.registrationonproject.models.enums.TEAM_ROLE;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Team {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    @OneToMany
    private List<TeamMember> members;
    @OneToOne
    @Nullable
    private Topic topic;

    public boolean amIMember(String login){
        for (TeamMember tm:
             members) {
            if(Objects.equals(tm.getMember().getLogin(), login)){
                return true;
            }
        }
        return false;
    }

    public void deleteTeamMember(long tmId){
        for (TeamMember tm:
             members) {
            if(tm.getId()==tmId) {
                members.remove(tm);
                break;
            }
        }
    }
    public List<TeamMember> getMainMembers(){
        List<TeamMember> mainMembers = new ArrayList<>();
        for (TeamMember member:
             members) {
            if(member.getRole()== TEAM_ROLE.CREATOR||member.getRole()==TEAM_ROLE.CAPTAIN){
                mainMembers.add(member);
            }
        }
        return mainMembers;
    }
    public boolean isMemberMain(String login){
        for (TeamMember member:
             getMainMembers()) {
            if(Objects.equals(member.getMember().getLogin(), login)){
                return true;
            }
        }
        return false;
    }
    public void addTeamMember(TeamMember teamMember){
        members.add(teamMember);
    }
    public boolean amIMain(long id){
        for (TeamMember m:
             getMainMembers()) {
            if(m.getMember().getId()==id){
                return true;
            }
        }
        return false;
    }
}
