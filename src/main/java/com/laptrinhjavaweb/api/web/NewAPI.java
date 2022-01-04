package com.laptrinhjavaweb.api.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.service.INewService;

@RestController(value ="newAPIOfWeb")
public class NewAPI {
	@Autowired
	INewService newService;
	
	@PutMapping("/api/new/increased-views")
	public void increasedViews(@RequestBody long[] id) {
		newService.increasedViews(id[0]);
	}
}
