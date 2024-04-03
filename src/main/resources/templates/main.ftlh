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
</head>
<body>
<div class="nav">
    <div class="user-info">
    <#if user??>
            <a href="/users/profile/${user.getId()}">${user.getSurname()} ${user.getName()}</a>
        <form method="post" action="/users/logout"><input type="submit" value="Выйти"></form>
        <#else >
        <a href="/login">Войти</a>
    </#if>
    </div>
    <#if user??>
        <#if user.getRole().MAIN_ADMIN??>
            <div class="adm-func">
                кнопка главного админа
            </div>
        </#if>
    </#if>

</div>
<div class="main-topics-container">
    <#if allTopics??>
        <#if allTopics? has_content>
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
                                ${topic.addingDate?date} <label>утвердил: </label><a href="/user/${topic.approvedUser.id}"> ${topic.approvedUser.surname} ${topic.approvedUser.name} <#if topic.approvedUser.patronymic?has_content>${topic.approvedUser.patronymic}</#if></a>
                            </#if>
                        </div>
                    </div>
                    <div class="element-actions">
                        <label class="booked-text"><#if topic.booked><p style="color: red">Забронирована командой <br/>"<a href="/team/${topic.bookedTeam.id}">${topic.bookedTeam.name}</a>"</p> <#else ><p style="color: green">Свободна</p></#if></label>
                    </div>
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