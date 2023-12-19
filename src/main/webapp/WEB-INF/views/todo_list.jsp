<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page session="false" %>
<c:set var="user_name" value="${ pageContext.request.getSession(false).getAttribute('user_name')==null?'':pageContext.request.getSession(false).getAttribute('user_name')}"/>
<c:set var="user_no" value="${ pageContext.request.getSession(false).getAttribute('user_no')==null?'':pageContext.request.getSession(false).getAttribute('user_no')}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/todo_list.css?after'/>">
    <title>TODO</title>
    <script>
        let user_no = ${user_no};

        let nowMonth = new Date();
        let today = new Date();
        today.setHours(0,0,0,0);

        buildCalendar();
        function buildCalendar() {

            let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);
            let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);

            let tbody_Calendar = document.querySelector(".Calendar > tbody");
            document.getElementById("calYear").innerText = nowMonth.getFullYear();
            document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);

            while (tbody_Calendar.rows.length > 0) {
                tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
            }

            let nowRow = tbody_Calendar.insertRow();

            for (let j = 0; j < firstDate.getDay(); j++) {
                let nowColumn = nowRow.insertCell();
            }

            for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {
                let nowColumn = nowRow.insertCell();
                nowColumn.innerText = leftPad(nowDay.getDate());

                if (nowDay.getDay() == 0) {
                    nowColumn.style.color = "#DC143C";
                }
                if (nowDay.getDay() == 6) {
                    nowColumn.style.color = "#0000CD";
                    nowRow = tbody_Calendar.insertRow();
                }

                nowColumn.className = "Day";
                nowColumn.onclick = function () { choiceDate(this); clickToDay(this); clickTerm(this);}

                if (parseInt(nowColumn.innerText) === today.getDate() &&
                    nowMonth.getMonth() === today.getMonth() &&
                    nowMonth.getFullYear() === today.getFullYear()) {
                    nowColumn.classList.add("choiceDay");
                }
            }
        }

        function clickToDay(nowDate){
            let select_year = parseInt(document.getElementById('calYear').innerText);
            let select_month = parseInt(document.getElementById('calMonth').innerText);
            let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

            let t_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

            $.ajax({
                type: 'GET',
                url: '/app/todo_list/today/'+t_date,
                data: {t_date: t_date},
                success: function(result){
                    $('.today_list').html(toTodayHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });

            $('.today_datepicker').val(t_date);
        }

        function clickTerm(nowDate){
            let select_year = parseInt(document.getElementById('calYear').innerText);
            let select_month = parseInt(document.getElementById('calMonth').innerText);
            let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

            let tt_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

            $.ajax({
                type: 'GET',
                url: '/app/todo_list/term/'+tt_date,
                data: {tt_date: tt_date},
                success: function(result){
                    $('.term_list').html(toTermHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });

            $('.start_term_datepicker').val(tt_date);
            $('.final_term_datepicker').val(tt_date);
        }

        function choiceDate(nowColumn) {
            if (document.getElementsByClassName("choiceDay")[0]) {
                document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
            }
            nowColumn.classList.add("choiceDay");
        }

        function prevCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());
            buildCalendar();
        }

        function nextCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());
            buildCalendar();
        }

        function leftPad(value) {
            if (value < 10) {
                value = "0" + value;
                return value;
            }
            return value;
        }
    </script>
</head>
<body>
<div class="todo_content">
    <div class="calendar_box">
        <div class="today_edit_box display_none">
            <div class="today_back_btn"></div>
            <div class="today_title">Today Goal</div>

            <input type="date" class="today_datepicker">
            <textarea id="t_content" name="t_content" maxlength="150" placeholder="write today_todo_list here!"></textarea>
            <div class="today_edit_fin_btn">Add to My Todo List</div>
        </div>

        <div class="term_edit_box display_none">
            <div class="term_back_btn"></div>
            <div class="term_title">Term Goal</div>
            <div class="date_box">
                <input type="date" class="start_term_datepicker">
                <span class="date_txt">~</span>
                <input type="date" class="final_term_datepicker">
            </div>
            <textarea id="tt_content" name="tt_content" maxlength="150" placeholder="write term_todo_list here!"></textarea>
            <div class="term_edit_fin_btn">Add to My Todo List</div>
        </div>

        <table class="Calendar display_block">
            <thead>
            <tr>
                <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                <td colspan="5">
                    <span id="calYear"></span>년
                    <span id="calMonth"></span>월
                </td>
                <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
            </tr>
            <tr>
                <td>일</td>
                <td>월</td>
                <td>화</td>
                <td>수</td>
                <td>목</td>
                <td>금</td>
                <td>토</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div class="main">
        <div class="today_goal">
            <div class="today_txt">Today Goal
                <div class="today_edit_btn"></div>
            </div>
            <div class="today_list"></div>
        </div>
        <div class="term_goal">
            <div class="term_txt">Term Goal
                <div class="term_edit_btn"></div>
            </div>
            <div class="term_list"></div>
        </div>
    </div>
