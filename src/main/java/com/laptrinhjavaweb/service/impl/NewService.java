package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.converter.NewConverter;
import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;
import com.laptrinhjavaweb.entity.NewEntity;
import com.laptrinhjavaweb.repository.CategoryRepository;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewRepository;
import com.laptrinhjavaweb.service.INewService;

@Service
public class NewService implements INewService {

	@Autowired
	private NewRepository newRepository;

	@Autowired
	private NewConverter newConverter;

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	CommentRepository commentRepository;

	@Override
	public List<NewDTO> findAll(Pageable pageable) {
		List<NewDTO> models = new ArrayList<>();
		List<NewEntity> listNew = newRepository.findAll(pageable).getContent();
		for (NewEntity item : listNew) {
			NewDTO newDTO = newConverter.toDto(item);
			models.add(newDTO);
		}
		return models;
	}

	@Override
	public int getTotalItem() {
		return (int) newRepository.count();
	}

	@Override
	public NewDTO findById(long id) {
		NewEntity newEntity = newRepository.findOne(id);
		return newConverter.toDto(newEntity);
	}

	@Override
	@Transactional
	public NewDTO save(NewDTO newDto) {
		CategoryEntity category = categoryRepository.findOneByCode(newDto.getCategoryCode());
		NewEntity newEntity = new NewEntity();
		if (newDto.getId() != null) {
			NewEntity oldNew = newRepository.findOne(newDto.getId());
			newEntity = newConverter.toEntity(oldNew, newDto);
		} else {
			newEntity = newConverter.toEntity(newDto);
		}
		newEntity.setCategory(category);
		return newConverter.toDto(newRepository.save(newEntity));
	}

	@Override
	@Transactional
	public void delete(long[] ids) {
		for (long id : ids) {
			commentRepository.deleteByNewsId(id);
			newRepository.delete(id);
		}
	}

	@Override
	public List<NewDTO> findAllByCategory(long categoryId, Sort sort) {
		List<NewEntity> entities = newRepository.findAllByCategoryId(categoryId, sort);
		List<NewDTO> dtos = new ArrayList<>();
		for(NewEntity entity : entities) {
			dtos.add(newConverter.toDto(entity));
		}
		return dtos;
	}

	@Override
	public List<NewDTO> findAllByCategory(long categoryId, Pageable pageable) {
		List<NewDTO> dtos = new ArrayList<>();
		List<NewEntity> entities = newRepository.findAllByCategoryId(categoryId, pageable);
		for(NewEntity entity : entities) {
			NewDTO dto = newConverter.toDto(entity);
			dtos.add(dto);
		}
		return dtos;
	}

	@Override
	public int countByCategoryId(long categoryId) {
		return (int) newRepository.countByCategoryId(categoryId);
	}

	@Override
	public List<NewDTO> searchNewsByKeyword(String keyword, Pageable pageable) {
		List<NewDTO> dtos = new ArrayList<>();
		Long categoryId = 0l;
		List<NewEntity> entities;
		List<CategoryEntity> listCategoryEntity = categoryRepository.findAll();
		for(CategoryEntity catEntity: listCategoryEntity) {
			if(catEntity.getKeywords().contains(keyword)) {
				categoryId = catEntity.getId();
				break;
			}
		}
		if(categoryId > 0) {
			entities = newRepository.searchByKeyword(keyword, categoryId, pageable);
		}else {
			entities = newRepository.searchByKeyword(keyword, pageable);
		}
		//get data from Repository	
//Cách sử dụng hàm có sẳn của spring data jpa		
		/*List<NewEntity> entities = newRepository.findByContentContainingIgnoreCase(keyword);
		List<NewEntity> entities2 = newRepository.findByTitleContainingIgnoreCase(keyword);
		
		//merge data
		entities.addAll(entities2);
		
		//remove duplicates
		Map<Long, NewEntity> map = new HashMap<>();
		for(NewEntity e:entities) {
			map.put(e.getId(), e);
		}		
		setEntities = entities.stream().collect(Collectors.toCollection(()-> new TreeSet<>(Comparator.comparing(NewEntity::getId))));
		entities.clear();
		entities = new ArrayList<>(map.values());*/
//Cách sử dụng hàm có sẳn của spring data jpa			
		
		//Convert Entity to DTO
		for(NewEntity entity : entities	) {
			NewDTO dto = newConverter.toDto(entity);
			dtos.add(dto);
		}
		
		return dtos;
	}

	@Override
	public int countSearchNewsByKeyword(String keyword) {
		Long categoryId = 0l;
		List<CategoryEntity> listCategoryEntity = categoryRepository.findAll();
		for(CategoryEntity catEntity: listCategoryEntity) {
			if(catEntity.getKeywords().contains(keyword)) {
				categoryId = catEntity.getId();
				break;
			}
		}
		if(categoryId > 0) {
			return newRepository.countSearchByKeyword(keyword, categoryId);
		}else {
			return newRepository.countSearchByKeyword(keyword);
		}
	}

	@Override
	public void increasedViews(long id) {
		NewEntity newEntity = newRepository.findOne(id);
		newEntity.setViews(newEntity.getViews()+1);
		newRepository.save(newEntity);
	}
}
