<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${currTopic.getName()} - РНП</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "schemes/navbar.ftl">
<h1 style="text-align: center">Тема "${currTopic.getName()}"</h1>
<#if bookedTeam?? && bookedTeam?has_content>
    <h2 style="color: red; text-align: center">ЗАБРОНИРОВАНО КОМАНДОЙ "<a href="/team/${bookedTeam.getId()}">${bookedTeam.getName()}</a>"</h2>
    <#else>
        <h2 style="color: green">Вы можете забронировать эту тему!</h2>
        <form method="post" action="/topic/createRequest">
            <input hidden name="requestedUserLogin" value="${user.getLogin()}">
            <input hidden name="requestedTopicId" value="${currTopic.getId()}">
            <label>
                Выбрите одну из ваших команд<br/>
                <select required name="selectedTeamId">
                    <option selected value=''>Не выбрано</option>
                    <#if myTeams?? && myTeams?has_content>
                        <#list myTeams as mt>
                            <#if mt.getTopic?? && mt.getTopic()?has_content>
                                <#else >
                                    <option value="${mt.getId()}">${mt.getName()}</option>
                            </#if>
                        </#list>
                    </#if>
                </select>
            </label>
            <button type="submit">Подать заявку выбранной командой</button>
        </form>
</#if>
<h3>Название</h3>
<p>${currTopic.getName()}</p>
<h3>Описание</h3>
<textarea readonly style="width: 500px; height: 300px">${currTopic.getDescription()}</textarea><br/>
Дата добавления: ${currTopic.getAddingDate()}<br/>
Утвердил: <a href="/users/profile/${currTopic.getApprovedUser().getId()}">${currTopic.getApprovedUser().getFullName()}</a><br/>
<#if currTopic.getAddingRequest().getRequestingUser()?has_content??>
    Предложена : <a href="/users/profile/${currTopic.getAddingRequest().getRequestingUser().getId()}">${currTopic.getAddingRequest().getRequestingUser().getFullName()}</a> ${currTopic.getAddingRequest().getRequestDate()} <br/>
</#if>
</body>
</html>