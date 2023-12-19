package com.bitstudy.app.service;

import com.bitstudy.app.dao.WishDao;
import com.bitstudy.app.domain.WishDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WishService {
    @Autowired
    WishDao wishDao;

    public Integer WishWrite(WishDto wishDto){
        return wishDao.WishWrite(wishDto);
    }

    public List<WishDto> WishList(Integer user_no){
        return wishDao.WishList(user_no);
    }

    public Integer WishDrop(Integer w_no){
        return wishDao.WishDrop(w_no);
    }

    public List<WishDto> WishListType(Map map){
        return wishDao.WishListType(map);
    }

    public Integer WishFinState(Map map){
        return wishDao.WishFinState(map);
    }

    public Integer WishFinTypeState(Map map){
        return wishDao.WishFinTypeState(map);
    }

    public Integer WishFinCnt(Integer user_no){
        return wishDao.WishFinCnt(user_no);
    }

    public Integer WishAllCnt(Integer user_no){
        return wishDao.WishAllCnt(user_no);
    }
}
