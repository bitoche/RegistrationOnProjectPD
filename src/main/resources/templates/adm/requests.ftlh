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
    </style>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "*/schemes/navbar.ftl">
    <button id="TCRbutton" class="disabled" onclick="showTCRMenu()">Запросы на создание новых тем <small style="color: green;"><#if tcrequests?has_content>+ ${tcrequests?size}</#if></small></button>
    <div id="tcrequest_menu" class="full-monitor">
        <a href="#"  class="exit-btn" onclick="showTCRMenu()">Закрыть запросы на создание тем</a>
        <div class="requests-container">
            <#if tcrequests??>
                <#--todo добавить вывод с категориями по группам (статусу TCRS)-->
                <#if tcrequests?has_content>
                    <#list tcrequests as tcr>
                        <div class="request-item">
                            <label>
                                Дата запроса:
                                ${tcr.getRequestDate()?date}
                            </label>
                            <label>
                                Пользователь:
                                <a href="/user/${tcr.getRequestingUser().getId()}">${tcr.getRequestingUser().getSurname()} ${tcr.getRequestingUser().getName()} ${tcr.getRequestingUser().getPatronymic()}</a>
                            </label>
                            <label>
                                Тема:
                                <label class="tcr-title">
                                    ${tcr.getTopicName()}
                                </label>
                                <textarea readonly class="tcr-desc">${tcr.getTopicDescription()}</textarea>
                            </label>
                            <a href="/adm/approveTopic/${tcr.getId()}">Утвердить</a>
                            <a href="#review#" onclick="showReviewMenu(${tcr.getId()})" id="reviewBtn-${tcr.getId()}">Оставить комментарий</a>
                            <div id="hiddenReviewForm-${tcr.getId()}" class="hrf hidden">
                                <a href="#"  class="exit-btn" onclick="showReviewMenu(${tcr.getId()})">Отменить</a>
                                <form action="/adm/reviewTopic" method="post">
                                    <textarea name="comm" style="width: max-content; height: 100px" placeholder="Комментарий"></textarea>
                                    <input hidden name="tcrId" value="${tcr.getId()}">
                                    <button type="submit">Отправить</button>
                                </form>
                            </div>
                            <#--todo добавить кнопку отмены с комментарием, и автоматическое изменение статуса заявки-->
                            <#if tcr_has_next><hr></#if>
                        </div>
                    </#list>
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
                    <#list requestsOnTopics as rot>
                        <div class="request-item">
                            <#if rot_has_next><hr></#if>
                        </div>
                    </#list>
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
    </script>
</body>
</html>