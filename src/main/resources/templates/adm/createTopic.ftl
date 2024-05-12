<style>
    .createTopicDiv{
        position: absolute;
        left: 50%;
        top:50%;
        transform: translate(-50%, -50%);
        padding: 10px;
        border-width: 1px;
        border-style: solid;
        border-color: black;
        overflow: auto;
        max-width: 66vw;
        max-height: 66vh;
        min-width: 66vw;
        font-size: large;
        z-index: 10001;
        background: white;
        display: flex;
        flex-direction: column;
    }
    .createTopicDiv label{
        color: black!important;
    }
    .createTopicDiv textarea{
        max-width: 66%;
        min-width: 66%;
        max-height: 66%;
        min-height: 66%;
    }
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
        color: red!important;
        padding: 2px;
    }
    .exit-btn:hover{
        transition: 0.2s;
        border-style: solid;
        border-width: 1px;
        background: rgba(222,222,222,0.99)!important;
    }
</style>
<div id="createTopicDiv" class="createTopicDiv hidden">
    <a class="exit-btn" onclick="showAdmCreateTopicForm()">Закрыть</a>
    <form action="/adm/createTopic" method="post">
        <label>
            Название темы
            <input name="title" />
        </label>
        <br/>
        <label>
            Описание темы
            <textarea name="description"></textarea>
        </label>
        <br/>
        <button type="submit">Добавить</button>
    </form>
</div>

<script>
    function showAdmCreateTopicForm() {
        var createTopicForm = document.getElementById('createTopicDiv');
        var createTopicFormBtn = document.getElementById('createTopicFormBtn');
        createTopicForm.classList.toggle('hidden');
        createTopicFormBtn.classList.toggle('disabled');
    }
</script>