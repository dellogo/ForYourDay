package com.bitstudy.app.service;

import com.bitstudy.app.dao.BucketDao;
import com.bitstudy.app.domain.BucketDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BucketService {
    @Autowired
    BucketDao bucketDao;

    public Integer BucketWrite(BucketDto bucketDto){
        return bucketDao.BucketWrite(bucketDto);
    }

    public List<BucketDto> BucketList(Integer user_no){
        return bucketDao.BucketList(user_no);
    }

    public Integer BucketDrop(Integer b_no){
        return bucketDao.BucketDrop(b_no);
    }

    public List<BucketDto> BucketListType(Map map){
        return bucketDao.BucketListType(map);
    }

    public Integer BucketFinState(Map map){
        return bucketDao.BucketFinState(map);
    }

    public Integer BucketFinTypeState(Map map){
        return bucketDao.BucketFinTypeState(map);
    }

    public Integer BucketFinCnt(Integer user_no){
        return bucketDao.BucketFinCnt(user_no);
    }

    public Integer BucketAllCnt(Integer user_no){
        return bucketDao.BucketAllCnt(user_no);
    }
}