<script>
    let showTodayList = function() {
        let select_year = parseInt(document.getElementById('calYear').innerText);
        let select_month = parseInt(document.getElementById('calMonth').innerText);
        let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

        let t_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

        $.ajax({
            type: 'GET',
            url: '/app/todo_list/today/'+t_date,
            data: {t_date: t_date},
            success: function(result){
                $('.today_list').html(toTodayHtml(result));
            },
            error: function(){
                console.log("fail");
            }
        });

        if($('.today_datepicker').val() === ""){
            $('.today_datepicker').val(t_date);
        }
    }

    let showTermList = function() {
        let select_year = parseInt(document.getElementById('calYear').innerText);
        let select_month = parseInt(document.getElementById('calMonth').innerText);
        let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

        let tt_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

        var startDate = new Date($('.start_term_datepicker').val());
        var endDate = new Date($('.final_term_datepicker').val());

        if (startDate > endDate) {
            alert("종료 날짜보다 시작 날짜가 큽니다.");
            return false;
        }

        $.ajax({
            type: 'GET',
            url: '/app/todo_list/term/'+tt_date,
            data: {tt_date: tt_date},
            success: function(result){
                $('.term_list').html(toTermHtml(result));
            },
            error: function(){
                console.log("fail");
            }
        });

        if($('.start_term_datepicker').val() === "" || $('.final_term_datepicker').val() === ""){
            $('.start_term_datepicker').val(tt_date);
            $('.final_term_datepicker').val(tt_date);
        }
    }

    function toTodayHtml(todo_list) {
        let tmp = "";
        todo_list.forEach(function (item) {
            tmp += `<div class="list_item">`;
            if (item.t_state) {
                tmp += '<input type="checkbox" class="t_chk_box" onchange="t_state_chg(this); " name="t_check" checked>';
            } else {
                tmp += '<input type="checkbox" class="t_chk_box" onchange="t_state_chg(this); " name="t_check">';
            }
            tmp += `<div class="todo_txt">${'${item.t_content}'}</div>`;
            tmp += `  <input type="text" data-tno="` + item.t_no + '" value="' + item.t_no + '" hidden="hidden" class="t_no">';
            tmp += `  <div class="today_drop_btn" style="cursor: pointer">x</div>`;
            tmp += `</div>`;
        });
        return tmp;
    }

    function toTermHtml(term_list) {
        let tmp = "";
        term_list.forEach(function (item) {
            tmp += `<div class="list_item">`;
            if (item.tt_state) {
                tmp += '<input type="checkbox" class="t_chk_box" onchange="tt_state_chg(this); " name="t_check" checked>';
            } else {
                tmp += '<input type="checkbox" class="t_chk_box" onchange="tt_state_chg(this); " name="t_check">';
            }
            tmp += `<div class="todo_txt">${'${item.tt_content}'}</div>`;
            tmp += `  <input type="text" data-ttno="` + item.tt_no + '" value="' + item.tt_no + '" hidden="hidden" class="tt_no">';
            tmp += `  <div class="term_drop_btn" style="cursor: pointer">x</div>`;
            tmp += `</div>`;
        });
        return tmp;
    }

    function t_state_chg(element) {
        let t_no = $(element).siblings('.t_no').data("tno");
        let checked = $(element).prop('checked');

        let t_state = checked ? 1 : 0;
        $.ajax({
            type: 'PATCH',
            url: '/app/todo_list/today/' + t_no + '/' + t_state,
            data: {t_no: t_no, t_state: t_state},
            success: function (result) {
                showTodayList(result);
            },
            error: function () {
                console.log("check error");
            }
        });
    }

    function tt_state_chg(element) {
        let tt_no = $(element).siblings('.tt_no').data("ttno");
        let checked = $(element).prop('checked');

        let tt_state = checked ? 1 : 0;
        $.ajax({
            type: 'PATCH',
            url: '/app/todo_list/term/' + tt_no + '/' + tt_state,
            data: {tt_no: tt_no, tt_state: tt_state},
            success: function (result) {
                showTermList(result);
            },
            error: function () {
                console.log("check error");
            }
        });
    }

    $(document).on('click', '.today_drop_btn', function(element) {
        let t_no = $(this).siblings('.t_no').attr("data-tno");
        $.ajax({
            type: 'DELETE',
            url: '/app/todo_list/today/'+t_no,
            data: { t_no: t_no },
            success: function (result) {
                showTodayList();
            },
            error: function () {
                alert("drop error");
            }
        });
    });

    $(document).on('click', '.term_drop_btn', function(element) {
        let tt_no = $(this).siblings('.tt_no').attr("data-ttno");
        $.ajax({
            type: 'DELETE',
            url: '/app/todo_list/term/'+tt_no,
            data: { tt_no: tt_no },
            success: function (result) {
                showTermList();
            },
            error: function () {
                alert("drop error");
            }
        });
    });

    $(document).ready(function() {
        showTodayList();
        showTermList();

        $('.today_edit_fin_btn').on('click', function(){
            let t_content = $('#t_content').val().trim();
            let t_date = $('.today_datepicker').val();
            console.log("t_content: "+(t_content));
            console.log("t_date: "+t_date);

            if (t_content === "") {
                alert("투두리스트를 입력하세요");
                $('#t_content').focus();
                return;
            }else if(t_date === ""){
                alert("날짜를 입력하세요");
                $('.today_datepicker').focus();
            }
            $.ajax({
                type: 'POST',
                url: '/app/todo_list/today',
                data: {user_no: ${user_no}, t_date: t_date, t_content: t_content},
                success: function(result){
                    $('#t_content').val("");
                    showTodayList();
                    $('.today_back_btn').trigger('click');
                },
                error: function(result){
                    alert("error");
                    console.log(result);
                }
            });
        });

        $('.term_edit_fin_btn').on('click', function(){
            let tt_content = $('#tt_content').val().trim();
            let tt_start_date = $('.start_term_datepicker').val();
            let tt_fin_date = $('.final_term_datepicker').val();

            if (tt_content === "") {
                alert("투두리스트를 입력하세요");
                $('#tt_content').focus();
                return;
            }else if(tt_start_date === ""){
                alert("시작 날짜를 입력하세요");
                $('.start_term_datepicker').focus();
            }else if(tt_fin_date === ""){
                alert("종료 날짜를 입력하세요");
                $('.final_term_datepicker').focus();
            }
            $.ajax({
                type: 'POST',
                url: '/app/todo_list/term',
                data: {user_no: ${user_no}, tt_start_date: tt_start_date, tt_fin_date: tt_fin_date, tt_content: tt_content},
                success: function(result){
                    $('#tt_content').val("");
                    showTermList();
                    $('.term_back_btn').trigger('click');
                },
                error: function(result){
                    alert("error");
                    console.log(result);
                }
            });
        });

        $('.today_edit_btn').on("click", function () {
            $('.Calendar').addClass('display_none').removeClass('display_block');
            $('.today_edit_box').addClass('display_block').removeClass('display_none');
            $('.term_edit_box').addClass('display_none').removeClass('display_block');
        });
        $('.today_back_btn').on("click", function () {
            $('.Calendar').addClass('display_block').removeClass('display_none');
            $('.today_edit_box').addClass('display_none').removeClass('display_block');
            $('.term_edit_box').addClass('display_none').removeClass('display_block');
        });
        $('.term_edit_btn').on("click", function () {
            $('.Calendar').addClass('display_none').removeClass('display_block');
            $('.today_edit_box').addClass('display_none').removeClass('display_block');
            $('.term_edit_box').addClass('display_block').removeClass('display_none');
        });
        $('.term_back_btn').on("click", function () {
            $('.Calendar').addClass('display_block').removeClass('display_none');
            $('.today_edit_box').addClass('display_none').removeClass('display_block');
            $('.term_edit_box').addClass('display_none').removeClass('display_block');
        });
    });
</script>
</div>
</body>
</html>