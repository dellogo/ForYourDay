package com.bitstudy.app.controller;

import com.bitstudy.app.domain.UserDto;
import com.bitstudy.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {
    @Autowired
    UserService userService;

    @GetMapping("/main")
    public String HomePage(){
        return "index";
    }

    @GetMapping("/login")
    public String getLoginPage(){
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }

    @PostMapping("/login")
    public String Login(String user_id, String user_pw, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
        if (!LoginChk(user_id, user_pw)) {
            model.addAttribute("mode", "login");
            return "login";
        }

        Map map = new HashMap();
        map.put("user_id", user_id);
        map.put("user_pw", user_pw);

        UserDto userDto = userService.Login(map);

        HttpSession session = request.getSession();
        session.setAttribute("user_no", userDto.getUser_no());
        session.setAttribute("user_name", userDto.getUser_name());

        return "redirect:/main";
    }


    private boolean LoginChk(String user_id, String user_pw) {
        Map map = new HashMap();
        map.put("user_id", user_id);
        map.put("user_pw", user_pw);

        UserDto userChk = userService.Login(map);
        if (userChk == null) return false;
        return userChk.getUser_pw().equals(user_pw);
    }
}
