package com.bitstudy.app.dao;

import com.bitstudy.app.domain.WishDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class WishDao {
    @Autowired
    SqlSession session;

    String namespace="com.bitstudy.app.dao.wishMapper.";

    public Integer WishWrite(WishDto wishDto){
        return session.insert(namespace+"wish_write", wishDto);
    }

    public List<WishDto> WishList(Integer user_no){
        return session.selectList(namespace+"wish_list", user_no);
    }

    public Integer WishDrop(Integer w_no){
        return session.delete(namespace+"wish_remove", w_no);
    }

    public List<WishDto> WishListType(Map map){
        return session.selectList(namespace+"wish_type_list", map);
    }

    public Integer WishFinState(Map map){
        return session.update(namespace+"w_state_chg", map);
    }

    public Integer WishFinTypeState(Map map){
        return session.update(namespace+"w_state_type_chg", map);
    }

    public Integer WishFinCnt(Integer user_no){
        return session.selectOne(namespace+"w_state_fin_cnt", user_no);
    }

    public Integer WishAllCnt(Integer user_no){
        return session.selectOne(namespace+"w_state_all_cnt", user_no);
    }
}
