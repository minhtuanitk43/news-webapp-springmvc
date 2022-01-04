package com.laptrinhjavaweb.service.impl;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.StatisticalDTO;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewRepository;
import com.laptrinhjavaweb.repository.RoleRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IStatisticalService;

@Service
public class StatisticalService implements IStatisticalService{

	@Autowired
	NewRepository newRepository;
	
	@Autowired
	CommentRepository commentRepository;
	
	@Autowired
	UserRepository userRepository;	
	
	@Autowired
	RoleRepository roleRepository;
	
	@Override
	public StatisticalDTO statistical() {
		StatisticalDTO statisticalDTO = new StatisticalDTO();
		
		//Get date of first day of week
		LocalDate ld = LocalDate.now();
		LocalDate localDate = ld.with(DayOfWeek.MONDAY);
		Calendar cld = Calendar.getInstance();
		cld.set(ld.getYear(),localDate.getMonthValue() - 1, localDate.getDayOfMonth(), 0,0,0);
		Date date = cld.getTime();
		
		statisticalDTO.setTotalNews((int)newRepository.count());
		statisticalDTO.setTotalComment((int) commentRepository.count());
		List<RoleEntity> listRole = new ArrayList<>();
		statisticalDTO.setTotalView(newRepository.countViews());
		
		listRole.add(roleRepository.findOneByCode("AUTHOR"));		
		int totalAuthor = (int)userRepository.countByRolesAndStatus(listRole, SystemConstant.ACTIVE_STATUS);
		int totalAuthorTW = (int)userRepository.countByRolesAndStatusAndCreatedDateGreaterThan(listRole, SystemConstant.ACTIVE_STATUS, date);
		statisticalDTO.setTotalAuthor(totalAuthor);
		
		listRole.clear();
		listRole.add(roleRepository.findOneByCode("USER"));
		int totalUser = (int)userRepository.countByRolesAndStatus(listRole, SystemConstant.ACTIVE_STATUS);
		int totalUserTW = (int)userRepository.countByRolesAndStatusAndCreatedDateGreaterThan(listRole, SystemConstant.ACTIVE_STATUS, date);
		statisticalDTO.setTotalUser(totalUser);
		
		statisticalDTO.setTotalNewsTW((int)newRepository.countByCreatedDateGreaterThan(date));
		statisticalDTO.setTotalCommentTW((int) commentRepository.countByCreatedDateGreaterThan(date));
		statisticalDTO.setTotalUserTW(totalUserTW);
		statisticalDTO.setTotalAuthorTW(totalAuthorTW);
		/*statisticalDTO.setTotalViewTW((int) newRepository.countViewTW(date));*/		
		
		return statisticalDTO;
	}
	
}
