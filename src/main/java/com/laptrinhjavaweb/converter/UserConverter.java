package com.laptrinhjavaweb.converter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.UserEntity;

@Component
public class UserConverter {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public UserDTO toDto(UserEntity userEntity) {
		UserDTO result = new UserDTO();
		result.setId(userEntity.getId());
		result.setFullName(userEntity.getFullName());
		result.setUserName(userEntity.getUserName());
		result.setStatus(userEntity.getStatus());
		result.setRoleCode(userEntity.getRoles().get(0).getCode());
		return result;
	}

	public UserEntity toEntity(UserDTO userDto) {
		UserEntity result = new UserEntity();
		result.setFullName(userDto.getFullName());
		result.setPassword(passwordEncoder.encode(userDto.getPassword()));
		result.setUserName(userDto.getUserName());
		result.setStatus(userDto.getStatus());
		return result;
	}

	public UserEntity toEntity(UserEntity result, UserDTO userDto){
		result.setFullName(userDto.getFullName());
		result.setUserName(userDto.getUserName());
		if (userDto.getPassword() == null) {
			result.setPassword(userDto.getPassword());
		} else {
			result.setPassword(passwordEncoder.encode(userDto.getPassword()));
		}
		result.setStatus(userDto.getStatus());
		return result;
	}
	
	
}
