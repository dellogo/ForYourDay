package com.bitstudy.app.dao;

import com.bitstudy.app.domain.BucketDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BucketDao {
    @Autowired
    SqlSession session;

    String namespace="com.bitstudy.app.dao.bucketMapper.";

    public Integer BucketWrite(BucketDto bucketDto){
        return session.insert(namespace+"bucket_write", bucketDto);
    }

    public List<BucketDto> BucketList(Integer user_no){
        return session.selectList(namespace+"bucket_list", user_no);
    }

    public Integer BucketDrop(Integer b_no){
        return session.delete(namespace+"bucket_remove", b_no);
    }

    public List<BucketDto> BucketListType(Map map){
        return session.selectList(namespace+"bucket_type_list", map);
    }

    public Integer BucketFinState(Map map){
        return session.update(namespace+"b_state_chg", map);
    }

    public Integer BucketFinTypeState(Map map){
        return session.update(namespace+"b_state_type_chg", map);
    }

    public Integer BucketFinCnt(Integer user_no){
        return session.selectOne(namespace+"b_state_fin_cnt", user_no);
    }

    public Integer BucketAllCnt(Integer user_no){
        return session.selectOne(namespace+"b_state_all_cnt", user_no);
    }
}
