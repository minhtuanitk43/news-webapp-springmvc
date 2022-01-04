package com.laptrinhjavaweb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.repository.RoleRepository;
import com.laptrinhjavaweb.service.IRoleService;

@Service
public class RoleService implements IRoleService {

	@Autowired
	RoleRepository roleRepository;
	
	@Override
	public Map<String, String> mapAll() {
		Map<String, String> result = new HashMap<>();
		List<RoleEntity> entites = roleRepository.findAll();
		for (RoleEntity item : entites) {
			result.put(item.getCode(), item.getName());
		}
		return result;
	}
}
