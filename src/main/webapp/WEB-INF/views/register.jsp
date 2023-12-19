<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/register.css?after'/>">
    <title>REGISTER</title>
</head>
<body>
<div class="register_content">
    <form action="" id="register_frm">
        <input type="text" name="user_id" placeholder="Id" class="id_box">
        <input type="text" name="user_name" placeholder="Name" class="name_box">
        <input type="password" name="user_pw" placeholder="Password" class="pw_box">
        <input type="password" name="user_pw_chk" placeholder="Password Check" class="pw_check_box">
        <input type="date" name="user_birth" class="birth_box">
        <input type="button" class="signup_btn" value="Sign In">
    </form>
</div>
<script>
    function pw_Chk(){
        let user_pw = $('input[name="user_pw"]').val();
        let user_pw_chk = $('input[name="user_pw_chk"]').val();

        return user_pw == user_pw_chk;
    }

    function userAddValid() {
        let user_id = $('input[name="user_id"]').val();
        let user_name = $('input[name="user_name"]').val();
        let user_birth = $('input[name="user_birth"]').val();

        if (user_id === "") {
            alert("아이디를 입력해주세요");
            return false;
        }else if(user_name === "") {
            alert("이름을 입력해주세요");
            return false;
        }else if(user_birth === "") {
            alert("생일을 입력해주세요");
            return false;
        }else if(user_id.includes(" ") || user_name.includes(" ") || user_birth.includes(" ")){
            alert("빈칸 입력 불가");
            return false;
        }else{
            return true;
        }
    }

    $('.signup_btn').on("click", function(){
        let user_id = $('input[name="user_id"]').val();
        let user_name = $('input[name="user_name"]').val();
        let user_pw = $('input[name="user_pw"]').val();
        let user_birth = $('input[name="user_birth"]').val();

        if (!pw_Chk()) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        if(userAddValid()){
            $.ajax({
                type: "POST",
                url: '/app/register/IdChk/' + user_id,
                headers: { "content-type": "application/json" },
                data: JSON.stringify(user_id),
                dataType: 'text',
                success: function(result) {
                    if (result == 1) {
                        alert("이미 사용중인 아이디입니다.");
                    } else if (result == 0) {
                        alert("사용 가능한 아이디입니다.");
                        $.ajax({
                            type: "POST",
                            url: '/app/register/save',
                            data: {
                                user_id: user_id,
                                user_name: user_name,
                                user_pw: user_pw,
                                user_birth: user_birth
                            },
                            success: function(result) {
                                console.log("result: " + result);
                                location.href = "/app/"
                            },
                            error: function() {
                                console.log("fail");
                                console.log(user_id, user_name, user_pw, user_birth);
                            }
                        });
                    }
                },
                error: function(error) {
                    alert("에러 발생");
                    console.error(error);
                }
            });
        }
    });
</script>
</body>
</html>