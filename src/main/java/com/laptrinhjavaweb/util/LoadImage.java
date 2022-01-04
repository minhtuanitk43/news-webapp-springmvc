package com.laptrinhjavaweb.util;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.laptrinhjavaweb.constant.SystemConstant;

/**
 * Servlet implementation class LoadImage
 */
@WebServlet(urlPatterns = "/image/*")
public class LoadImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String imagPath;

	@Override
	public void init() throws ServletException {
		imagPath = System.getProperty("catalina.home")+File.separator+SystemConstant.IMAGE_PATH;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestedImage = request.getPathInfo();
		
		if(requestedImage == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		File image = new File(imagPath, URLDecoder.decode(requestedImage, "UTF-8"));
		
		if(!image.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		String contenType = getServletContext().getMimeType(image.getName());
		
		if(contenType == null || !contenType.startsWith("image")) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		response.reset();
		response.setContentType(contenType);
		response.setHeader("Content-Length", String.valueOf(image.length()));
		
		Files.copy(image.toPath(), response.getOutputStream());
	}


}
