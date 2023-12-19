package com.bitstudy.app.dao;

import com.bitstudy.app.domain.DiaryDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DiaryDao {
    @Autowired
    SqlSession session;

    String namespace="com.bitstudy.app.dao.diaryMapper.";

    public Integer DiaryWrite(DiaryDto diaryDto){
        return session.insert(namespace+"diary_write", diaryDto);
    }

    public List<DiaryDto> DiaryList(Map map){
        return session.selectList(namespace+"diary_list", map);
    }

    public Integer DiaryDrop(Integer d_no){
        return session.delete(namespace+"diary_remove", d_no);
    }
}
