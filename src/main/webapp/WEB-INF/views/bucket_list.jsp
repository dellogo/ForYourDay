<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page session="false" %>
<c:set var="user_no" value="${ pageContext.request.getSession(false).getAttribute('user_no')==null?'':pageContext.request.getSession(false).getAttribute('user_no')}"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/bucket_list.css?after'/>">
    <title>BUCKET</title>
    <script>
        let user_no = ${user_no};
    </script>
</head>
<body>
<div class="bucket_content">
    <div class="write_sec">
        <div class="bucket_cnt_box">
            <div class="total_box">
                <span class="bucket_all_txt">TOTAL</span>
                <span class="bucket_all_cnt">${all_cnt}</span>
            </div>
            <div class="count_box">
                <div class="fin_box fin_border">
                    <span class="bucket_fin_txt">COMPLETED</span>
                    <span class="bucket_fin_cnt">${fin_cnt}</span>
                </div>
                <div class="not_fin_box fin_border">
                    <span class="bucket_not_fin_txt">REMAINING</span>
                    <span class="bucket_not_fin_cnt"></span>
                </div>
            </div>
        </div>
        <script>
            let all_cnt = $('.bucket_all_cnt').text();
            let fin_cnt = $('.bucket_fin_cnt').text();
            let not_fin_cnt = (all_cnt - fin_cnt);

            $('.bucket_not_fin_cnt').text(not_fin_cnt);
        </script>
        <div class="write_txt">Write You Bucket List!</div>
        <textarea id="bucket_write" name="b_content" maxlength="200" placeholder="write bucekt_list here!"></textarea>
        <select name="b_type">
            <option value="Travel">Travel</option>
            <option value="Fun">Fun</option>
            <option value="Adventure">Adventure</option>
            <option value="Creative">Creative</option>
            <option value="Skills">Skills</option>
            <option value="Education">Education</option>
            <option value="Personal">Personal</option>
        </select>
        <div class="bucket_write_btn">Add to my Bucket List</div>
    </div>
    <div class="content_sec">
        <div class="type_box">
            <div class="type_btn back_color1">📑<br>
                <span class="type_txt">All</span>
            </div>
            <div class="type_btn back_color1">🧳<br>
                <span class="type_txt">Travel</span>
            </div>
            <div class="type_btn back_color1">🎈<br>
                <span class="type_txt">Fun</span>
            </div>
            <div class="type_btn back_color2">🏂<br>
                <span class="type_txt">Adventure</span>
            </div>
            <div class="type_btn back_color2">🎨<br>
                <span class="type_txt">Creative</span>
            </div>
            <div class="type_btn back_color2">🪄<br>
                <span class="type_txt">Skills</span>
            </div>
            <div class="type_btn back_color3">📚<br>
                <span class="type_txt">Education</span>
            </div>
            <div class="type_btn back_color3">❤️<br>
                <span class="type_txt">Personal</span>
            </div>
        </div>
        <div class="bucket_list_box">
        </div>
    </div>
