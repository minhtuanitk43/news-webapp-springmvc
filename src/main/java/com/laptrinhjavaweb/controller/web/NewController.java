package com.laptrinhjavaweb.controller.web;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.ICommentService;
import com.laptrinhjavaweb.service.INewService;

@Controller(value = "newControllerOfWeb")
public class NewController {
	
	@Autowired
	INewService newService;
	
	@Autowired
	ICategoryService categoryService;
	
	@Autowired
	ICommentService commentService;
	
	@RequestMapping(value = "/xem-chi-tiet", method = RequestMethod.GET)
	public ModelAndView newsDetail(@RequestParam("id") long newId) throws IOException {
		//Declare
		ModelAndView mav = new ModelAndView("web/newsdetail");
		NewDTO newDto = newService.findById(newId);
		NewDTO newDtoHot = new NewDTO();
		CommentDTO cmtDto = new CommentDTO();
		
		//Pageable and Sorter
		Sort sort = new Sort(Sort.Direction.DESC, "createdDate");
		Pageable pageable = new PageRequest(0, 10, sort);
		
		//Get data
		newDtoHot.setListResult(newService.findAll(pageable));
		newDto.setListResult(newService.findAllByCategory(newDto.getCategoryId(), sort));
		cmtDto.setListResult(commentService.findAllByNewsId(newId, sort));
		
		//Ad data[models] to view
		mav.addObject("comment", cmtDto);
		mav.addObject("model", newDto);
		mav.addObject("listHotNews", newDtoHot);
		mav.addObject("listCategory", categoryService.findAll());
		return mav;
	}
	
	@RequestMapping(value = "/danh-muc", method = RequestMethod.GET)
	public ModelAndView newsCategory(@RequestParam("code") String categoryCode,
									 @RequestParam("page") int page, 
									 @RequestParam("limit") int limit) throws IOException {
		ModelAndView mav = new ModelAndView("web/newsofcategory");
		NewDTO model =new NewDTO();
		model.setPage(page);
		model.setLimit(limit);
		model.setCategoryCode(categoryCode);
		Sort sort = new Sort(Sort.Direction.DESC, "createdDate");
		Pageable pageable = new PageRequest(page - 1, limit, sort);
		CategoryDTO categoryDto = categoryService.findOneByCode(categoryCode);
		model.setCategoryName(categoryDto.getName());
		model.setListResult(newService.findAllByCategory(categoryDto.getId(), pageable));
		model.setTotalItem(newService.countByCategoryId(categoryDto.getId()));
		model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getLimit()));
		
		NewDTO newDtoHot = new NewDTO();
		Sort sort2 = new Sort(Sort.Direction.DESC, "createdDate");
		Pageable pageable2 = new PageRequest(0, 10, sort2);
		newDtoHot.setListResult(newService.findAll(pageable2));
		
		mav.addObject("listHotNews", newDtoHot);
		mav.addObject("listCategory", categoryService.findAll());
		mav.addObject("model", model);
		return mav;
	}
	
	@RequestMapping(value = "/tien-ich", method = RequestMethod.GET)
	public ModelAndView embedPage(@RequestParam("embed") String embed) {
		ModelAndView mav = new ModelAndView("web/embed");
		
		mav.addObject("listCategory", categoryService.findAll());
		mav.addObject("embed", embed);
		return mav;
	}
	
	@RequestMapping(value = "/tim-kiem", method = RequestMethod.GET)
	public ModelAndView search(	@RequestParam("key") String keyword,
								@RequestParam("page") int page, 
								@RequestParam("limit") int limit) {
	
		
		ModelAndView mav = new ModelAndView("web/newssearch");
		NewDTO model =new NewDTO();
		model.setPage(page);
		model.setLimit(limit);
		Pageable pageable = new PageRequest(page -1 , limit);
		List<NewDTO> listNewDTO = newService.searchNewsByKeyword(keyword, pageable);
		model.setListResult(listNewDTO);
		model.setTotalItem(newService.countSearchNewsByKeyword(keyword));
		model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getLimit()));
		
		NewDTO newDtoHot = new NewDTO();
		Sort sort2 = new Sort(Sort.Direction.DESC, "createdDate");
		Pageable pageable2 = new PageRequest(0, 10, sort2);
		newDtoHot.setListResult(newService.findAll(pageable2));
		
		mav.addObject("model", model);
		mav.addObject("keysearch", keyword);
		mav.addObject("listHotNews", newDtoHot);
		mav.addObject("listCategory", categoryService.findAll());
		return mav;
	}
}
