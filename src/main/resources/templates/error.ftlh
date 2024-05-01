<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ошибка!</title>
</head>
<body>
    <div class="center-div">
        <h3 class="error-title"><strong>Ошибка:</strong> <small><#if tit?? && tit?has_content>${tit} <#else >???</#if></small></h3>
        <div class="error-comm">
            <p class="comm-text">${comm}</p>
        </div>
        <a class="return-btn" href="/">Вернуться на сайт</a>
    </div>
</body>
</html>