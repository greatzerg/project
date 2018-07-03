package com.demo.user.service;

import java.util.List;

import com.demo.user.entity.User;

public interface UserService {
    User findById(Integer id);
    User save(String username ,String password);
    List<User> findAll();
}