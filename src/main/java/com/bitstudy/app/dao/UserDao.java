package com.bitstudy.app.dao;

import com.bitstudy.app.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class UserDao {
    @Autowired
    SqlSession session;

    String namespace="com.bitstudy.app.dao.userMapper.";

    public Integer Register(UserDto userDto){
        return session.insert(namespace+"register", userDto);
    }

    public Integer DoubleChkID(String user_id){
        return session.selectOne(namespace+"doubleChk_ID", user_id);
    }

    public UserDto Login(Map map){
        return session.selectOne(namespace+"login", map);
    }
}
