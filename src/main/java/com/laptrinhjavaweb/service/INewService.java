package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.laptrinhjavaweb.dto.NewDTO;

public interface INewService {
	List<NewDTO> findAll(Pageable pageable);
	int getTotalItem();
	int countByCategoryId(long categoryId);
	NewDTO findById(long id);
	NewDTO save(NewDTO newDto);
	void delete(long[] ids);
	List<NewDTO> findAllByCategory(long categoryId, Sort sort);
	List<NewDTO> findAllByCategory(long categoryId, Pageable pageable);
	
	//Search with keywords
	List<NewDTO> searchNewsByKeyword(String keyword, Pageable pageable);
	int countSearchNewsByKeyword(String keyword);
	
	void increasedViews(long id);
}
