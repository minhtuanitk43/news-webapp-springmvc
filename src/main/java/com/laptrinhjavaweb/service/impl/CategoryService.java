package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.converter.CategoryConverter;
import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;
import com.laptrinhjavaweb.repository.CategoryRepository;
import com.laptrinhjavaweb.service.ICategoryService;

@Service
public class CategoryService implements ICategoryService {

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private CategoryConverter categoryConverter;

	@Override
	public Map<String, String> mapAll() {
		Map<String, String> result = new HashMap<>();
		List<CategoryEntity> entites = categoryRepository.findAll();
		for (CategoryEntity item : entites) {
			result.put(item.getCode(), item.getName());
		}
		return result;
	}

	@Override
	public List<CategoryDTO> findAll(Pageable pageable) {
		List<CategoryDTO> dtos = new ArrayList<>();
		List<CategoryEntity> entitys = categoryRepository.findAll(pageable).getContent();
		for (CategoryEntity entity : entitys) {
			CategoryDTO dto = categoryConverter.toDto(entity);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public int getTotalItem() {
		return (int) categoryRepository.count();
	}

	@Override
	public CategoryDTO findOne(Long id) {
		CategoryDTO dto = categoryConverter.toDto(categoryRepository.findOne(id));
		return dto;
	}

	@Override
	@Transactional
	public CategoryDTO save(CategoryDTO categoryDto) {
		CategoryEntity entity = new CategoryEntity();
		if (categoryDto.getId() != null) {
			CategoryEntity oldEntity = categoryRepository.findOne(categoryDto.getId());
			entity = categoryConverter.toEntity(oldEntity, categoryDto);
		} else {
			entity = categoryConverter.toEntity(categoryDto);
		}
		return categoryConverter.toDto(categoryRepository.save(entity));
	}

	@Override
	@Transactional
	public void delete(long[] ids) {
		for (long id : ids) {
			categoryRepository.delete(id);
		}
	}

	@Override
	public List<CategoryDTO> findAll() {
		List<CategoryDTO> dtos = new ArrayList<>();
		List<CategoryEntity> entities = categoryRepository.findAll();
		for (CategoryEntity entity : entities) {
			CategoryDTO dto = categoryConverter.toDto(entity);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public CategoryDTO findOneByCode(String code) {
		CategoryEntity entity = categoryRepository.findOneByCode(code);
		return categoryConverter.toDto(entity);
	}

}
