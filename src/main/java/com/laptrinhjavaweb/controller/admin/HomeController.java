package com.laptrinhjavaweb.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.service.INotificationService;
import com.laptrinhjavaweb.service.IStatisticalService;

@Controller(value="homeControllerOfAdmin")
public class HomeController {
	@Autowired
	INotificationService notificationService;
	
	@Autowired
	IStatisticalService statisticalService;
	@RequestMapping(value = "/quan-tri/trang-chu", method = RequestMethod.GET)
	   public ModelAndView homePage() {
	      ModelAndView mav = new ModelAndView("admin/home");	      
	      mav.addObject("notifications", notificationService.getNotification());
	      mav.addObject("statistical", statisticalService.statistical());
	      return mav;
	}
}
