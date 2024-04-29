<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${currTeam.getName()} - РНП</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
    <style>

    </style>
</head>
<body>
<#include "schemes/navbar.ftl">
<#if currTeam.isMemberMain(user.getLogin())>
    <#include "schemes/inTeamRequestsMenu.ftl">
</#if>
<h1 style="text-align: center">Команда "${currTeam.getName()}"</h1>
<div class="team-data">
    <h3>Состав команды</h3>
    <table>
        <tbody>
        <#list currTeam.getMembers()?sort as member>
            <tr>
                <td><a href="/users/profile/${member.getMember().getId()}">${member.getMember().getFullName()}</a></td>
                <td>- ${member.getRole().name()}</td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>
<#if currTeam.getTopic()??>
    <h3>Тема проекта</h3>
    <a href="/topic/${currTeam.getTopic().getId()}"><strong>${currTeam.getTopic().getName()}</strong></a>
</#if>
</body>
</html>