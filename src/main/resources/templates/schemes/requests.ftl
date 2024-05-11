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
        flex-direction: column;
    }
    .disabled {
        pointer-events: none;
        opacity: 0.5;
    }
</style>
<link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
<#include "*/schemes/navbar.ftl">
<button id="TCRbutton" onclick="showTCRMenu()">Запросы на новые темы</button>
<div id="tcrequest_menu" class="full-monitor hidden">
    <a href="#"  class="exit-btn" onclick="showTCRMenu()">Закрыть</a>
    <div class="requests-container">
        <#if tcrequests??>
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
<button id="Rbutton" onclick="showMenu()">Запросы на взятие темы</button>
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
</script>