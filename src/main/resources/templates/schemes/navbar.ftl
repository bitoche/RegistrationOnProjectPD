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
                <a href="/users/register">Зарегистрироваться</a>
            </#if>
        </div>
    </div>
</nav>