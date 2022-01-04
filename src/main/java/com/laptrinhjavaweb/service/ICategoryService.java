package com.laptrinhjavaweb.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import com.laptrinhjavaweb.dto.CategoryDTO;

public interface ICategoryService {
	Map<String, String> mapAll();
	List<CategoryDTO> findAll(Pageable pageable);
	List<CategoryDTO> findAll();
	int getTotalItem();
	CategoryDTO findOne(Long id);
	CategoryDTO findOneByCode(String code);
	CategoryDTO save(CategoryDTO categoryDto);
	void delete(long[] ids);
}
