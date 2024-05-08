<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Регистрация на проект</title>
    <style>
        .main-topics-container{
            width: 66%;
            display: flex;
            flex-direction: column;
            margin: 0 auto;
        }
        .topic-list-element{
            border-style: solid;
            border-radius: 10px;
            border-width: 1px;
            border-color: #676458;
            padding: 5px;
            margin: 5px;

            display: flex;
            flex-direction: row;
            align-items: center;
        }
        .element-data{
            width: 80%;
            max-width: 50vw;
            display: flex;
            flex-direction: column;
            align-content: center;
            align-items: center;
        }

        .element-title{
            font-size: larger;
            font-weight: bold;
            text-decoration: none;
        }
        .desc-container{
            width: 90%;
            display: flex;
            flex-direction: column;
        }
        p.element-description{
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1; /* Number of lines to show before ellipsis */
            -webkit-box-orient: vertical;
            text-align: justify;
            margin:0;
        }
        span.more{
            color: blue;
            cursor: pointer;
            display: none;
        }
        .element-actions{
            height: 100px;
            border-left: thick solid #1a1a1a;
            border-left-width: 1px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-width: 20%;
            max-width: 20%;
        }
        .booked-text{
            text-align: center;
        }
    </style>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "schemes/navbar.ftl">
<div class="main-topics-container">
    <#if user??>
        <#if user.getRole().name()=="MAIN_ADMIN"||user.getRole().name()=="ADMIN">
            <a href="/adm/requests">Запросы</a>
        </#if>
    </#if>

    <#if allTopics??>
        <#if allTopics?has_content>
            <#list allTopics as topic>
                <div class="topic-list-element">
                    <div class="element-data">
                        <a class="element-title" href="/topic/${topic.id}">${topic.name}</a>
                        <div class="desc-container">
                            <p class="element-description">${topic.description}</p>
                            <span class="more">Показать ещё</span>
                        </div>
                        <div class="element-about">
                            <#if topic.approvedUser??>
                                ${topic.addingDate?date} <label>утвердил: </label><a href="/users/profile/${topic.approvedUser.id}"> ${topic.approvedUser.surname} ${topic.approvedUser.name} <#if topic.approvedUser.patronymic?has_content>${topic.approvedUser.patronymic}</#if></a>
                            </#if>
                        </div>
                    </div>
                    <div class="element-actions">
                        <label class="booked-text"><#if topic.booked><p style="color: red">Забронирована командой <br/>"<a href="/team/${topic.bookedTeam.id}">${topic.bookedTeam.name}</a>"</p> <#else ><p style="color: green">Свободна</p></#if></label>
                    </div>
                    <#if user?? && user.getRole().name()!="STUDENT">
                        <a href="/adm/deleteTopic/${topic.getId()}">УДАЛЕНИЕ(без подтверждения)</a>
                    </#if>
                </div>
            </#list>
        <#else >
            Здесь пока нет тем.
        </#if>
    </#if>

</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.more').forEach(item => {
            item.addEventListener('click', event => {
                const description = event.target.previousElementSibling;
                description.style.webkitLineClamp = description.style.webkitLineClamp === '3' ? 'initial' : '3';

                if (description.style.webkitLineClamp !== '3') {
                    event.target.style.display = 'none'; // Скрыть кнопку, если весь текст отображается
                }
            });
        });

        document.querySelectorAll('.element-description').forEach(item => {
            if (item.scrollHeight > item.clientHeight) {
                item.nextElementSibling.style.display = 'inline'; // Показать кнопку, если текст обрезан
            }
        });
    });
</script>
</body>
</html>