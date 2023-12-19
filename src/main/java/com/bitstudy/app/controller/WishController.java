package com.bitstudy.app.controller;

import com.bitstudy.app.domain.WishDto;
import com.bitstudy.app.service.WishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class WishController {
    @Autowired
    WishService wishService;

    @GetMapping("/wish")
    public String getDiaryPage(HttpSession session, Model model){
        Integer user_no = (Integer) session.getAttribute("user_no");
        Integer fin_cnt = wishService.WishFinCnt(user_no);
        Integer all_cnt = wishService.WishAllCnt(user_no);
        model.addAttribute("fin_cnt", fin_cnt);
        model.addAttribute("all_cnt", all_cnt);
        return "wish_list";
    }

    @GetMapping("/wish_list")
    @ResponseBody
    public ResponseEntity<List<WishDto>> WishList(HttpSession session, Model model) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            List<WishDto> wish_list = wishService.WishList(user_no);
            model.addAttribute("wish_list", wish_list);

            return new ResponseEntity<List<WishDto>> (wish_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<WishDto>> (HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/wish_list")
    @ResponseBody
    public ResponseEntity<String> WishWrite(WishDto wishDto, HttpSession session) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            wishDto.setUser_no(user_no);

            if(wishService.WishWrite(wishDto) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("등록 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("등록 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @PatchMapping("/wish_list/{w_no}/{w_state}/{w_type}")
    @ResponseBody
    public ResponseEntity<String> WishStateTypeChg(@PathVariable Integer w_no , @PathVariable Integer w_state, @PathVariable String w_type, HttpSession session, Model model){
        try {
            Map map = new HashMap();
            map.put("w_state", w_state);
            map.put("w_no", w_no);
            map.put("w_type", w_type);

            if(wishService.WishFinTypeState(map) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/wish_list/{w_no}")
    @ResponseBody
    public ResponseEntity<String> WishDrop(@PathVariable Integer w_no, WishDto wishDto){
        try {
            if(wishService.WishDrop(w_no) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/wish_list/{w_type}")
    @ResponseBody
    public ResponseEntity<List<WishDto>> WishListType(@PathVariable String w_type, HttpSession session, Model model){
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            Map map = new HashMap();
            map.put("w_type", w_type);
            map.put("user_no", user_no);

            Integer fin_cnt = wishService.WishFinCnt(user_no);
            Integer all_cnt = wishService.WishAllCnt(user_no);
            model.addAttribute("fin_cnt", fin_cnt);
            model.addAttribute("all_cnt", all_cnt);

            List<WishDto> wish_type_list = wishService.WishListType(map);

            model.addAttribute("wish_type_list", wish_type_list);

            return new ResponseEntity<List<WishDto>> (wish_type_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<WishDto>> (HttpStatus.BAD_REQUEST);
        }
    }
}
