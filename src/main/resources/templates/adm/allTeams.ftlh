<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Все команды</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
    <style>
        table {
            border-collapse: collapse; /* Используем collapse, чтобы убрать отступы между ячейками */
        }

        table td, th {
            padding: 10px; /* Отступ внутри ячеек */
            text-align: center; /* Выравнивание данных по центру */
            border: 1px solid black; /* Границы для ячеек */
        }

        table th,td:nth-child(even) {
            background-color: #f2f2f2; /* Делаем каждый четный столбец серым */
        }
    </style>
</head>
<body>
<#include "*/schemes/navbar.ftl">
<summary>
    <h3>Все команды</h3>
    <details>
        <#if allTeams?? && allTeams?has_content>
            <table>
                <thead>
                <tr>
                    <th>№</th>
                    <th>Название</th>
                    <th>Участники</th>
                    <th>Тема</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody>
                <#assign ctr=1/>
                <#list allTeams?sort_by("name") as team>
                    <tr>
                        <td>${ctr}</td>
                        <td>
                            <a href="/team/${team.getId()}">
                                ${team.getName()}</td>
                            </a>
                        <td>
                            <div style="display: flex; flex-direction: column">
                                <#if team.getMembers()?? && team.getMembers()?has_content >
                                    <#list team.getMembers() as tm>
                                        <p style="margin:0">${tm.getMember().getFullName()} - ${tm.getRole().name()}</p>
                                    </#list>
                                <#else>
                                    Нет.
                                </#if>
                            </div>
                        </td>
                        <td>
                            <#if team.getTopic()?? && team.getTopic()?has_content>
                                <a href="/topic/${team.getTopic().getId()}">${team.getTopic().getName()}</a>
                                <#else>
                                Нет.
                            </#if>
                        </td>
                        <td>
                            <#--todo сделать удаление обычных команд с подтверждением-->
                        </td>
                    </tr>
                    <#assign ctr=ctr+1>
                </#list>
                </tbody>
            </table>
        <#else >
            Нет команд.
        </#if>
    </details>
</summary>
<summary>
    <h3>Пустые команды</h3>
    <details>
        <#if allEmptyTeams?? && allEmptyTeams?has_content>
            <table>
                <thead>
                <tr>
                    <th>№</th>
                    <th>Название</th>
                    <th>Участники</th>
                    <th>Тема</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody>
                <#assign ctr=1/>
                <#list allEmptyTeams?sort_by("name") as team>
                    <tr>
                        <td>${ctr}</td>
                        <td>
                            <a href="/team/${team.getId()}">
                                ${team.getName()}</td>
                            </a>
                        </td>
                        <td>
                            <div style="display: flex; flex-direction: column">
                                <#if team.getMembers()?? && team.getMembers()?has_content >
                                    <#list team.getMembers() as tm>
                                        <p style="margin:0">${tm.getMember().getFullName()} - ${tm.getRole().name()}</p>
                                    </#list>
                                <#else>
                                    Нет.
                                </#if>
                            </div>
                        </td>
                        <td>
                            <#if team.getTopic()?? && team.getTopic()?has_content>
                                <a href="/topic/${team.getTopic().getId()}">${team.getTopic().getName()}</a>
                            <#else>
                                Нет.
                            </#if>
                        </td>
                        <td>
                            <form method="post" action="/adm/deleteEmptyTeam">
                                <input hidden name="teamId" value="${team.getId()}">
                                <button type="submit">Удалить(без подтверждения)</button>
                            </form>
                        </td>
                    </tr>
                    <#assign ctr=ctr+1>
                </#list>
                </tbody>
            </table>
        <#else >
            Нет команд.
        </#if>
    </details>
</summary>
</body>
</html>