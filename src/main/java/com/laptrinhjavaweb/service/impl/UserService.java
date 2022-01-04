package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.RoleRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IUserService;

@Service
public class UserService implements IUserService {

	@Autowired
	UserRepository userRepository;

	@Autowired
	UserConverter userConverter;

	@Autowired
	RoleRepository roleRepository;

	@Override
	public List<UserDTO> findAll(Pageable pageable) {
		List<UserDTO> result = new ArrayList<>();
		List<UserEntity> entities = userRepository.findAll(pageable).getContent();
		for (UserEntity entity : entities) {
			UserDTO dto = new UserDTO();
			dto = userConverter.toDto(entity);
			result.add(dto);
		}
		return result;
	}

	@Override
	public int getTotalItem() {
		return (int) userRepository.count();
	}

	@Override
	public UserDTO findById(long id) {
		return userConverter.toDto(userRepository.findOne(id));
	}

	@Override
	@Transactional
	public UserDTO save(UserDTO userDto) {
		RoleEntity roleEntity = roleRepository.findOneByCode(userDto.getRoleCode());
		List<RoleEntity> roles = new ArrayList<>();
		roles.add(roleEntity);
		UserEntity userEntity = new UserEntity();
		if (userDto.getId() != null) {
			UserEntity oldEntity = userRepository.findOne(userDto.getId());
			userEntity = userConverter.toEntity(oldEntity, userDto);
		} else {
			userEntity = userConverter.toEntity(userDto);
		}
		userEntity.setRoles(roles);
		return userConverter.toDto(userRepository.save(userEntity));
	}

	@Override
	@Transactional
	public void delete(long[] ids) {
		for (long id : ids) {
			userRepository.delete(id);	
		}
	}

}
