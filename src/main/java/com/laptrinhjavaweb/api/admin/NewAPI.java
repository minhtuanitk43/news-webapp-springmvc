package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.service.INewService;

@RestController(value = "newAPIOfAdmin")
public class NewAPI {

	@Autowired
	private INewService newService;
	
	@PostMapping("/api/new/add")
	public NewDTO creatNew(@RequestBody NewDTO newDTO) {
		return newService.save(newDTO);
	}

	@PutMapping("/api/new/update")
	public NewDTO updateNew(@RequestBody NewDTO updateDTO) {
		return newService.save(updateDTO);
	}
	
	@DeleteMapping("/api/new/delete")
	public void deleteNew(@RequestBody long[] ids) {
		newService.delete(ids);
	}
}
