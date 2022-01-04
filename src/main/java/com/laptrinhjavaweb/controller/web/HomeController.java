package com.laptrinhjavaweb.controller.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.INewService;

@Controller(value = "homeControllerOfWeb")
public class HomeController {
	
	@Autowired
	INewService newService;
	
	@Autowired
	ICategoryService categoryService;
	
	@RequestMapping(value = "/trang-chu", method = RequestMethod.GET)
	public ModelAndView homePage() throws IOException {
		ModelAndView mav = new ModelAndView("web/home");
		List<NewDTO> newDtos = new ArrayList<>();
		List<CategoryDTO> categoryDtos = new ArrayList<>();
		NewDTO newDtoHot = new NewDTO();
		
		Sort sort = new Sort(Sort.Direction.DESC, "createdDate");
		Pageable pageable = new PageRequest(0, 10, sort);
		
		categoryDtos = categoryService.findAll();
		newDtoHot.setListResult(newService.findAll(pageable));
		
		for(CategoryDTO dto : categoryDtos) {
			NewDTO newDto = new NewDTO();			
			newDto.setListResult(newService.findAllByCategory(dto.getId(), sort));
			if(!newDto.getListResult().isEmpty()) {
				newDto.setCategoryName(newDto.getListResult().get(0).getCategoryName());
				newDtos.add(newDto);
			}		
		}
		
		mav.addObject("listCategory", categoryDtos);
		mav.addObject("listModel", newDtos);
		mav.addObject("listHotNews", newDtoHot);
		return mav;
	}

	@RequestMapping(value = "/dang-nhap", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}

	@RequestMapping(value = "/thoat", method = RequestMethod.GET)
	public ModelAndView logOut(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return new ModelAndView("redirect:/trang-chu");
	}
	
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public ModelAndView accessDenied() {
		return new ModelAndView("redirect:/dang-nhap?accessDenied");
	}
}
