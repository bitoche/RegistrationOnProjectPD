<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Обработка запросов</title>
    <style>
        .hidden{
            display: none;
        }
        .full-monitor{
            position: absolute;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #000000;
            top:50%;
            left: 50%;
            z-index: 9999;
            max-height: 100vh;
            max-width: 100vw;
            overflow: auto;
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
        .disabled {
            pointer-events: none;
            opacity: 0.5;
        }
        .hrf{
            position: absolute;
            transform: translate(-50%, -50%);
            background-color: #c2c2c2;
            padding: 20px;
            border: 1px solid #000000;
            top:50%;
            left: 50%;
            z-index: 10000;
        }
        .request-item{
            display: flex;
        }
        .rot-table {
            border-collapse: collapse; /* Используем collapse, чтобы убрать отступы между ячейками */
        }

        .rot-table td, th {
            padding: 10px; /* Отступ внутри ячеек */
            text-align: center; /* Выравнивание данных по центру */
            border: 1px solid black; /* Границы для ячеек */
        }

        .rot-table th,td:nth-child(even) {
            background-color: #f2f2f2; /* Делаем каждый четный столбец серым */
        }
    </style>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "*/schemes/navbar.ftl">
    <button id="TCRbutton" class="disabled" onclick="showTCRMenu()">Запросы на создание новых тем <small style="color: green;"><#if countOfActiveTCR?has_content>+ ${countOfActiveTCR}</#if></small></button>
    <div id="tcrequest_menu" class="full-monitor">
        <a href="#"  class="exit-btn" onclick="showTCRMenu()">Закрыть запросы на создание тем</a>
        <label>
            По статусу
            <select name="statusSelect" id="statusSelect">
                <#if allRequestStatuses?? && allRequestStatuses?has_content>
                    <option value="">Все</option>
                    <#list allRequestStatuses as rs>
                        <option value="${rs.name()}" <#if rs.name()=="CREATED">selected</#if> >
                            <#if rs.name()=="CREATED">
                                Создано <#if countOfAllTypesTCRS?? && countOfAllTypesTCRS?has_content>
                                    <#list countOfAllTypesTCRS as cnt>
                                        <#if cnt.status.name()==rs.name()><small style="color: green">(${cnt.countOfTCRS})</small></#if>
                                    </#list>
                                </#if>
                            </#if>
                            <#if rs.name()=="REVIEWED">
                                Просмотрено <#if countOfAllTypesTCRS?? && countOfAllTypesTCRS?has_content>
                                <#list countOfAllTypesTCRS as cnt>
                                    <#if cnt.status.name()==rs.name()><small style="color: green">(${cnt.countOfTCRS})</small></#if>
                                </#list>
                            </#if>
                            </#if>
                            <#if rs.name()=="REJECTED">
                                Отказано <#if countOfAllTypesTCRS?? && countOfAllTypesTCRS?has_content>
                                <#list countOfAllTypesTCRS as cnt>
                                    <#if cnt.status.name()==rs.name()><small style="color: green">(${cnt.countOfTCRS})</small></#if>
                                </#list>
                            </#if>
                            </#if>
                            <#if rs.name()=="APPROVED">
                                Утверждено <#if countOfAllTypesTCRS?? && countOfAllTypesTCRS?has_content>
                                <#list countOfAllTypesTCRS as cnt>
                                    <#if cnt.status.name()==rs.name()><small style="color: green">(${cnt.countOfTCRS})</small></#if>
                                </#list>
                            </#if>
                            </#if>
                            <#if rs.name()=="RESUBMITTED">
                                Повторно отправлено <#if countOfAllTypesTCRS?? && countOfAllTypesTCRS?has_content>
                                <#list countOfAllTypesTCRS as cnt>
                                    <#if cnt.status.name()==rs.name()><small style="color: green">(${cnt.countOfTCRS})</small></#if>
                                </#list>
                            </#if>
                            </#if>
                        </option>
                    </#list>
                </#if>
            </select>
        </label>
        <label>
            По дате
            <select id="byDateCheckbox" onchange="sortByDate()">
                <option value=''>Не выбрано</option>
                <option value="fromNewToOld">От новых к старым</option>
                <option value="fromOldToNew">От старых к новым</option>
            </select>
        </label>
        <div class="requests-container">
            <table id="status-data">
                <tbody>
            <#if tcrequests??>
                <#if tcrequests?has_content>
                    <#list tcrequests as tcrtcrs>
                        <tr>
                            <td>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()=="CREATED">
                                    <h4 style="color: blue">Создано</h4>
                                </#if>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()=="REVIEWED">
                                    <h4 style="color: orange">Просмотрено</h4>
                                </#if>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()=="REJECTED">
                                    <h4 style="color: red">Отказано</h4>
                                </#if>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()=="APPROVED">
                                    <h4 style="color: green">Утверждено</h4>
                                </#if>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()=="RESUBMITTED">
                                    <h4 style="color: blueviolet">Повторно отправлено</h4>
                                </#if>
                            </td>
                            <td>
                                <div <#if tcrtcrs_has_next>style="border-bottom-style: solid; border-width: 1px"</#if>>
                                    <div class="request-item">
                                        <div class="item-date" style="font-size: 0">
                                            <label>
                                                ${tcrtcrs.getTopicCreateRequest().getRequestDate()?string("yyyy-MM-dd'T'HH:mm:ss")}
                                            </label>
                                        </div>
                                        <div class="item-friendly-date">
                                            Дата запроса:
                                            <label>
                                                ${tcrtcrs.getTopicCreateRequest().getRequestDate()?date}
                                            </label>
                                        </div>
                                        <div class="item-requester">
                                            <label>
                                                Пользователь:
                                                <a href="/users/profile/${tcrtcrs.getTopicCreateRequest().getRequestingUser().getId()}">${tcrtcrs.getTopicCreateRequest().getRequestingUser().getSurname()} ${tcrtcrs.getTopicCreateRequest().getRequestingUser().getName()} ${tcrtcrs.getTopicCreateRequest().getRequestingUser().getPatronymic()}</a>
                                            </label>
                                        </div>
                                        <div class="item-title">

                                            <label class="tcr-title">
                                                Тема:
                                                ${tcrtcrs.getTopicCreateRequest().getTopicName()}
                                            </label>
                                        </div>
                                        <div class="item-desc">
                                            <textarea readonly class="tcr-desc">${tcrtcrs.getTopicCreateRequest().getTopicDescription()}</textarea>
                                        </div>
                                    </div>
                                    <#if tcrtcrs.getTopicCreateRequestStatus().getComment()?? && tcrtcrs.getTopicCreateRequestStatus().getComment()?has_content>
                                        <div class="request-item">
                                            <div class="item-comment">
                                                <label>
                                                    Комментарий модератора: ${tcrtcrs.getTopicCreateRequestStatus().getComment()}
                                                </label>
                                            </div>
                                        </div>
                                    </#if>
                                </div>
                            </td>
                            <td>
                                <#if tcrtcrs.getTopicCreateRequestStatus().getStatus()!="APPROVED"&&tcrtcrs.getTopicCreateRequestStatus().getStatus()!="REJECTED">
                                    <a href="/adm/approveTopic/${tcrtcrs.getTopicCreateRequest().getId()}">Утвердить</a>
                                    <a href="#review#" onclick="showReviewMenu(${tcrtcrs.getTopicCreateRequest().getId()})" id="reviewBtn-${tcrtcrs.getTopicCreateRequest().getId()}">Оставить комментарий</a>
                                    <div id="hiddenReviewForm-${tcrtcrs.getTopicCreateRequest().getId()}" class="hrf hidden">
                                        <a href="#"  class="exit-btn" onclick="showReviewMenu(${tcrtcrs.getTopicCreateRequest().getId()})">Отменить</a>
                                        <form action="/adm/reviewTopic" method="post">
                                            <textarea name="comm" style="width: max-content; height: 100px" placeholder="Комментарий"></textarea>
                                            <input hidden name="tcrId" value="${tcrtcrs.getTopicCreateRequest().getId()}">
                                            <button type="submit">Отправить</button>
                                        </form>
                                    </div>
                                    <a href="#decline#" onclick="showDeclineMenu(${tcrtcrs.getTopicCreateRequest().getId()})" id="declineBtn-${tcrtcrs.getTopicCreateRequest().getId()}" style="color: red;">Отказать</a>
                                    <div id="hiddenDeclineForm-${tcrtcrs.getTopicCreateRequest().getId()}" class="hrf hidden">
                                        <a href="#"  class="exit-btn" onclick="showDeclineMenu(${tcrtcrs.getTopicCreateRequest().getId()})">Отменить</a>
                                        <form action="/adm/declineTopic" method="post">
                                            <textarea name="comm" style="width: max-content; height: 100px" placeholder="Комментарий"></textarea>
                                            <input hidden name="tcrId" value="${tcrtcrs.getTopicCreateRequest().getId()}">
                                            <button type="submit">Отправить</button>
                                        </form>
                                    </div>
                                </#if>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                    </table>
                <#else>
                    Здесь пока ничего нет.
                </#if>
            <#else>
                Произошла какая-то ошибка.
            </#if>
        </div>
        <#--остальное-->
    </div>
    <button id="Rbutton" onclick="showMenu()">Запросы на взятие темы <small style="color: green;"><#if requestsOnTopics?has_content>+ ${requestsOnTopics?size}</#if></small></button>
    <div id="request_menu" class="full-monitor hidden">
        <a href="#"  class="exit-btn" onclick="showMenu()">Закрыть</a>
        <div class="requests-container">
            <#if requestsOnTopics??>
                <#if requestsOnTopics?has_content>
                    <table class="rot-table">
                        <thead>
                        <tr>
                            <th>Статус</th>
                            <th>Дата</th>
                            <th>Команда</th>
                            <th>Тема</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list requestsOnTopics as rot>
                            <tr>
                                <td>${rot.getStatus().name()}</td>
                                <td>${rot.getStatusDate()}</td>
                                <td>
                                    <a href="/team/${rot.getTopicRequest().getRequestingTeam().getId()}">
                                        ${rot.getTopicRequest().requestingTeam.getName()}
                                    </a>
                                </td>
                                <td>
                                    <a href="/topic/${rot.getTopicRequest().getTopic().getId()}">
                                        ${rot.getTopicRequest().getTopic().getName()}
                                    </a>
                                </td>
                                <td>
                                    <form action="/adm/approveROT" method="post">
                                        <input hidden name="rotsId" value="${rot.getId()}">
                                        <input hidden name="rotId" value="${rot.getTopicRequest().getId()}">
                                        <button type="submit">Разрешить</button>
                                    </form>
                                    <form action="/adm/declineROT" method="post">
                                        <input hidden name="rotsId" value="${rot.getId()}">
                                        <input hidden name="rotId" value="${rot.getTopicRequest().getId()}">
                                        <button type="submit">Отказать</button>
                                    </form>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                <#else>
                    Здесь пока ничего нет.
                </#if>
            <#else>
            Произошла какая-то ошибка.
            </#if>
        </div>
        <#--остальное-->
    </div>
    <script>
        //сортировка таблицы по дате и статусу
        document.addEventListener("DOMContentLoaded", function() {
            var statusSelect = document.getElementById("statusSelect");
            var dateSelect = document.getElementById("byDateCheckbox");

            statusSelect.addEventListener("change", updateTable);
            dateSelect.addEventListener("change", updateTable);

            updateTable(); // Вызываем функцию для обновления таблицы сразу после загрузки страницы
        });

        //функция сортировки по дате
        function sortByDate() {
            var selectElement = document.getElementById("byDateCheckbox");
            var selectedValue = selectElement.value;
            console.log('Вызван метод сортировки по дате, выбрано ' + selectElement.value)
            var rows = document.querySelectorAll("#status-data tbody tr");
            var sortedRows = Array.from(rows);

            if (selectedValue === "fromNewToOld") {
                sortedRows.sort(function(rowA, rowB) {
                    var dateA = new Date(rowA.querySelector(".item-date label").innerText);
                    var dateB = new Date(rowB.querySelector(".item-date label").innerText);
                    return dateA - dateB;
                });
            } else if (selectedValue === "fromOldToNew") {
                sortedRows.sort(function(rowA, rowB) {
                    var dateA = new Date(rowA.querySelector(".item-date label").innerText);
                    var dateB = new Date(rowB.querySelector(".item-date label").innerText);
                    return dateB - dateA;
                });
            }

            var tbody = document.querySelector("#status-data tbody");
            sortedRows.forEach(function(row) {
                tbody.appendChild(row);
            });
        }
        function updateTable() {
            var statusSelect = document.getElementById("statusSelect");
            var dateSelect = document.getElementById("byDateCheckbox");

            var selectedStatus = statusSelect.value;
            var selectedDateSort = dateSelect.value;

            var rows = document.querySelectorAll("#status-data tbody tr");
            var sortedRows = Array.from(rows);

            sortedRows.forEach(function(row) {
                var statusCell = row.querySelector("td:first-child");
                var statusText = statusCell.innerText.trim();
                var statusValue = getStatusValue(statusText);

                if ((!selectedStatus || statusValue === selectedStatus) &&
                    (!selectedDateSort || selectedDateSort === 'fromOldToNew' || selectedDateSort === 'fromNewToOld')) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });

            if (selectedStatus && selectedDateSort) {
                sortedRows.sort(function(rowA, rowB) {
                    var dateA = new Date(rowA.querySelector(".item-date label").innerText);
                    var dateB = new Date(rowB.querySelector(".item-date label").innerText);

                    if (selectedDateSort === "fromNewToOld") {
                        return dateA - dateB;
                    } else if (selectedDateSort === "fromOldToNew") {
                        return dateB - dateA;
                    }
                });

                var tbody = document.querySelector("#status-data tbody");
                tbody.innerHTML = ""; // Очищаем таблицу перед добавлением отсортированных строк

                sortedRows.forEach(function(row) {
                    tbody.appendChild(row);
                });
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            var statusSelect = document.getElementById("statusSelect");
            var dateSelect = document.getElementById("byDateCheckbox");

            statusSelect.addEventListener("change", updateTable); // Добавляем обработчик изменения статуса
            dateSelect.addEventListener("change", updateTable);

            updateTable(); // Вызываем функцию для обновления таблицы сразу после загрузки страницы
        });



        function getStatusValue(statusText) {
            switch(statusText) {
                case "Создано":
                    return "CREATED";
                case "Просмотрено":
                    return "REVIEWED";
                case "Отказано":
                    return "REJECTED";
                case "Утверждено":
                    return "APPROVED";
                case "Повторно отправлено":
                    return "RESUBMITTED";
                default:
                    return "";
            }
        }



        //показ меню
        function showTCRMenu() {
            var topicCreationRequestsMenu = document.getElementById(`tcrequest_menu`);
            var TCRbutton = document.getElementById(`TCRbutton`);
            topicCreationRequestsMenu.classList.toggle('hidden');
            TCRbutton.classList.toggle('disabled');
        }
        function showMenu() {
            var topicRequestsMenu = document.getElementById(`request_menu`);
            var Rbutton = document.getElementById(`Rbutton`);
            topicRequestsMenu.classList.toggle('hidden');
            Rbutton.classList.toggle('disabled');
        }
        function showReviewMenu(tcrId) {
            var reviewMenu = document.getElementById(`hiddenReviewForm-`+tcrId);
            var reviewBtn = document.getElementById(`reviewBtn-`+tcrId);
            reviewMenu.classList.toggle('hidden');
            reviewBtn.classList.toggle('disabled');
        }
        function showDeclineMenu(tcrId){
            var declineMenu = document.getElementById('hiddenDeclineForm-'+tcrId);
            var declineBtn = document.getElementById('declineBtn-'+tcrId);
            declineMenu.classList.toggle('hidden');
            declineBtn.classList.toggle('disabled');
        }

    </script>
</body>
</html>