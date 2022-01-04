package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.entity.NewEntity;

@Component
public class NewConverter {
	
	public NewDTO toDto(NewEntity newEntity) {
		NewDTO result = new NewDTO();
		result.setId(newEntity.getId());
		result.setTitle(newEntity.getTitle());
		result.setShortDescription(newEntity.getShortDescription());
		result.setContent(newEntity.getContent());
		result.setThumbnail(newEntity.getThumbnail());
		result.setCategoryCode(newEntity.getCategory().getCode());
		result.setCreatedBy(newEntity.getCreatedBy());
		result.setCreatedDate(newEntity.getCreatedDate());
		result.setCategoryName(newEntity.getCategory().getName());
		result.setCategoryId(newEntity.getCategory().getId());
		
		return result;
	}
	
	public NewEntity toEntity(NewDTO newDto) {
		NewEntity result = new NewEntity();
		result.setTitle(newDto.getTitle());
		result.setShortDescription(newDto.getShortDescription());
		result.setContent(newDto.getContent());
		result.setThumbnail(newDto.getThumbnail());
		return result;
	}
	public NewEntity toEntity(NewEntity result, NewDTO newDto) {
		result.setTitle(newDto.getTitle());
		result.setShortDescription(newDto.getShortDescription());
		result.setContent(newDto.getContent());
		if(newDto.getThumbnail() != null) {
			result.setThumbnail(newDto.getThumbnail());
		}
		return result;
	}
}
