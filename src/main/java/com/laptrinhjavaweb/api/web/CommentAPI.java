package com.laptrinhjavaweb.api.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.service.ICommentService;

@RestController(value ="commentAPIOfWeb")
public class CommentAPI {

	@Autowired
	ICommentService commentService;
	
	@PostMapping("/api/comment/save")
	public CommentDTO saveComment(@RequestBody CommentDTO cmtDTO) {
		return commentService.save(cmtDTO);
	}

}
