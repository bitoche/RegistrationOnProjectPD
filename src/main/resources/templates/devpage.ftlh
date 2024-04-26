<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>devpage</title>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "schemes/navbar.ftl">
    <br/><br/>
    <a style="margin: 10px; font-size: large" href="/dev/userlist">Список пользователей</a>
    <a href="/dev/addtopic">Добавить тему</a>
    <a href="/dev/addteam">Создать команду</a>

    <a href="/dev/topiclist">Список тем</a>
    <a href="/dev/teamlist">Список команд</a>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script>
    $(document).ready(function () {
        // AJAX check for username availability
        $("#username").on("input", function () {
            var username = $(this).val();
            $.get("/check-username", { username: username })
                .done(function (response) {
                    if (response.available) {
                        $("#usernameFeedback").html('<small class="text-success">Логин доступен</small>');
                        $('button[id="addusersubmit"]').removeAttr("disabled");
                    } else {
                        $("#usernameFeedback").html('<small class="text-danger">Логин занят</small>');
                        $('button[id="addusersubmit"]').attr("disabled", "disabled");
                    }
                });
        });
    })
</script>
</body>
</html>