package com.bitstudy.app.controller;

import com.bitstudy.app.domain.DiaryDto;
import com.bitstudy.app.service.DiaryService;
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
public class DiaryController {
    @Autowired
    DiaryService diaryService;

    @GetMapping("/diary")
    public String getDiaryPage(){
        return "diary";
    }

    @GetMapping("/diary_list/{d_date}")
    @ResponseBody
    public ResponseEntity<List<DiaryDto>> DiaryList(@PathVariable String d_date, HttpSession session, Model model) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");

            Map map = new HashMap();
            map.put("user_no", user_no);
            map.put("d_date", d_date);
            List<DiaryDto> today_list = diaryService.DiaryList(map);
            model.addAttribute("today_list", today_list);

            return new ResponseEntity<List<DiaryDto>> (today_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<DiaryDto>> (HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/diary_list")
    @ResponseBody
    public ResponseEntity<String> DiaryListWrite(HttpSession session, DiaryDto diaryDto){
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            diaryDto.setUser_no(user_no);

            if(diaryService.DiaryWrite(diaryDto) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("등록 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("등록 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/diary_list/{d_no}")
    @ResponseBody
    public ResponseEntity<String> DiaryDrop(@PathVariable Integer d_no, DiaryDto diaryDto){
        try {
            if(diaryService.DiaryDrop(d_no) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }
}