</div>
<script>
    let showList = function() {
        $.ajax({
            type: 'GET',
            url: '/app/bucket_list',
            success: function(result){
                $('.bucket_list_box').html(toHtml(result));
                chg_cnt();
            },
            error: function(){
                console.log("fail");
            }
        });
    }

    function toHtml(bucket_list) {
        let tmp = "";
        bucket_list.forEach(function (item) {
            tmp += `<div class="list_item">`;
            if (item.b_state) {
                tmp += '<input type="checkbox" class="b_chk_box" onchange="b_state_chg(this)" name="b_check" checked>';
            } else {
                tmp += '<input type="checkbox" class="b_chk_box" onchange="b_state_chg(this)" name="b_check">';
            }
            if (item.b_type === "Travel") {
                tmp += `<div class="b_type_list">🧳</div>`;
            } else if(item.b_type === "Fun") {
                tmp += `<div class="b_type_list">🎈</div>`;
            } else if(item.b_type === "Adventure") {
                tmp += `<div class="b_type_list">🏂</div>`;
            } else if(item.b_type === "Creative") {
                tmp += `<div class="b_type_list">🎨</div>`;
            } else if(item.b_type === "Skills") {
                tmp += `<div class="b_type_list">🪄</div>`;
            } else if(item.b_type === "Education") {
                tmp += `<div class="b_type_list">📚</div>`;
            } else if(item.b_type === "Personal") {
                tmp += `<div class="b_type_list">❤️</div>`;
            }
            tmp += `<div class="bucket_txt">${'${item.b_content}'}</div>`;
            tmp += `  <input type="text" data-bno="` + item.b_no + '" value="' + item.b_no + '" hidden="hidden" class="b_no">'
            tmp += `  <input type="text" data-bno="` + item.b_no + '" value="' + item.b_type + '" hidden="hidden" class="b_type">'
            tmp += `  <div class="bucket_drop_btn" onclick="drop_cnt(this)">x</div>`;
            tmp += `</div>`;
        });
        return tmp;
    }
    function chg_cnt(){
        let fin_cnt = $('input:checkbox[name="b_check"]:checked').length;
        let all_cnt = $('input:checkbox[name="b_check"]').length;
        let not_fin_cnt = (all_cnt - fin_cnt);

        $('.bucket_fin_cnt').text(fin_cnt);
        $('.bucket_all_cnt').text(all_cnt);
        $('.bucket_not_fin_cnt').text(not_fin_cnt);
    }

    function drop_cnt(el) {
        let checked = $(el).siblings('.b_chk_box').prop('checked');
        let all_cnt = Number($('.bucket_all_cnt').text());
        let fin_cnt = Number($('.bucket_fin_cnt').text());
        let not_fin_cnt = Number($('.bucket_not_fin_cnt').text());

        all_cnt--;
        if (checked) {
            fin_cnt--;
            if (not_fin_cnt <= 0) {
                not_fin_cnt = 0;
            }
        } else {
            not_fin_cnt--;
            if (fin_cnt <= 0) {
                fin_cnt = 0;
            }
        }
        $('.bucket_all_cnt').text(all_cnt);
        $('.bucket_fin_cnt').text(fin_cnt);
        $('.bucket_not_fin_cnt').text(not_fin_cnt);
    }

    function b_state_chg(element) {
        let b_no = $(element).siblings('.b_no').data("bno");
        let b_type = $(element).siblings('.b_type').val();
        let checked = $(element).prop('checked');

        let b_state = checked ? 1 : 0;

        $.ajax({
            type: 'PATCH',
            url: '/app/bucket_list/' + b_no + '/' + b_state + '/' + b_type,
            data: {b_no: b_no, b_state: b_state, b_type: b_type},
            success: function (result) {
                showList(result);
                chg_cnt();
            },
            error: function () {
                console.log("check error");
            }
        });
    }

    $(document).on('click', '.bucket_drop_btn', function() {
        let b_no = $(this).siblings('.b_no').attr("data-bno");
        $.ajax({
            type: 'DELETE',
            url: '/app/bucket_list/'+b_no,
            data: { b_no: b_no },
            success: function (result) {
                showList();
            },
            error: function () {
                alert("drop error");
            }
        });
    });

    $('.type_btn').on("click", function(){
        let b_type = $(this).children('.type_txt').text();
        if(b_type == "All"){
            $.ajax({
                type: 'GET',
                url: '/app/bucket_list',
                success: function(result){
                    $('.bucket_list_box').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });
        }else{
            $.ajax({
                type: 'GET',
                url: '/app/bucket_list/'+b_type,
                success: function(result){
                    $('.bucket_list_box').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });
        }
    });

    $(document).ready(function() {
        showList();
        $('.bucket_write_btn').on('click', function(){
            let all_cnt = Number($('.bucket_all_cnt').text()) + 1;
            let not_fin_cnt = Number($('.bucket_not_fin_cnt').text()) + 1;

            let bucket_write = $('#bucket_write').val().trim();
            let bucket_type = $('select[name="b_type"]').val();
            if (bucket_write == "") {
                alert("버킷리스트를 입력하세요");
                $('#bucket_write').focus();
                return;
            }
            $.ajax({
                type: 'POST',
                url: '/app/bucket_list',
                data: {user_no: ${user_no}, b_content: bucket_write, b_type: bucket_type},
                success: function(result){
                    $('#bucket_write').val("");
                    $('select[name="b_type"]').val("Travel");
                    $('.bucket_all_cnt').text(all_cnt);
                    $('.bucket_not_fin_cnt').text(not_fin_cnt);
                    showList();
                },
                error: function(){
                    alert("error");
                }
            });
        });
    });
</script>
</body>
</html>