package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.laptrinhjavaweb.dto.CommentDTO;

public interface ICommentService {
	List<CommentDTO> findAllByNewsId(long news_id, Sort sort);
	CommentDTO save(CommentDTO commentDto);
	void delete(long[] ids);
	List<CommentDTO> findAll(Pageable pageable);
	void updateStatusComment(Long id);
}
