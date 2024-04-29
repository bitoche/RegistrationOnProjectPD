<style>
    .teamrequestdiv{
        padding: 20px;
        border-width: 1px;
        border-style: solid;
        border-color: black;
        margin:2px;
        position: absolute;
        transform: translate(-50%, -50%);
        top: 50%;
        left: 50%;
        z-index: 9999;
        min-width: 300px;
        min-height: max-content;
    }

    .exit-btn{
        display: flex;
        flex-direction: row-reverse;
        text-decoration: none;
        color: red;
        padding: 2px;
        cursor: pointer;
    }
    .exit-btn:hover{
        transition: 0.2s;
        border-style: solid;
        border-width: 1px;
        background: rgba(222,222,222,0.99);
    }
    .requeststable table {
        border-collapse: collapse; /* Используем collapse, чтобы убрать отступы между ячейками */
    }

    .requeststable  td, th {
        padding: 10px; /* Отступ внутри ячеек */
        text-align: center; /* Выравнивание данных по центру */
        border: 1px solid black; /* Границы для ячеек */
    }

    .requeststable  th,td:nth-child(even) {
        background-color: #f2f2f2; /* Делаем каждый четный столбец серым */
    }
    .disabled {
        pointer-events: none;
        opacity: 0.5;
    }
    .hidden{
        display: none;
        transition: 0.5s;
    }
</style>
<button id="in-teamRequestsButton" onclick="showRequests()">Запросы на вступление</button>
<div id="in-teamRequestsContainer" class="teamrequestdiv hidden">
    <a onclick="showRequests()" class="exit-btn">Закрыть</a>
    <#if requestsToTeam??>
        <table class="requeststable">
            <tbody>
            <#list requestsToTeam as req>
                <tr>
                    <td><#--имя человека--></td>
                    <td><#--дата запроса--></td>
                    <td><#--действия--></td>
                </tr>
            </#list>
            </tbody>
        </table>
    <#else>
        Нет входящих запросов.
    </#if>
</div>
<script>
    function showRequests(){
        var inteamRequestsContainer = document.getElementById('in-teamRequestsContainer');
        var inteamRequestsButton = document.getElementById('in-teamRequestsButton');
        inteamRequestsContainer.classList.toggle('hidden');
        inteamRequestsButton.classList.toggle('disabled');
    }
</script>