<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Пользователи - РНП</title>
    <style>
        .roleMenu {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #000000;
            z-index: 9999;
        }

        .hidden {
            display: none;
        }

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
<h2 style="color: red"><#if err??>${err}</#if></h2>
<table id="table">
    <thead>
    <tr>
        <th datatype="text">Фамилия</th>
        <th datatype="text">Имя</th>
        <th datatype="text">Отчество</th>
        <th datatype="date">Дата рождения</th>
        <th datatype="text">Роль</th>
        <th>Действие</th>
    </tr>
    </thead>
    <tbody>
    <#list userList?sort_by("id") as u>
        <tr>
            <td>${u.getSurname()!''}</td>
            <td>${u.getName()!''}</td>
            <td>${u.getPatronymic()!''}</td>
            <td><#if u.getBirthDate()??>${u.getBirthDate()?date!''}</#if></td>
            <td>${u.getRole()}</td>
            <td><a <#if u.getRole()!="DEV">onclick="showRoleMenu('${u.getId()}')"</#if>  style="cursor: pointer;<#if u.getRole()!="DEV"> color: #0d6efd</#if>">Сменить роль</a></td>
        </tr>
        <tr id="roleMenu_${u.getId()}" class="hidden roleMenu">
            <td colspan="6">
                <h3>Смена роли</h3>
                <form method="post" action="/adm/changerole">
                    <label>
                        Пользователь
                        <input hidden name="userId" readonly value="${u.getId()}">
                        <input placeholder="${u.getSurname()} ${u.getName()} ${u.getPatronymic()} (${u.getId()})"/>
                    </label>
                    <select name="role">
                        <#if userRoles??>
                            <#list userRoles as ur>
                                <#if ur.name()!= "DEV">
                                    <option <#if u.getRole() == ur>selected</#if> value="${ur.name()}">${ur.name()}</option>
                                </#if>
                            </#list>
                        </#if>
                    </select>
                    <button type="submit">Подтвердить</button>
                </form>
            </td>
        </tr>
    </#list>
    </tbody>
</table>

<script>
    function showRoleMenu(userId) {
        var roleMenu = document.getElementById(`roleMenu_`+ userId);
        roleMenu.classList.toggle('hidden');
    }
    document.addEventListener("DOMContentLoaded", function() {
        var table = document.getElementById("table");
        var tbody = table.querySelector("tbody");
        var ths = table.querySelectorAll("th");

        function sortTable(columnIndex) {
            var rows = Array.from(tbody.querySelectorAll("tr"));

            rows.sort(function(rowA, rowB) {
                var cellA = rowA.cells[columnIndex].textContent.trim();
                var cellB = rowB.cells[columnIndex].textContent.trim();
                return cellA.localeCompare(cellB);
            });

            tbody.innerHTML = "";
            rows.forEach(function(row) {
                tbody.appendChild(row);
            });
        }

        ths.forEach(function(th, index) {
            th.addEventListener("click", function() {
                sortTable(index);
            });
        });
    });




</script>
</body>
</html>
