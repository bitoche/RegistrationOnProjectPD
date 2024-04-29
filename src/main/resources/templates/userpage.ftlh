<#--todo добавить сюда кнопку "заявки" со статусами-->
<#--todo добавить кнопку "группа"-->
<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${userData.getSurname()} ${userData.getName()}</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
    <style>
        .disabled {
            pointer-events: none;
            opacity: 0.5;
        }
        .hidden{
            display: none;
            transition: 0.5s;
        }
        .exit-btn{
            display: flex;
            flex-direction: row-reverse;
            text-decoration: none;
            color: red;
            padding: 2px;
        }
        .exit-btn:hover{
            transition: 0.2s;
            border-style: solid;
            border-width: 1px;
            background: rgba(222,222,222,0.99);
        }
        .actionBtn{
            cursor: pointer;
            color: #0a53be;
            display: block;
        }
        .teamrequestdiv{
            padding: 20px;
            border-width: 1px;
            border-style: solid;
            border-color: black;
            margin:2px;

        }
        table {
            border-collapse: collapse; /* Используем collapse, чтобы убрать отступы между ячейками */
        }

        td, th {
            padding: 10px; /* Отступ внутри ячеек */
            text-align: center; /* Выравнивание данных по центру */
            border: 1px solid black; /* Границы для ячеек */
        }

        th,td:nth-child(even) {
            background-color: #f2f2f2; /* Делаем каждый четный столбец серым */
        }
        .user-teams{
            display: flex;
            margin-bottom: 10px;
            flex-direction: column;
        }
    </style>
</head>
<body>
<#include "schemes/navbar.ftl">
<h1 style="text-align: center">Пользователь ${userData.getFullName()}</h1>
<h3>Данные</h3>
    Роль: ${userData.getRole().name()}<br/>
    Полное имя: ${userData.getFullName()}<br/>
    <#if userData.getBirthDate()??>Дата рождения: ${userData.getBirthDate()}<br/></#if>
    <#if userData.getStudyGroup()??>Учебная группа: ${userData.getStudyGroup().getName()}<br/></#if>
    <#if userTeams??>
        <h3>Команды</h3>
        <div class="user-teams">
        <#list userTeams?sort as ut>
            <a href="/team/${ut.getId()}">${ut.getName()}</a>
        </#list>
        </div>
        <#else>
        <p style="color: red">Пока не находится в команде.</p>
    </#if>
<#if user.getId()==userData.getId()>
    <a id="requestToTeamFormButton" onclick="showRTTF()" class="actionBtn">Подать заявку в группу</a>
    <div id="rttfMenu" class="teamrequestdiv hidden">
        <a href="#"  class="exit-btn" onclick="showRTTF()">Закрыть меню</a>
        <label>
            Поиск по названию команды
            <input type="text" id="searchInput" oninput="searchRequestToTeamTable()" placeholder="Введите текст для поиска">
        </label>
        <#if allTeamRequests??>
            <table id="teamTable">
            <thead>
            <tr>
                <th>Название</th>
                <th>Участники</th>
                <th>Действие</th>
            </tr>
            </thead>
            <tbody>
            <#list allTeamRequests as t>
                <tr>
                    <td><a href="/team/${t.getTeam().getId()}">${t.getTeam().getName()}</a></td>
                    <td><#list t.getTeam().getMembers() as member><a href="/users/profile/${member.getMember().getId()}">${member.getMember().getName()}</a> роль: ${member.getRole()}<#if member_has_next><br/></#if></#list></td>
                    <td>
                        <form method="post" action="/requestToTeam">
                            <input hidden name="teamId" value="${t.getTeam().getId()}">
                            <input hidden name="userId" value="${user.getId()}">
                            <button <#if t.isRequested()>disabled about="Вы уже подали заявку в эту команду"</#if> type="submit">Подать заявку</button>
                        </form>
                    </td> <#--todo сделать сдесь функцию подачи заявки в команду-->

                </tr>
            </#list>
            </tbody>
            </table>
        </#if>
    </div>
</#if>
<#if user.getId()==userData.getId()>
    <a id="requestToCreateTeamFormButton" onclick="showRTCTF()" class="actionBtn">Создать группу</a>
    <div id="rtctfMenu" class="teamrequestdiv hidden">
        <a href="#"  class="exit-btn" onclick="showRTCTF()">Закрыть меню</a>
        <form method="post" action="/teams/createTeam">
            <input hidden value="${user.getId()}" name="userId">
            <label>
                Название команды
                <input name="teamName" required/>
            </label><br/>
            <button type="submit">Создать</button>
        </form>
    </div>
</#if>
<script>
    function showRTTF() {
        var rttfMenu = document.getElementById('rttfMenu');
        var RTTFButton = document.getElementById('requestToTeamFormButton');
        rttfMenu.classList.toggle('hidden');
        RTTFButton.classList.toggle('disabled');
    }
    function showRTCTF(){
        var rtctfMenu = document.getElementById('rtctfMenu');
        var RTCTFButton = document.getElementById('requestToCreateTeamFormButton');
        rtctfMenu.classList.toggle('hidden');
        RTCTFButton.classList.toggle('disabled');
    }
    function searchRequestToTeamTable() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("teamTable"); // Выбор таблицы по id
        tr = table.getElementsByTagName("tr");

        // Проход по всем строкам таблицы, скрывая те, которые не соответствуют поисковому запросу
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0]; // Первая ячейка каждой строки содержит название команды
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>
</body>
</html>