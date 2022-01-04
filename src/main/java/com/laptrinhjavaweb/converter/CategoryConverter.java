package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;

@Component
public class CategoryConverter {
	public CategoryDTO toDto(CategoryEntity entity) {
		CategoryDTO result = new CategoryDTO();
		result.setId(entity.getId());
		result.setName(entity.getName());
		result.setCode(entity.getCode());
		result.setKeyWords(entity.getKeywords());
		return result;
	}
	
	public CategoryEntity toEntity(CategoryDTO dto) {
		CategoryEntity result = new CategoryEntity();	
		result.setName(dto.getName());
		result.setCode(dto.getCode());
		result.setKeywords(dto.getKeyWords());
		return result;
	}

	public CategoryEntity toEntity(CategoryEntity result, CategoryDTO dto) {	
		result.setName(dto.getName());
		result.setCode(dto.getCode());
		result.setKeywords(dto.getKeyWords());
		return result;
	}
}
