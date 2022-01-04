package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.entity.CommentEntity;

@Component
public class CommentConverter {

	public CommentDTO toDto(CommentEntity cmtEntity) {
		CommentDTO result = new CommentDTO();
		result.setUserId(cmtEntity.getUser().getId());
		result.setId(cmtEntity.getId());
		result.setNewId(cmtEntity.getNews().getId());
		result.setContent(cmtEntity.getContent());
		result.setStatus(cmtEntity.getStatus());
		result.setCreatedDate(cmtEntity.getCreatedDate());
		result.setCreatedBy(cmtEntity.getCreatedBy());
		return result;
	}

	public CommentEntity toEntity(CommentDTO commentDto) {
		CommentEntity result = new CommentEntity();
		result.setContent(commentDto.getContent());
		result.setStatus(commentDto.getStatus());
		return result;
	}	
}
