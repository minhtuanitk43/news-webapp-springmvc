package com.laptrinhjavaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.laptrinhjavaweb.entity.NewEntity;

public interface NewRepository extends JpaRepository<NewEntity, Long> {
	List<NewEntity> findAllByCategoryId(long category_id, Sort sort);
	List<NewEntity> findAllByCategoryId(long category_id, Pageable pageable);
	long countByCategoryId(long category_id);	
	
//Search with keywords
	
	@Query("SELECT e "
			+ "FROM NewEntity e "
			+ "WHERE e.title LIKE %:keyword% OR e.content LIKE %:keyword% OR e.shortDescription like %:keyword%")
	List<NewEntity> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);
	
	@Query("SELECT e "
			+ "FROM NewEntity e "
			+ "WHERE e.title LIKE %:keyword% OR e.content LIKE %:keyword% OR e.shortDescription like %:keyword% OR e.category.id=:id")
	List<NewEntity> searchByKeyword(@Param("keyword") String keyword,@Param("id") long id, Pageable pageable);
	
	
	
	@Query("SELECT COUNT(e.id) "
			+ "FROM NewEntity e "
			+ "WHERE e.title LIKE %:keyword% OR e.content LIKE %:keyword% OR e.shortDescription like %:keyword%")
	int countSearchByKeyword(@Param("keyword") String keyword);
	
	@Query("SELECT COUNT(e.id) "
			+ "FROM NewEntity e "
			+ "WHERE e.title LIKE %:keyword% OR e.content LIKE %:keyword% OR e.shortDescription like %:keyword% OR e.category.id=:id")
	int countSearchByKeyword(@Param("keyword") String keyword,@Param("id") long id);
	//Dùng hàm sẵn của spring data
	/*List<NewEntity> findByContentContainingIgnoreCase(String keyword);
	List<NewEntity> findByTitleContainingIgnoreCase(String keyword);*/
//Search with keywords
	
	List<NewEntity> findAllByCreatedBy(String createdBy);
	
	//statistical
	long countByCreatedDateGreaterThan(Date createdDate);

	@Query("SELECT SUM(e.views) FROM NewEntity e")
	int countViews();
	
	/*@Query("SELECT SUM(e.views) FROM NewEntity e WHERE e.createdDate > :date")
	int countViewTW(@Param("date") Date date);*/
}
