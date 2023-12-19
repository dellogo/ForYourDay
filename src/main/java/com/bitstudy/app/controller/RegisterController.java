package com.bitstudy.app.controller;

import com.bitstudy.app.domain.UserDto;
import com.bitstudy.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterController {
    @Autowired
    UserService userService;

    @GetMapping("/register")
    public String getLoginPage(){
        return "register";
    }

    @PostMapping("/register/save")
    public String Register(UserDto userDto, Model model){
        userService.Register(userDto);
        model.addAttribute("mode", "go_login");
        return "login";
    }

    @PostMapping("/register/IdChk/{user_id}")
    public ResponseEntity<Integer> DoubleChkId(@PathVariable String user_id) {
        try {
            int result_count = userService.DoubleChk(user_id);
            if (result_count == 1) {
                return new ResponseEntity<Integer>( result_count, HttpStatus.OK); }
            else if (result_count == 0) {
                return new ResponseEntity<Integer>(0, HttpStatus.OK);
            }
            else {
                return new ResponseEntity<Integer>(-1, HttpStatus.OK);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<Integer> (-1, HttpStatus.BAD_REQUEST);
        }
    }
}
