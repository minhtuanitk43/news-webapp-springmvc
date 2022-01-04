package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.laptrinhjavaweb.dto.UserDTO;

public interface IUserService {
	List<UserDTO> findAll(Pageable pageable);
	int getTotalItem();
	UserDTO findById(long id);
	UserDTO save(UserDTO userDto);
	void delete(long[] ids);
}
