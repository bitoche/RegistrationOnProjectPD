<style>
    .hidden{
        display: none;
    }
    #topicCreateRequestMenu{
        width: max-content;
        height: max-content;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        background: cornsilk;
        color: black;
        border-color: black;
        border-width: 1px;
        border-style: solid;
        border-radius: 2px;
        margin: 0 auto;
        padding: 10px;
    }
    .disabled {
        pointer-events: none;
        opacity: 0.5;
    }
    .topic-desc-textarea{
        resize: none;
        width: 500px;
        height: 100px;
    }
</style>
<div class="hidden" id="topicCreateRequestMenu">
    <button onclick="showTopicCreateRequestMenu()">Закрыть</button><br/>
    <h3>Заявка на новую тему</h3>
    <form action="/users/topicCreateRequest" method="post">
        <input hidden name="userId" value="${user.getId()}">
        <label>
            Название темы:<br/>
            <input style="width: 500px" name="topicName" />
        </label><br/>
        <label>
            Описание темы:<br/>
            <textarea class="topic-desc-textarea" name="topicDesc">Введите здесь описание вашей темы...</textarea>
        </label><br/>
        <button type="submit">Отправить</button>
    </form>

</div>
<script>
    function showTopicCreateRequestMenu() {
        var topicRequestsMenu = document.getElementById(`topicCreateRequestMenu`);
        var requestedBtn = document.getElementById(`requestBtn`)
        topicRequestsMenu.classList.toggle('hidden');
        requestedBtn.classList.toggle('disabled');
    }
</script>