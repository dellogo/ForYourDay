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
    <link rel="stylesheet" href="<c:url value='/css/wish_list.css?after'/>">
    <title>WISH</title>
    <script>
        let user_no = ${user_no};
    </script>
</head>
<body>
<div class="wish_content">
    <div class="write_sec">
        <div class="wish_cnt_box">
            <div class="total_box">
                <span class="wish_all_txt">TOTAL</span>
                <span class="wish_all_cnt">${all_cnt}</span>
            </div>
            <div class="count_box">
                <div class="fin_box fin_border">
                    <span class="wish_fin_txt">COMPLETED</span>
                    <span class="wish_fin_cnt">${fin_cnt}</span>
                </div>
                <div class="not_fin_box fin_border">
                    <span class="wish_not_fin_txt">REMAINING</span>
                    <span class="wish_not_fin_cnt"></span>
                </div>
            </div>
        </div>
        <script>
            let all_cnt = $('.wish_all_cnt').text();
            let fin_cnt = $('.wish_fin_cnt').text();
            let not_fin_cnt = (all_cnt - fin_cnt);

            $('.wish_not_fin_cnt').text(not_fin_cnt);
        </script>
        <div class="write_txt">Write You Wish List!</div>
        <textarea id="wish_write" name="w_content" maxlength="200" placeholder="write wish_list here!"></textarea>
        <select name="w_type">
            <option value="Cloth">Cloth</option>
            <option value="Doll">Doll</option>
            <option value="Electronic">Electronic</option>
            <option value="Food">Food</option>
            <option value="Cosmetic">Cosmetic</option>
            <option value="Book">Book</option>
            <option value="Etc">Etc</option>
        </select>
        <div class="wish_write_btn">Add to my Wish List</div>
    </div>
    <div class="content_sec">
        <div class="type_box">
            <div class="type_btn back_color1">📑<br>
                <span class="type_txt">All</span>
            </div>
            <div class="type_btn back_color1">👠<br>
                <span class="type_txt">Cloth</span>
            </div>
            <div class="type_btn back_color1">🧸<br>
                <span class="type_txt">Doll</span>
            </div>
            <div class="type_btn back_color2">🖱️<br>
                <span class="type_txt">Electronic</span>
            </div>
            <div class="type_btn back_color2">🍔<br>
                <span class="type_txt">Food</span>
            </div>
            <div class="type_btn back_color2">💄<br>
                <span class="type_txt">Cosmetic</span>
            </div>
            <div class="type_btn back_color3">📚<br>
                <span class="type_txt">Book</span>
            </div>
            <div class="type_btn back_color3">💫<br>
                <span class="type_txt">Etc</span>
            </div>
        </div>
        <div class="wish_list_box">
        </div>
    </div>
