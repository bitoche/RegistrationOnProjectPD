<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>userlist</title>
    <style>
        table {
            border-collapse: collapse; /* Используем collapse, чтобы убрать отступы между ячейками */
        }

        td, th {
            padding: 10px; /* Отступ внутри ячеек */
            text-align: center; /* Выравнивание данных по центру */
            border: 1px solid black; /* Границы для ячеек */
        }

        th,td:nth-child(even) {
            background-color: #f2f2f2; /* Делаем каждый четный столбец серым */
        }
    </style>
    <link type="text/css" rel="stylesheet" href="/css/main-navbar.css"/>
</head>
<body>
<#include "*/schemes/navbar.ftl">
    <a href="/dev/">Вернуться назад</a>
    <form action="/dev/adduser" method="post" style="padding: 10px; border-style: solid; border-radius: 5px; border-width: 1px">
        <h3 style="margin: 0 auto">Добавление пользователя в обход системы</h3>
        <div style="display: flex">
            <div style="display: flex; flex-direction: row">
                Логин <input id="username" required name="login">
                <div id="usernameFeedback"></div>
            </div>
            Пароль <input required name="password"><br/>
            Имя <input required name="name"><br/>
            Фамилия <input required name="surname"><br/>
            Роль <select name="role">
                <#if userRoles??>
                    <#list userRoles as ur>
                        <option value="${ur}">${ur}</option>
                    </#list>
                </#if>
            </select>
        </div>
        <summary>
            <details>
                Отчество <input name="patronymic">
                DOB <input type="date" name="birthDate">
                <select name="studyGroup">
                    <option selected value="">Не выбрано</option>
                    <#if studyCourses??>
                        <#list studyCourses as sc>
                            <optgroup label="${sc} курс">
                                <#if studyGroups??>
                                    <#list studyGroups as sg>
                                        <#if sg.course==sc>
                                            <option value="${sg.id}">${sg.name}</option>
                                        </#if>
                                    </#list>
                                </#if>
                            </optgroup>
                        </#list>
                    </#if>
                </select>
            </details>
        </summary>
        <button id="addusersubmit" type="submit">Добавить</button>
    </form>
<table>
    <thead>
        <tr>
            <th>id</th>
            <th>login</th>
            <th>password</th>
            <th>surname</th>
            <th>name</th>
            <th>patronymic</th>
            <th>dob</th>
            <th>stGr</th>
            <th>role</th>
            <th>Возможности</th>
        </tr>
    </thead>
    <tbody>
    <#if users??>
        <#list users as us>
            <tr>
                <td>${us.getId()}</td>
                <td>${us.getLogin()}</td>
                <td>${us.getPassword()}</td>
                <td>${us.getSurname()}</td>
                <td>${us.getName()}</td>
                <#if us.getPatronymic()??>
                    <td>${us.getPatronymic()}</td>
                    <#else >
                        <td></td>
                </#if>
                <#if us.getBirthDate()??>
                    <td>${us.getBirthDate()}</td>
                <#else >
                    <td></td>
                </#if>
                <#if us.getStudyGroup()??>
                    <td>${us.getStudyGroup().getName()}</td>
                <#else >
                    <td></td>
                </#if>
                <td>${us.getRole().name()}</td>
                <td><button onclick="confirmDelete(${us.getId()})">Удалить</button></td>
            </tr>
        </#list>
    </#if>
    </tbody>
</table>
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
        function confirmDelete(userId) {
            var result = confirm("Вы уверены, что хотите удалить пользователя с id " + userId + "?");
            if (result) {
                // Отправка AJAX-запроса на сервер для удаления пользователя
                $.ajax({
                    url: "/dev/users/delete/"+userId,
                    type: "GET",
                    success: function(response) {
                        if (response === "success") {
                            alert("Пользователь успешно удален.");
                            document.location.href = '/dev/userlist';
                        } else {
                            alert("Ошибка при удалении пользователя.");
                        }
                    },
                    error: function() {
                        alert("Ошибка при отправке запроса на сервер.");
                    }
                });
            }
        }
    </script>

</body>
</html>