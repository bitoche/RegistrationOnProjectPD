<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация</title>
    <style>
        .register-form {
            margin: 0 auto;
            padding: 10px;
            width: 66%;
            display: flex;
            flex-direction: column;
            border-width: 1px;
            border-style: solid;
            border-radius: 7px;
        }
        .data-input {
            padding: 7px;
            display: flex;
            flex-direction: row;
        }
        .data-input input {
            min-width: 100%;
        }
        .data-input .birthdate {
            min-width: 0;
        }
        .data-input .reduced-input {
            min-width: 0;
            width: 66%;
        }
        .availability-check {
            margin: 0 auto;
        }
        .error-message {
            color: #ff0000;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<form class="register-form" id="registration-form" method="post" action="/users/register">
    <div class="data-input">
        <input class="reduced-input" id="login" name="login" placeholder="Логин">
        <div class="error-message" id="username-error"></div>
    </div>
    <div class="data-input">
        <input name="password" id="password1" placeholder="Пароль">
        <div class="error-message" id="password1-error"></div>
    </div>
    <div class="data-input">
        <input class="reduced-input" id="password2" placeholder="Повторите пароль">
        <div class="error-message" id="password2-error"></div>
    </div>
    <div class="data-input">
        <input name="name" placeholder="Имя">
    </div>
    <div class="data-input">
        <input name="surname" placeholder="Фамилия">
    </div>
    <label>Не обязательно:</label>
    <div class="data-input">
        <input name="patronymic" placeholder="Отчество (при наличии)">
    </div>
    <div class="data-input">
        <label>Дата рождения </label>
        <input class="birthdate" name="birthDate" type="date">
    </div>

    <div class="data-input">
        <label>Учебная группа </label>
        <select name="studyGroup">
            <option selected value="">Не выбрано</option>
            <#if allStudyGroups??>
                <#list allStudyGroups as gr>
                    <option value="${gr}">${gr}</option>
                </#list>
            </#if>
        </select>
    </div>
    <button id="submit-button" type="submit">Зарегистрироваться</button>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $('#registration-form').on('submit', function (event) {
            var login = $('#login').val();
            var password1 = $('#password1').val();
            var password2 = $('#password2').val();

            var errors = [];

            if (!login) {
                $('#username-error').html('Логин не заполнен');
                errors.push('Логин не заполнен');
            } else {
                $('#username-error').html('');
            }

            if (!password1) {
                $('#password1-error').html('Пароль не заполнен');
                errors.push('Пароль не заполнен');
            } else {
                $('#password1-error').html('');
            }

            if (!password2) {
                $('#password2-error').html('Повторите пароль');
                errors.push('Повторите пароль');
            } else {
                $('#password2-error').html('');
            }

            if (password1 !== password2) {
                $('#password2-error').html('Пароли не совпадают');
                errors.push('Пароли не совпадают');
            } else {
                $('#password2-error').html('');
            }

            if (errors.length > 0) {
                event.preventDefault(); // Отменяем отправку формы
            }
        });

        $('#login').on('input', function () {
            var username = $(this).val();
            $.get("/check-username", {username: username}, function (data) {
                if (data) {
                    $('#username-error').text('Логин занят').css('color', '#ff0000');
                    $('#submit-button').prop('disabled', true);
                } else {
                    $('#username-error').text('Логин доступен').css('color', '#008000');
                    $('#submit-button').prop('disabled', false);
                }
            });
        });
    });
</script>

</body>
</html>
