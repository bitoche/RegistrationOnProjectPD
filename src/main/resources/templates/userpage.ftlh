<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><#if userData.getId()==user.getId()>Мой профиль - РНП <#else>${userData.getFullName()} - РНП</#if> </title>
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
            flex-direction: row;
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
            max-height: 15vw;
            overflow: auto;
            z-index: 10001;

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
        .userRequestsButton{
            position: absolute;
            left: 2%;
            top:10%;
            background: #fff;
            border-radius: 5px;
            margin:2px;
            display: flex;
            flex-direction: column-reverse;
            align-items: center;
            border: 1px solid black;
            padding: 4px;
            font-size: small;
        }
        .two-column-rl{
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }
        .tcrstable{
            position: absolute;
            max-height: 40vw;
            max-width: 66vw;
            transform: translate(-50%, -50%);
            background-color: #c2c2c2;
            padding: 20px;
            border: 1px solid #000000;
            top:50%;
            left: 50%;
            z-index: 10000;
            overflow: auto;
        }
        .userRequestsButtonImage{
            width: 30px;
        }
    </style>
</head>
<body>
<#include "schemes/navbar.ftl">
<h1 style="text-align: center">Пользователь ${userData.getFullName()}</h1>
<div class="two-column-rl">
    <h3>Данные</h3>
    <#if user.getLogin()==userData.getLogin()>
        <div class="userRequestsButton" onclick="showHiddenForm('TCRSTable')" id="openingBtn+TCRSTable">
            <div>Мои запросы</div>
            <div><img  class="userRequestsButtonImage" src="https://icon-icons.com/icons2/1769/PNG/512/4092561-email-envelope-mail-message-mobile-ui-ui-website_114031.png"></div>
        </div>
        <div id="hiddenMenu+TCRSTable" class="tcrstable hidden">
            <a href="#"  class="exit-btn" onclick="showHiddenForm('TCRSTable')">Закрыть мои заявки на создание тем</a>
            <table id="tcr-s-table">
                <thead>
                <tr>
                    <td>№</td>
                    <td>Статус</td>
                    <td>Дата подачи заявки</td>
                    <td>Дата изменения статуса</td>
                    <td>Название темы</td>
                    <td>Описание темы</td>
                    <td>Комментарий модератора</td>
                    <td>Действие</td>
                </tr>
                </thead>
                <tbody>
                <#if userRequests?? && userRequests?has_content && user.getLogin()==userData.getLogin()>
                    <#if userRequests.getTcrTcrsDTOList()?? && userRequests.getTcrTcrsDTOList()?has_content>
                        <#assign ctr=1>
                        <#list userRequests.getTcrTcrsDTOList() as tcr_s>
                            <tr>
                                <form method="post" action="/users/editRequest">
                                    <td>${ctr?number}</td>
                                    <td>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()=="CREATED">
                                            <h4 style="color: blue">Создано</h4>
                                        </#if>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()=="REVIEWED">
                                            <h4 style="color: orange">Просмотрено</h4>
                                        </#if>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()=="REJECTED">
                                            <h4 style="color: red">Отказано</h4>
                                        </#if>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()=="APPROVED">
                                            <h4 style="color: green">Утверждено</h4>
                                        </#if>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()=="RESUBMITTED">
                                            <h4 style="color: blueviolet">Повторно отправлено</h4>
                                        </#if>
                                    </td>
                                    <td>${tcr_s.getTopicCreateRequest().getRequestDate()?date}</td>
                                    <td>${tcr_s.getTopicCreateRequestStatus().getDate()?date}</td>
                                    <td><input required name="editedTitle" value="${tcr_s.getTopicCreateRequest().getTopicName()}"></td>
                                    <td><textarea style="max-width: 19vw" required name="editedDesc">${tcr_s.getTopicCreateRequest().getTopicDescription()}</textarea></td>
                                    <input hidden name="tcrId" value="${tcr_s.getTopicCreateRequest().getId()}">
                                    <input hidden name="userId" value="${user.getId()}">
                                    <td>
                                        <#if tcr_s.getTopicCreateRequestStatus().getComment()??&& tcr_s.getTopicCreateRequestStatus().getComment()?has_content>
                                            ${tcr_s.getTopicCreateRequestStatus().getComment()}
                                        </#if>
                                    </td>
                                    <td>
                                        <#if tcr_s.getTopicCreateRequestStatus().getStatus()!="APPROVED"&&tcr_s.getTopicCreateRequestStatus().getStatus()!="REJECTED">
                                            <button type="submit">Отправить повторно</button>
                                        </#if>
                                    </td>
                                </form>
                            </tr>
                            <#assign ctr++>
                        </#list>
                    </#if>
                </#if>
                </tbody>
            </table>
        </div>
    </#if>

</div>

Роль: ${userData.getRole().name()}<br/>
Полное имя: ${userData.getFullName()}<br/>
<#if userData.getBirthDate()??>Дата рождения: ${userData.getBirthDate()}<br/></#if>
<#if userData.getStudyGroup()??>Учебная группа: ${userData.getStudyGroup().getName()}<br/></#if>



<#if userTeams??>

        <h3>Команды</h3>
        <div class="user-teams">
            <#assign counter=1>
        <#list userTeams?sort_by("name") as ut>
            <label>
                ${counter}. <a href="/team/${ut.getId()}">${ut.getName()}</a>
                <#assign counter++>
            </label>
        </#list>
        </div>
        <#else>
        <p style="color: red">Пока не находится в команде.</p>
    </#if>
<#if user.getId()==userData.getId()>
    <a id="requestToTeamFormButton" onclick="showRTTF()" class="actionBtn">Подать заявку в команду</a>
    <div id="rttfMenu" class="teamrequestdiv hidden" style="background: #fff!important;" >
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
                    </td>

                </tr>
            </#list>
            </tbody>
            </table>
        </#if>
    </div>
</#if>
<#if user.getId()==userData.getId()>
    <a id="requestToCreateTeamFormButton" onclick="showRTCTF()" class="actionBtn">Создать свою команду</a>
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
<#if user.getId()==userData.getId()>
    <script>
        function showRTTF() {
            var rttfMenu = document.getElementById('rttfMenu');
            var RTTFButton = document.getElementById('requestToTeamFormButton');
            rttfMenu.classList.toggle('hidden');
            RTTFButton.classList.toggle('disabled');
        }
        function showHiddenForm(formName){
            var hiddenMenu = document.getElementById('hiddenMenu+'+formName);
            var openingButton=document.getElementById('openingBtn+'+formName);
            hiddenMenu.classList.toggle('hidden');
            openingButton.classList.toggle('disabled');
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
</#if>

</body>
</html>