</div>
<script>
    let showList = function() {
        $.ajax({
            type: 'GET',
            url: '/app/wish_list',
            success: function(result){
                $('.wish_list_box').html(toHtml(result));
                chg_cnt();
            },
            error: function(){
                console.log("fail");
            }
        });
    }

    function toHtml(wish_list) {
        let tmp = "";
        wish_list.forEach(function (item) {
            tmp += `<div class="list_item">`;
            if (item.w_state) {
                tmp += '<input type="checkbox" class="w_chk_box" onchange="w_state_chg(this); " name="w_check" checked>';
            } else {
                tmp += '<input type="checkbox" class="w_chk_box" onchange="w_state_chg(this); " name="w_check">';
            }
            if (item.w_type === "Cloth") {
                tmp += `<div class="w_type">👠</div>`;
            } else if(item.w_type === "Doll") {
                tmp += `<div class="w_type">🧸</div>`;
            } else if(item.w_type === "Electronic") {
                tmp += `<div class="w_type">🖱️️</div>`;
            } else if(item.w_type === "Food") {
                tmp += `<div class="w_type">🍔</div>`;
            } else if(item.w_type === "Cosmetic") {
                tmp += `<div class="w_type">💄</div>`;
            } else if(item.w_type === "Book") {
                tmp += `<div class="w_type">📚</div>`;
            } else if(item.w_type === "Etc") {
                tmp += `<div class="w_type">💫️</div>`;
            }
            tmp += `<div class="wish_txt">${'${item.w_content}'}</div>`;
            tmp += `  <input type="text" data-bno="` + item.w_no + '" value="' + item.w_no + '" hidden="hidden" class="w_no">'
            tmp += `  <input type="text" data-bno="` + item.w_no + '" value="' + item.w_type + '" hidden="hidden" class="w_type">'
            tmp += `  <div class="wish_drop_btn" onclick="drop_cnt(this)">x</div>`;
            tmp += `</div>`;
        });
        return tmp;
    }
    function chg_cnt(){
        let fin_cnt = $('input:checkbox[name="w_check"]:checked').length;
        let all_cnt = $('input:checkbox[name="w_check"]').length;
        let not_fin_cnt = (all_cnt - fin_cnt);

        $('.wish_fin_cnt').text(fin_cnt);
        $('.wish_all_cnt').text(all_cnt);
        $('.wish_not_fin_cnt').text(not_fin_cnt);
    }

    function drop_cnt(el) {
        let checked = $(el).siblings('.w_chk_box').prop('checked');
        let all_cnt = Number($('.wish_all_cnt').text());
        let fin_cnt = Number($('.wish_fin_cnt').text());
        let not_fin_cnt = Number($('.wish_not_fin_cnt').text());

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
        $('.wish_all_cnt').text(all_cnt);
        $('.wish_fin_cnt').text(fin_cnt);
        $('.wish_not_fin_cnt').text(not_fin_cnt);
    }

    function w_state_chg(element) {
        let w_no = $(element).siblings('.w_no').data("bno");
        let w_type = $(element).siblings('.w_type').val();
        let checked = $(element).prop('checked');

        let w_state = checked ? 1 : 0;
        $.ajax({
            type: 'PATCH',
            url: '/app/wish_list/' + w_no + '/' + w_state + '/' + w_type,
            data: {w_no: w_no, w_state: w_state, w_type: w_type},
            success: function (result) {
                showList(result);
                chg_cnt();
            },
            error: function () {
                console.log("check error");
            }
        });
    }

    $(document).on('click', '.wish_drop_btn', function() {
        let w_no = $(this).siblings('.w_no').attr("data-bno");
        $.ajax({
            type: 'DELETE',
            url: '/app/wish_list/'+w_no,
            data: { w_no: w_no },
            success: function (result) {
                showList();
            },
            error: function () {
                alert("drop error");
            }
        });
    });

    $('.type_btn').on("click", function(){
        let w_type = $(this).children('.type_txt').text();
        if(w_type == "All"){
            $.ajax({
                type: 'GET',
                url: '/app/wish_list',
                success: function(result){
                    $('.wish_list_box').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });
        }else{
            $.ajax({
                type: 'GET',
                url: '/app/wish_list/'+w_type,
                success: function(result){
                    $('.wish_list_box').html(toHtml(result));
                },
                error: function(){
                    console.log("fail");
                }
            });
        }
    });

    $(document).ready(function() {
        showList();
        $('.wish_write_btn').on('click', function(){
            let all_cnt = Number($('.wish_all_cnt').text()) + 1;
            let not_fin_cnt = Number($('.wish_not_fin_cnt').text()) + 1;

            let wish_write = $('#wish_write').val().trim();
            let wish_type = $('select[name="w_type"]').val();
            if (wish_write == "") {
                alert("위시리스트를 입력하세요");
                $('#wish_write').focus();
                return;
            }
            $.ajax({
                type: 'POST',
                url: '/app/wish_list',
                data: {user_no: ${user_no}, w_content: wish_write, w_type: wish_type},
                success: function(result){
                    $('#wish_write').val("");
                    $('.wish_all_cnt').text(all_cnt);
                    $('.wish_not_fin_cnt').text(not_fin_cnt);
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