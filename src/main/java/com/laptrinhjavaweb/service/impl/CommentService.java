package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.CommentConverter;
import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.ICommentService;

@Service
public class CommentService implements ICommentService{
	
	@Autowired
	CommentRepository commentRepository;
	
	@Autowired
	CommentConverter commentConverter;
	
	@Autowired
	UserRepository useRepository;
	
	@Autowired
	NewRepository newRepository;
	
	@Autowired
	UserRepository userRepository;

	@Override
	public List<CommentDTO> findAllByNewsId(long news_id, Sort sort) {
		List<CommentEntity> entities = commentRepository.findAllByNewsId(news_id, sort);
		List<CommentDTO> dtos = new ArrayList<>();
		for(CommentEntity entity : entities) {
			CommentDTO dto = new CommentDTO();
			dto = commentConverter.toDto(entity);
			UserEntity user = useRepository.getOne(entity.getUser().getId());
			dto.setUserName(user.getFullName());
			dtos.add(dto);
		}
		return dtos;
	}
	
	@Transactional
	@Override
	public CommentDTO save(CommentDTO commentDto) {
		CommentEntity entity = commentConverter.toEntity(commentDto);
		entity.setNews(newRepository.findOne(commentDto.getNewId()));
		entity.setUser(userRepository.findOneByUserNameAndStatus(commentDto.getUserName(), SystemConstant.ACTIVE_STATUS));
		entity.setStatus(SystemConstant.ACTIVE_STATUS);
		entity = commentRepository.save(entity);
		CommentDTO cmtDto = commentConverter.toDto(entity);
		cmtDto.setUserName(entity.getUser().getFullName());
		return cmtDto;
	}
	
	@Transactional
	@Override
	public void delete(long[] ids) {
		for(long id:ids) {
			commentRepository.delete(id);
		}
	}

	@Override
	public List<CommentDTO> findAll(Pageable pageable) {
		List<CommentEntity> entities = commentRepository.findAll(pageable).getContent();
		List<CommentDTO> dtos = new ArrayList<>();
		for(CommentEntity entity : entities) {
			CommentDTO dto = new CommentDTO();
			dto = commentConverter.toDto(entity);
			UserEntity user = useRepository.getOne(entity.getUser().getId());
			dto.setUserName(user.getFullName());
			dtos.add(dto);
		}
		return dtos;
	}
	
	@Transactional
	@Override
	public void updateStatusComment(Long id) {
		CommentEntity entity = commentRepository.findOne(id);
		entity.setStatus(SystemConstant.INACTIVE_STATUS);
		commentRepository.save(entity);
	}

}
