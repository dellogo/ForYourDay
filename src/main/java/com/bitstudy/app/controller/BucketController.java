package com.bitstudy.app.controller;

import com.bitstudy.app.domain.BucketDto;
import com.bitstudy.app.domain.UserDto;
import com.bitstudy.app.service.BucketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BucketController {
    @Autowired
    BucketService bucketService;

    @GetMapping("/bucket")
    public String getBucketPage(HttpSession session, Model model){
        Integer user_no = (Integer) session.getAttribute("user_no");
        Integer fin_cnt = bucketService.BucketFinCnt(user_no);
        Integer all_cnt = bucketService.BucketAllCnt(user_no);
        model.addAttribute("fin_cnt", fin_cnt);
        model.addAttribute("all_cnt", all_cnt);
        return "bucket_list";
    }

    @GetMapping("/bucket_list")
    @ResponseBody
    public ResponseEntity<List<BucketDto>> BucketList(HttpSession session, Model model) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            List<BucketDto> bucket_list = bucketService.BucketList(user_no);
            model.addAttribute("bucket_list", bucket_list);

            return new ResponseEntity<List<BucketDto>> (bucket_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<BucketDto>> (HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/bucket_list")
    @ResponseBody
    public ResponseEntity<String> BucketWrite(BucketDto bucketDto, HttpSession session) {
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            bucketDto.setUser_no(user_no);

            if(bucketService.BucketWrite(bucketDto) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("등록 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("등록 실패", HttpStatus.BAD_REQUEST);
        }
    }

//    @PatchMapping("/bucket_list/{b_no}/{b_state}")
//    @ResponseBody
//    public ResponseEntity<String> BucketStateChg(@PathVariable Integer b_no , @PathVariable Integer b_state, HttpSession session, Model model){
//        try {
//            Map map = new HashMap();
//            map.put("b_state", b_state);
//            map.put("b_no", b_no);
//
//            if(bucketService.BucketFinState(map) != 1) {
//                throw new Exception("실패");
//            }
//            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
//        }
//    }

    @PatchMapping("/bucket_list/{b_no}/{b_state}/{b_type}")
    @ResponseBody
    public ResponseEntity<String> BucketStateTypeChg(@PathVariable Integer b_no , @PathVariable Integer b_state, @PathVariable String b_type, HttpSession session, Model model){
        try {
            Map map = new HashMap();
            map.put("b_state", b_state);
            map.put("b_no", b_no);
            map.put("b_type", b_type);

            if(bucketService.BucketFinTypeState(map) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/bucket_list/{b_no}")
    @ResponseBody
    public ResponseEntity<String> BucketDrop(@PathVariable Integer b_no, BucketDto bucketDto){
        try {
            if(bucketService.BucketDrop(b_no) != 1) {
                throw new Exception("실패");
            }
            return new ResponseEntity<String> ("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("삭제 실패", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/bucket_list/{b_type}")
    @ResponseBody
    public ResponseEntity<List<BucketDto>> BucketListType(@PathVariable String b_type, HttpSession session, Model model){
        try {
            Integer user_no = (Integer) session.getAttribute("user_no");
            Map map = new HashMap();
            map.put("b_type", b_type);
            map.put("user_no", user_no);

            Integer fin_cnt = bucketService.BucketFinCnt(user_no);
            Integer all_cnt = bucketService.BucketAllCnt(user_no);
            model.addAttribute("fin_cnt", fin_cnt);
            model.addAttribute("all_cnt", all_cnt);

            List<BucketDto> bucket_type_list = bucketService.BucketListType(map);

            model.addAttribute("bucket_type_list", bucket_type_list);

            return new ResponseEntity<List<BucketDto>> (bucket_type_list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<BucketDto>> (HttpStatus.BAD_REQUEST);
        }
    }
}
