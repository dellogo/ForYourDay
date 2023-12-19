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
    <link rel="stylesheet" href="<c:url value='/css/diary.css'/>">
    <title>DIARY</title>
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


                if (nowDay.getDay() === 0) {
                    nowColumn.style.color = "#DC143C";
                }
                if (nowDay.getDay() === 6) {
                    nowColumn.style.color = "#0000CD";
                    nowRow = tbody_Calendar.insertRow();
                }

                nowColumn.className = "Day";
                nowColumn.onclick = function () { choiceDate(this); clickDay(this);}

                if (parseInt(nowColumn.innerText) === today.getDate() &&
                    nowMonth.getMonth() === today.getMonth() &&
                    nowMonth.getFullYear() === today.getFullYear()) {
                    nowColumn.classList.add("choiceDay");
                }
            }
        }

        function clickDay(nowDate){
            let select_year = parseInt(document.getElementById('calYear').innerText);
            let select_month = parseInt(document.getElementById('calMonth').innerText);
            let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

            let d_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

            $.ajax({
                type: 'GET',
                url: '/app/diary_list/'+d_date,
                data: {d_date: d_date},
                success: function(result){
                    $('.diary_list').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });

            $('.diary_datepicker').val(d_date);
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
<div class="diary_content">
    <div class="calendar_box">
        <div class="diary_edit_box display_none">
            <div class="diary_back_btn"></div>
            <div class="diary_title">Diary</div>

            <input type="date" class="diary_datepicker">
            <textarea id="d_content" name="d_content" maxlength="800" placeholder="write diary here!"></textarea>
            <select name="d_condition">
                <option value="Happy">Happy</option>
                <option value="Fun">Fun</option>
                <option value="Sad">Sad</option>
                <option value="Angry">Angry</option>
                <option value="Worry">Worried</option>
            </select>
            <div class="diary_edit_fin_btn">Add to My Diary</div>
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
        <div class="diary">
            <div class="diary_txt">Diary
                <div class="diary_edit_btn"></div>
            </div>
            <div class="diary_list"></div>
        </div>
    </div>
    <script>
        let showList = function() {
            let select_year = parseInt(document.getElementById('calYear').innerText);
            let select_month = parseInt(document.getElementById('calMonth').innerText);
            let select_day = parseInt(document.getElementsByClassName('choiceDay')[0].innerText);

            let d_date = select_year + "-" + leftPad(select_month) + "-" + leftPad(select_day);

            $.ajax({
                type: 'GET',
                url: '/app/diary_list/'+d_date,
                data: {d_date: d_date},
                success: function(result){
                    $('.diary_list').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });

            if($('.diary_datepicker').val() === ""){
                $('.diary_datepicker').val(d_date);
            }
        }

        function toHtml(diary) {
            let tmp = "";
            diary.forEach(function (item) {
                tmp += `<div class="list_item">`;
                if (item.d_condition === "Happy") {
                    tmp += `<div class="d_condition">😊</div>`;
                } else if(item.d_condition === "Fun") {
                    tmp += `<div class="d_condition">😄</div>`;
                } else if(item.d_condition === "Sad") {
                    tmp += `<div class="d_condition">😢</div>`;
                } else if(item.d_condition === "Angry") {
                    tmp += `<div class="d_condition">😠</div>`;
                } else if(item.d_condition === "Worried") {
                    tmp += `<div class="d_condition">😟</div>`;
                }
                tmp += `<div class="diary_inner_txt">${'${item.d_content}'}</div>`;
                tmp += `  <input type="text" data-dno="` + item.d_no + '" value="' + item.d_no + '" hidden="hidden" class="d_no">';
                tmp += `  <div class="diary_drop_btn" style="cursor: pointer">x</div>`;
                tmp += `</div>`;
            });
            return tmp;
        }

        $(document).on('click', '.diary_drop_btn', function(element) {
            let d_no = $(this).siblings('.d_no').attr("data-dno");
            $.ajax({
                type: 'DELETE',
                url: '/app/diary_list/'+d_no,
                data: { d_no: d_no },
                success: function (result) {
                    showList();
                },
                error: function () {
                    alert("drop error");
                }
            });
        });

        $(document).ready(function() {
            showList();

            $('.diary_edit_fin_btn').on('click', function(){
                let d_content = $('#d_content').val().trim();
                let d_condition = $('select[name="d_condition"]').val();
                let d_date = $('.diary_datepicker').val();
                console.log("d_content: "+(d_content));
                console.log("d_condition: "+(d_condition));
                console.log("d_date: "+d_date);

                if (d_content === "") {
                    alert("다이어리 내용을 입력하세요");
                    $('#d_content').focus();
                    return;
                }else if(d_date === ""){
                    alert("날짜를 입력하세요");
                    $('.diary_datepicker').focus();
                }
                $.ajax({
                    type: 'POST',
                    url: '/app/diary_list',
                    data: {user_no: ${user_no}, d_date: d_date, d_content: d_content, d_condition: d_condition},
                    success: function(result){
                        $('#d_content').val("");
                        $('select[name="d_condition"]').val("Happy");
                        showList();
                        $('.diary_back_btn').trigger('click');
                    },
                    error: function(result){
                        alert("error");
                    }
                });
            });

            $('.diary_edit_btn').on("click", function () {
                $('.Calendar').addClass('display_none').removeClass('display_block');
                $('.diary_edit_box').addClass('display_block').removeClass('display_none');
            });
            $('.diary_back_btn').on("click", function () {
                $('.Calendar').addClass('display_block').removeClass('display_none');
                $('.diary_edit_box').addClass('display_none').removeClass('display_block');
            });
        });
    </script>
</div>
</body>
</html>