package com.bitstudy.app.service;

import com.bitstudy.app.dao.TodoDao;
import com.bitstudy.app.domain.TodoTermDto;
import com.bitstudy.app.domain.TodoTodayDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TodoService {
    @Autowired
    TodoDao todoDao;

    public Integer TodayWrite(TodoTodayDto todoTodayDto){
        return todoDao.TodayWrite(todoTodayDto);
    }

    public Integer TermWrite(TodoTermDto todoTermDto){
        return todoDao.TermWrite(todoTermDto);
    }

    public List<TodoTodayDto> TodayList(Map map){
        return todoDao.TodayList(map);
    }

    public List<TodoTermDto> TermList(Map map){
        return todoDao.TermList(map);
    }

    public Integer TodayStateChg(Map map){
        return todoDao.TodayStateChg(map);
    }

    public Integer TermStateChg(Map map){
        return todoDao.TermStateChg(map);
    }

    public Integer TodayDrop(Integer t_no){
        return todoDao.TodayDrop(t_no);
    }

    public Integer TermDrop(Integer tt_no){
        return todoDao.TermDrop(tt_no);
    }
}
