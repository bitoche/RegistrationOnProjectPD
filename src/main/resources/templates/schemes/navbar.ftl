<style>
    .adm-func a{
        padding: 5px;
        border-radius: 3px;
        background-color: rgba(222,222,238,0.15);
    }
    .adm-func a:hover{
        background-color: rgba(222,222,238,0.3);
    }
</style>
<nav>
    <div class="left-side">
        <a href="/" class="home-btn">ГЛАВНАЯ</a>
    </div>
    <div class="center">
        <#if user??>
            <#if user.getRole().name()=="MAIN_ADMIN"||user.getRole().name()=="ADMIN">
                <div class="adm-func">
                    <a href="/adm/userList">Управление пользователями</a>
                    <a id="createTopicFormBtn" onclick="showAdmCreateTopicForm()" href="#createTopic">Добавить тему</a>
                    <#include "../adm/createTopic.ftl">
                    <a href="/adm/teams">Команды</a>
                </div>
            </#if>
            <#if user.getRole().name()=="DEV">
                <div class="adm-func">
                    <a href="/dev/">Панель управления</a>
                </div>
            </#if>
            <#if user.getRole().name()=="STUDENT">
                <div class="adm-func">
                    <#include "topicCreateRequest.ftl">
                    <a onclick="showTopicCreateRequestMenu()" id="requestBtn" href="#">Заявка на новую тему</a>
                </div>
            </#if>
        </#if>
    </div>
    <div class="right-side">
        <div class="user-info">
            <#if user??>
                <a style="margin-right: 6px" href="/users/profile/${user.getId()}">${user.getSurname()} ${user.getName()}</a>
                <form method="post" action="/users/logout"><input type="submit" value="Выйти"></form>
            <#else >
                <a href="/users/register">Вход / Регистрация</a>
            </#if>
        </div>
    </div>
</nav>