package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.service.ICommentService;

@RestController(value ="commentAPIOfAdmin")
public class CommentAPI {

	@Autowired
	ICommentService commentService;
	
	@PutMapping("/api/comment/update-status")
	public void updateStatusComment(@RequestBody long[] id) {
		commentService.updateStatusComment(id[0]);
	}

	@DeleteMapping("/api/comment/delete")
	public void deleteComment(@RequestBody long[] ids) {
		commentService.delete(ids);
	}
}
