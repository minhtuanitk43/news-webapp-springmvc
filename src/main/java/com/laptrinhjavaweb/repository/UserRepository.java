package com.laptrinhjavaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
	UserEntity findOneByUserNameAndStatus(String name, int status);
	long countByRolesAndStatus(List<RoleEntity> roles, Integer status);
	long countByRolesAndStatusAndCreatedDateGreaterThan(List<RoleEntity> roles, Integer status, Date createdDate);
}
