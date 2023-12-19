package com.bitstudy.app.controller;

import com.bitstudy.app.domain.TodoTermDto;
import com.bitstudy.app.domain.TodoTodayDto;
import com.bitstudy.app.domain.WishDto;
import com.bitstudy.app.service.TodoService;
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
public class TodoController {
    @Autowired
    TodoService todoService;

    @GetMapping("/todo")
    public String getDiaryPage(){
        return "todo_list";
    }

    @GetMapping("/todo_list/today/{t_date}")
    @ResponseBody
    public ResponseEntity<List<TodoTodayDto>> TodayList(@PathVariable String t_date, HttpSession session, Model model) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");

            Map map = new HashMap();
            map.put("user_no", user_no);
            map.put("t_date", t_date);
            List<TodoTodayDto> today_list = todoService.TodayList(map);
            model.addAttribute("today_list", today_list);

            return new ResponseEntity<List<TodoTodayDto>> (today_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<TodoTodayDto>> (HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/todo_list/term/{tt_date}")
    @ResponseBody
    public ResponseEntity<List<TodoTermDto>> TermList(@PathVariable String tt_date, HttpSession session, Model model) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");

            Map map = new HashMap();
            map.put("user_no", user_no);
            map.put("select_date", tt_date);
            List<TodoTermDto> term_list = todoService.TermList(map);
            model.addAttribute("term_list", term_list);

            return new ResponseEntity<List<TodoTermDto>> (term_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<TodoTermDto>> (HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/todo_list/today")
    @ResponseBody
    public ResponseEntity<String> TodayListWrite(HttpSession session, TodoTodayDto todoTodayDto){
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            todoTodayDto.setUser_no(user_no);

            if(todoService.TodayWrite(todoTodayDto) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("등록 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("등록 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/todo_list/term")
    @ResponseBody
    public ResponseEntity<String> TermListWrite(HttpSession session, TodoTermDto todoTermDto){
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            todoTermDto.setUser_no(user_no);
            System.out.println(todoTermDto);

            if(todoService.TermWrite(todoTermDto) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("등록 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("등록 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @PatchMapping("/todo_list/today/{t_no}/{t_state}")
    @ResponseBody
    public ResponseEntity<String> TodayStateChg(@PathVariable Integer t_no , @PathVariable Integer t_state){
        try {
            Map map = new HashMap();
            map.put("t_state", t_state);
            map.put("t_no", t_no);

            if(todoService.TodayStateChg(map) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @PatchMapping("/todo_list/term/{tt_no}/{tt_state}")
    @ResponseBody
    public ResponseEntity<String> TermStateChg(@PathVariable Integer tt_no , @PathVariable Integer tt_state){
        try {
            Map map = new HashMap();
            map.put("tt_state", tt_state);
            map.put("tt_no", tt_no);

            if(todoService.TermStateChg(map) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/todo_list/today/{t_no}")
    @ResponseBody
    public ResponseEntity<String> TodayDrop(@PathVariable Integer t_no, TodoTodayDto todoTodayDto){
        try {
            if(todoService.TodayDrop(t_no) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/todo_list/term/{tt_no}")
    @ResponseBody
    public ResponseEntity<String> TermDrop(@PathVariable Integer tt_no, TodoTermDto todoTermDto){
        try {
            if(todoService.TermDrop(tt_no) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }
}
