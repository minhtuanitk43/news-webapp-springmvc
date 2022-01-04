package com.laptrinhjavaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.laptrinhjavaweb.entity.CommentEntity;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {
	List<CommentEntity> findAllByNewsId(long news_id, Sort sort);
	void deleteByNewsId(long new_id);
	List<CommentEntity> findAllByNewsId(long news_id, Pageable pageable);
	long countByCreatedDateGreaterThan(Date createdDate);
}
