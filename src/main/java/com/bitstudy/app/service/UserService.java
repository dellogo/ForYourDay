package com.bitstudy.app.service;

import com.bitstudy.app.dao.UserDao;
import com.bitstudy.app.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class UserService {
    @Autowired
    UserDao userDao;

    public Integer Register(UserDto userDto){
        return userDao.Register(userDto);
    }

    public Integer DoubleChk(String user_id){
        return userDao.DoubleChkID(user_id);
    }

    public UserDto Login(Map map){
        return userDao.Login(map);
    }
}
