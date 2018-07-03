package com.demo.user.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.user.dao.UserDao;
import com.demo.user.entity.User;
import com.demo.user.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
    @Autowired
    UserDao userDao;
    
    public User findById(Integer id) {
        return userDao.findById(id);
    }
    
    public User save(String username, String password) {
        return userDao.save(new User(username , password));
    }
    
    public List<User> findAll() {
        return userDao.findAll();
    }
}