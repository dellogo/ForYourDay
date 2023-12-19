<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/login.css?after'/>">
    <link rel="stylesheet" href="<c:url value='/css/index.css'/>">
    <title>LOGIN</title>
</head>
<body>
<c:choose>
    <c:when test="${mode == 'login'}">
<div id="wrap">
    <div class="header">
        <div class="nav_box">
            <ul id="left_nav" class="left_nav">
                <li id="bucket_nav" onclick="plz_login()">🍀Bucket List</li>
                <li id="wish_nav" onclick="plz_login()">🪐Wish List</li>
                <li id="todo_nav" onclick="plz_login()">✨Todo List</li>
                <li id="diary_nav" onclick="plz_login()">📖Diary</li>
            </ul>
            <ul class="right_nav">
                <c:choose>
                    <c:when test="${pageContext.request.getSession(false).getAttribute('user_no') == null}">
                        <li id="login_btn">Login</li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
    </div>
    <div class="content">
        <script>
            alert("일치하는 회원 정보가 없습니다.");
        </script>
    </c:when>
</c:choose>
<div class="login_content">
    <div class="welcome_txt">WELCOME!</div>
    <form action="" id="login_frm">
        <input type="text" name="user_id" placeholder="Id" class="id_box">
        <input type="password" name="user_pw" placeholder="Password" class="pw_box">
        <input type="button" class="login_btn" value="Log In" onclick="login()">
    </form>
    <div class="signup_box">
        <span class="left_txt">Need an account?</span>
        <span class="go_signup_btn">Sign Up</span>
    </div>
</div>
<c:choose>
    <c:when test="${mode == 'login'}">
    </div>
</div>
    </c:when>
</c:choose>
<script>
    function plz_login(){
        alert("로그인이 필요합니다.");
    }

    function login(){
        let login_frm = $('#login_frm');
        login_frm.attr('action', "<c:url value='/login'/>");
        login_frm.attr('method', 'post');
        login_frm.submit();
    }

    $('.go_signup_btn').on("click", function(){
        $.ajax({
            url: '/app/register',
            type: 'GET',
            success: function(result){
                $('.content').html(result);
            },
            error: function(xhr, status, error) {
            }
        });
    });

</script>
</body>
</html>