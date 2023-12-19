package com.bitstudy.app.dao;

import com.bitstudy.app.domain.TodoTermDto;
import com.bitstudy.app.domain.TodoTodayDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class TodoDao {
    @Autowired
    SqlSession session;

    String namespace="com.bitstudy.app.dao.todoMapper.";

    public Integer TodayWrite(TodoTodayDto todoTodayDto){
        return session.insert(namespace+"today_write", todoTodayDto);
    }

    public Integer TermWrite(TodoTermDto todoTermDto){
        return session.insert(namespace+"term_write", todoTermDto);
    }

    public List<TodoTodayDto> TodayList(Map map){
        return session.selectList(namespace+"today_list", map);
    }

    public List<TodoTermDto> TermList(Map map){
        return session.selectList(namespace+"term_list", map);
    }

    public Integer TodayStateChg(Map map){
        return session.update(namespace+"t_state_chg", map);
    }

    public Integer TermStateChg(Map map){
        return session.update(namespace+"tt_state_chg", map);
    }

    public Integer TodayDrop(Integer t_no){
        return session.delete(namespace+"today_remove", t_no);
    }

    public Integer TermDrop(Integer tt_no){
        return session.delete(namespace+"term_remove", tt_no);
    }
}
