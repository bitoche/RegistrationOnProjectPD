<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${currTeam.getName()} - РНП</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
    <link type="text/css" rel="stylesheet" href="/css/teamrequests.css"/>
    <style>
        .team-members{
            border-collapse: collapse;
        }
        .team-members td, th{
            padding: 5px;
            text-align: center;
            border-style: solid;
            border-width:1px ;
        }
    </style>
</head>
<body>
<#include "schemes/navbar.ftl">
<#if currTeam.isMemberMain(user.getLogin())>
    <#include "schemes/inTeamRequestsMenu.ftl">
    <button id="in-teamRequestsButton" onclick="showRequests()">Запросы на вступление <#if requestsToTeam?? && requestsToTeam?has_content><small style="color: green">+ ${requestsToTeam?size}</small></#if></button>
    <div id="in-teamRequestsContainer" class="teamrequestdiv hidden">
        <a onclick="showRequests()" class="exit-btn">Закрыть</a>
        <#if requestsToTeam?? >
            <#if requestsToTeam?has_content>
                <table class="requeststable" style="border-collapse: collapse">
                    <tbody>
                    <#list requestsToTeam?sort_by("date") as req>
                        <tr>
                            <td><a href="/users/profile/${req.requestingUser.id}">${req.requestingUser.fullName}</a></td>
                            <td>${req.date}</td>
                            <td><a onclick="confirmRequest(${req.id})" href="#">Принять</a></td>
                            <td><a onclick="cancelRequest(${req.id})" href="#">Отклонить</a> </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            <#else>
                Нет входящих запросов.
            </#if>
        <#else>
            <p style="color: red" onload="alert('Не удалось получить список заявок')">Не удалось получить список заявок</p>
        </#if>
    </div>
    <button id="topicRequestsButton" onclick="showTopicRequests()">Заявки на тему</button>
    <div id="topicRequestsContainer" class="teamrequestdiv hidden">
        <a onclick="showTopicRequests()" class="exit-btn">Закрыть</a>
        <#if requestsToTopics?? >
            <#if requestsToTopics?has_content>
                 <table class="requeststable" style="border-collapse: collapse">
                     <thead>
                     <tr>
                         <th>Дата запроса</th>
                         <th>Статус запроса</th>
                         <th>Тема</th>
                         <th>Действия</th>
                     </tr>
                     </thead>
                    <tbody>
                    <#list requestsToTopics?sort_by("statusDate") as rots> <#--rots = requestOnTopicStatus-->
                        <td>${rots.getStatusDate()?datetime}</td>
                        <td>${rots.getStatus().name()}</td>
                        <td><a href="/topic/${rots.getTopicRequest().getTopic().getId()}">${rots.getTopicRequest().getTopic().name}</a></td>
                        <td>
                            <#if rots.getStatus().name()!="APPROVED">
                                <a style="text-decoration: none;" onclick="cancelROT(${rots.id})" href="#cancel">Отменить</a>
                            </#if>
                        </td>
                        </tr>
                    </#list>
                    </tbody>
                 </table>
            <#else>
                Нет заявок.
            </#if>
        <#else>
            <p style="color: red" onload="alert('Не удалось получить список заявок')">Не удалось получить список заявок</p>
        </#if>
    </div>
</#if>
<h1 style="text-align: center">Команда "${currTeam.getName()}"</h1>
<div class="team-data">
    <h3>Состав команды</h3>
    <table class="team-members">
        <thead>
            <tr>
                <th>№</th>
                <th>Имя</th>
                <th>Роль</th>
                <th>Дата вступления</th>
                <#if amIMain>
                    <th>Сменить роль</th>
                </#if>
            </tr>
        </thead>
        <tbody>
        <#assign counter=1>
        <#list currTeam.getMembers()?sort_by("date") as member>
            <tr>
                <td>${counter}</td>
                <td><a href="/users/profile/${member.getMember().getId()}">${member.getMember().getFullName()}</a><#if member.getMember().getLogin()==user.getLogin()><small style="color: green">(ВЫ)</small></#if></td>
                <td>${member.getRole().name()}</td>
                <td>в команде с ${member.getDate()?date}</td>
                <#if amIMain>
                    <td>
                        <form id="changeRoleForm_${member.getId()}" method="post" action="/team/changeRole">
                            <input hidden name="myId" value="${user.getId()}">
                            <input hidden name="memberId" value="${member.getId()}">
                            <input hidden name="teamId" value="${currTeam.getId()}">
                            <#if member.getRole()!="CREATOR">
                                <select id="toRoleSelect" name="newRole" onchange="return changeRole(event, '${member.getMember().getFullName()}')">
                                    <#if allTeamRoles?? && allTeamRoles?has_content>
                                        <#list allTeamRoles as teamRole>
                                            <option value="${teamRole.name()}" <#if teamRole.name()=="CREATOR">disabled</#if><#if teamRole.name()==member.getRole().name()>selected</#if>>${teamRole.name()}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </#if>
                        </form>
                    </td>
                </#if>
                <#if member.getMember().getLogin()==user.getLogin()><a onclick="confirmLeaveTeam()" href="#leave">Покинуть команду</a></#if>
                <#assign counter+=1>
            </tr>
        </#list>
        </tbody>
    </table>
</div>
<#if currTeam.getTopic()??>
    <h3>Тема проекта</h3>
    <a href="/topic/${currTeam.getTopic().getId()}"><strong>${currTeam.getTopic().getName()}</strong></a>
    <#if amIMain>
        <a href="#cancel" onclick="confirmCancelTopic()">
            Отменить тему
        </a>
    </#if>
</#if>
<#if amIMain>
    <form id="deleteTeamForm" method="POST" action="/team/delete">
        <input hidden name="teamId" value="${currTeam.getId()}">
        <input hidden name="authedUserId" value="${user.getId()}">
        <button onclick="return confirmDeleteSubmit(event)" type="submit">Распустить команду</button> <#--НЕ УДАЛЯТЬ EVENT-->
    </form>
</#if>
<#if amIMain>
    <script>
        function confirmCancelTopic(){
            if(confirm('Вы действительно хотите отказаться от темы ${currTeam.getTopic().getName()}?')){
                document.location.href='/team/${currTeam.getId()}/cancelTopic';
            }
        }
        function changeRole(event, memberName){
            event.preventDefault();
            var form = event.target.form;
            var result = confirm("Вы уверены, что хотите сменить роль "+memberName+"?");

            if(result){
                form.submit();
            } else {
                return false;
            }
        }
        function confirmDeleteSubmit(event) {
            event.preventDefault(); // Отменить стандартное действие кнопки (отправку формы)

            // Вызываем окно подтверждения
            var result = confirm("Вы уверены, что хотите распустить команду ${currTeam.getName()}?");

            if (result) {
                // Если пользователь подтвердил, отправляем форму
                document.getElementById("deleteTeamForm").submit();
            } else {
                // Если пользователь отменил, ничего не делаем
                return false;
            }
        }
    </script>
</#if>
<#if currTeam.amIMember(user.getLogin())>
    <script>
        function confirmLeaveTeam(){
            if(confirm('Вы действительно хотите покинуть команду "${currTeam.getName()}?"')){
                document.location.href="/team/leaveTeam/${currTeam.getId()}/${user.getId()}";
            }
        }
    </script>
</#if>
</body>
</html>