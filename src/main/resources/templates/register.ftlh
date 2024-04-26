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
                <h2 class="mb-4" style="margin-bottom: 0!important;">Регистрация</h2>
                <label style="color: gray">Уже есть аккаунт? <a style="text-decoration: none" href="/login">Войти</a></label>
                <form id="registrationForm" method="post" action="/users/register">
                    <div class="form-group">
                        <label for="username">Логин <label style="color: red">*</label></label>
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
                        <label for="password">Пароль <label style="color: red">*</label></label>
                        <input
                                type="password"
                                class="form-control"
                                id="password"
                                name="password"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Повторите пароль <label style="color: red">*</label></label>
                        <input
                                type="password"
                                class="form-control"
                                id="confirmPassword"
                                required
                        />
                        <div id="passwordMatchFeedback"></div>
                    </div>
                    <div class="form-group">
                        <label for="firstName">Имя <label style="color: red">*</label></label>
                        <input
                                type="text"
                                class="form-control"
                                id="firstName"
                                name="name"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="lastName">Фамилия <label style="color: red">*</label></label>
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
                                <#if allStudyCourses??>
                                    <#list allStudyCourses?sort as course>
                                        <optgroup label="${course} курс">
                                            <#list allStudyGroups?sort as gr>
                                                <#if gr.course == course>
                                                    <option value="${gr.getId()}">${gr.getName()}</option>
                                                </#if>
                                            </#list>
                                        </optgroup>
                                    </#list>
                                </#if>

                            </#if>
                        </select>
                    </div>
                    <button type="submit" disabled class="btn btn-primary">
                        Зарегистрироваться
                    </button>
                    <button style="right: 100%" onclick="gotoMain()" class="btn btn-danger">
                        Отмена
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
    function gotoMain(){
        document.location.href = '/';
    }
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
