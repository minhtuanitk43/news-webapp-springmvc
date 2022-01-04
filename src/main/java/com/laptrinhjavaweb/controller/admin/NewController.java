package com.laptrinhjavaweb.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.NewDTO;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.INewService;
import com.laptrinhjavaweb.service.INotificationService;
import com.laptrinhjavaweb.util.MessageUtil;
import com.laptrinhjavaweb.util.UpLoadFile;

@Controller(value = "newControllerOfAdmin") 
public class NewController {

	@Autowired
	private INewService newService;
	
	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private MessageUtil messageUtil;
	
	@Autowired
	private UpLoadFile uploadFile;
	
	@Autowired
	private INotificationService notificationService;
	  
	@RequestMapping(value = "/quan-tri/bai-viet/danh-sach", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") int page, 
								 @RequestParam("limit") int limit,
								 HttpServletRequest request) {
		NewDTO model = new NewDTO();
		model.setPage(page);
		model.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/new/list");
		Pageable pageble = new PageRequest(page - 1, limit);
		model.setListResult(newService.findAll(pageble));
		model.setTotalItem(newService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getLimit()));
		if(request.getParameter("message") != null) {
			Map<String, String> message = messageUtil.getMessage(request.getParameter("message"));
			mav.addObject("message", message.get("message"));
			mav.addObject("alert", message.get("alert"));
		}
		mav.addObject("model", model);
		mav.addObject("notifications", notificationService.getNotification());
		return mav;
	}
	@RequestMapping(value = "/quan-tri/bai-viet/chinh-sua", method = RequestMethod.GET)
	public ModelAndView editNew(@RequestParam(value = "id", required = false) Long id, 
								HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/new/edit");
		NewDTO model = new NewDTO();
		if(id != null) {
			model = newService.findById(id);
		}
		if(request.getParameter("message") != null) {
			Map<String, String> message = messageUtil.getMessage(request.getParameter("message"));
			mav.addObject("message", message.get("message"));
			mav.addObject("alert", message.get("alert"));
		}			
		mav.addObject("categories", categoryService.mapAll());
		mav.addObject("model", model);
		mav.addObject("notifications", notificationService.getNotification());
		return mav;
	}
	@RequestMapping(value = "/quan-tri/bai-viet/upload", method = RequestMethod.POST)
	public String upLoadFile(@RequestParam(value = "thumbnail", required = false) MultipartFile image,
							@ModelAttribute("model")NewDTO model,
							BindingResult bindingResult)
							{

		NewDTO newDto = new NewDTO();
		newDto.setTitle(model.getTitle());
		newDto.setShortDescription(model.getShortDescription());
		newDto.setContent(model.getContent());
		newDto.setCategoryCode(model.getCategoryCode());
		newDto.setThumbnail(uploadFile.saveFile(image));
		String message = null;
		if(model.getId() != null) {
			newDto.setId(model.getId());
			message = "update_success";
		} else {
			message = "insert_success";
		}
		newDto = newService.save(newDto);
		if(newDto != null) {
			message = "?id=" + newDto.getId() + "&message=" + message;
		}else {
			message = "?message=error_system";
		}
		return "redirect:/quan-tri/bai-viet/chinh-sua"+ message; 
	}
}
