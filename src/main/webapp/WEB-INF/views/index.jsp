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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link rel="icon" type="/image/png" href="<c:url value='/img/character.png'/>">
    <link rel="stylesheet" href="<c:url value='/css/index.css'/>">
    <title>HOME</title>
</head>
<body>
<div id="wrap">
    <div class="header">
        <div class="nav_box">
            <ul id="left_nav" class="left_nav">
                <li id="home_nav">
                    <a href="<c:url value='/main'/>">🏠Home</a></li>
                <li id="bucket_nav">🍀Bucket List</li>
                <li id="wish_nav">🪐Wish List</li>
                <li id="todo_nav">✨Todo List</li>
                <li id="diary_nav">📖Diary</li>
            </ul>
            <ul class="right_nav">
                <c:choose>
                    <c:when test="${pageContext.request.getSession(false).getAttribute('user_no') == null}">
                        <li id="login_btn">Login</li>
                    </c:when>
                    <c:when test="${pageContext.request.getSession(false).getAttribute('user_no') != null}">
<%--                        <li class="user_name_li">${user_name}님</li>--%>
                        <li id="logout_btn">Logout</li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
    </div>
    <div class="content">
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="swiper_txt_box">
                        <h1>Create and track<br>your bucket list🍀</h1>
                        <div class="go_bucket_btn swiper_btn" onclick="go_bucket()">Get Started</div>
                    </div>
                    <div class="swiper_img_box">
                        <img src="<c:url value='/img/bucket.jpg'/>"  alt="bucket_img">
                    </div>
                </div>
                <div class="swiper-slide">
                    <div class="swiper_txt_box">
                        <h1>Create and track<br>your wish list🪐</h1>
                        <div class="go_wish_btn swiper_btn" onclick="go_wish()">Get Started</div>
                    </div>
                    <div class="swiper_img_box">
                        <img src="<c:url value='/img/wish.jpg'/>"   alt="wish_img">
                    </div>
                </div>
                <div class="swiper-slide">
                    <div class="swiper_txt_box">
                        <h1>Create and track<br>your todo list✨</h1>
                        <div class="go_todo_btn swiper_btn" onclick="go_todo()">Get Started</div>
                    </div>
                    <div class="swiper_img_box">
                        <img src="<c:url value='/img/todo.jpg'/>"   alt="todo_img">
                    </div>
                </div>
                <div class="swiper-slide">
                    <div class="swiper_txt_box">
                        <h1>Create and track<br>your diary📖</h1>
                        <div class="go_diary_btn swiper_btn" onclick="go_diary()">Get Started</div>
                    </div>
                    <div class="swiper_img_box">
                        <img src="<c:url value='/img/diary.jpg'/>"   alt="diary_img">
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            let swiper_slide = $('.swiper-slide').width();
            let img_box = $('.swiper_img_box').width();

            $('.swiper_txt_box').css({
                width: swiper_slide - img_box
            });
        });

        var swiper = new Swiper(".mySwiper", {
            effect: "cards",
            grabCursor: true,
        });
    </script>
</div>
<script>
function go_bucket(){
    $('#bucket_nav').trigger('click');
}
function go_wish(){
    $('#wish_nav').trigger('click');
}
function go_todo(){
    $('#todo_nav').trigger('click');
}
function go_diary(){
    $('#diary_nav').trigger('click');
}

function plz_login(){
    alert("로그인이 필요합니다.");
}

function user_check() {
    if (${pageContext.request.getSession(false).getAttribute('user_no') != null}) {
        return true;
    } else {
        alert("로그인이 필요합니다.");
        $('#login_btn').trigger('click');
        return false;
    }
}

$('#bucket_nav').on("click", function(){
    if(user_check()){
        $.ajax({
            url: '/app/bucket',
            type: 'GET',
            success: function(result){
                $('.content').html(result);
            },
            error: function(xhr, status, error) {
            }
        });
    }
});

$('#wish_nav').on("click", function(){
    if(user_check()) {
        $.ajax({
            url: '/app/wish',
            type: 'GET',
            success: function (data) {
                $('.content').html(data);
            },
            error: function (xhr, status, error) {
            }
        });
    }
});

$('#todo_nav').on("click", function(){
    if(user_check()) {
        $.ajax({
            url: '/app/todo',
            type: 'GET',
            success: function (data) {
                $('.content').html(data);
            },
            error: function (xhr, status, error) {
            }
        });
    }
});

$('#diary_nav').on("click", function(){
    if(user_check()) {
        $.ajax({
            url: '/app/diary',
            type: 'GET',
            success: function (data) {
                $('.content').html(data);
            },
            error: function (xhr, status, error) {
            }
        });
    }
});
$('#login_btn').on("click", function(){
   $.ajax({
      url: '/app/login',
      type: 'GET',
       success: function(data){
           $('.content').html(data);
       },
       error: function(xhr, status, error) {
       }
   });
});
$('#logout_btn').on("click", function(){
    location.href = "/app/logout";
});
</script>
</body>
</html>