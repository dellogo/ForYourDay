package com.bitstudy.app.service;

import com.bitstudy.app.dao.DiaryDao;
import com.bitstudy.app.domain.DiaryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DiaryService {
    @Autowired
    DiaryDao diaryDao;

    public Integer DiaryWrite(DiaryDto diaryDto){
        return diaryDao.DiaryWrite(diaryDto);
    }

    public List<DiaryDto> DiaryList(Map map){
        return diaryDao.DiaryList(map);
    }

    public Integer DiaryDrop(Integer t_no){
        return diaryDao.DiaryDrop(t_no);
    }
}
