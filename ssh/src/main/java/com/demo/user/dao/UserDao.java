package com.demo.user.dao;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.demo.user.entity.User;

public interface UserDao extends JpaRepository<User, Serializable>{
	
	@Query("from User where id = :id")
	User findById(@Param("id")Integer id);
}