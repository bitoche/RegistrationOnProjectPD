<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Регистрация</title>
    <!-- Bootstrap CSS -->
    <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <style>
        /* Custom CSS */
        .form-container {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-container">
                <h2 class="mb-4">Регистрация</h2>
                <form id="registrationForm" method="post" action="/users/register">
                    <div class="form-group">
                        <label for="username">Логин</label>
                        <input
                                type="text"
                                class="form-control"
                                id="username"
                                name="login"
                                required
                        />
                        <div id="usernameFeedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="password">Пароль</label>
                        <input
                                type="password"
                                class="form-control"
                                id="password"
                                name="password"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Повторите пароль</label>
                        <input
                                type="password"
                                class="form-control"
                                id="confirmPassword"
                                required
                        />
                        <div id="passwordMatchFeedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="firstName">Имя</label>
                        <input
                                type="text"
                                class="form-control"
                                id="firstName"
                                name="name"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="lastName">Фамилия</label>
                        <input
                                type="text"
                                class="form-control"
                                id="lastName"
                                name="surname"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="middleName">Отчество</label>
                        <input
                                type="text"
                                class="form-control"
                                id="middleName"
                                name="patronymic"
                        />
                    </div>
                    <div class="form-group">
                        <label for="dob">Дата Рождения</label>
                        <input type="date" class="form-control" id="dob" name="birthDate" />
                    </div>
                    <div class="form-group">
                        <label for="group">Учебная Группа</label>
                        <select class="form-control" id="group" name="studyGroup">
                            <#if allStudyGroups??>
                                <option selected value="">не выбрано</option>
                                <#list allStudyGroups as gr>
                                    <option value="${gr}">${gr}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                    <button type="submit" disabled class="btn btn-primary">
                        Зарегистрироваться
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        // AJAX check for username availability
        $("#username").on("input", function () {
            var username = $(this).val();
            $.get("/check-username", { username: username })
                .done(function (response) {
                    if (response.available) {
                        $("#usernameFeedback").html('<small class="text-success">Логин доступен</small>');
                        $('button[type="submit"]').removeAttr("disabled");
                    } else {
                        $("#usernameFeedback").html('<small class="text-danger">Логин занят</small>');
                        $('button[type="submit"]').attr("disabled", "disabled");
                    }
                });
        });


        // Check if passwords match on form submission
        $("#registrationForm").submit(function (event) {
            var password = $("#password").val();
            var confirmPassword = $("#confirmPassword").val();
            if (password !== confirmPassword) {
                $("#passwordMatchFeedback").html(
                    '<small class="text-danger">Пароли не совпадают</small>'
                );
                event.preventDefault();
            }
        });
    });
</script>
</body>
</html>
