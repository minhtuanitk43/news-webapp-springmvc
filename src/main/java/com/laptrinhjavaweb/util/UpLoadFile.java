package com.laptrinhjavaweb.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.laptrinhjavaweb.constant.SystemConstant;
@Component
public class UpLoadFile {
	public String saveFile(MultipartFile file) {
		if(null != file && !file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				String mime = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				String rootPath = System.getProperty("catalina.home");
				File dir = new File(rootPath+File.separator+SystemConstant.IMAGE_PATH);
				if(!dir.exists()) {
					dir.mkdirs();
				}
				String name = String.valueOf(new Date().getTime()+"."+mime);
				File serverFile = new File(dir.getAbsoluteFile()+File.separator+name);
				System.out.println("======== Path of image on server:"+serverFile.getPath());
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.flush();
				stream.close();
				return name;
			} catch (IOException e) {
				System.out.println("======== Error upload file:"+e.getMessage());
			}
		}else {
			System.out.println("======== File not exists");
		}
		
		return null;
	}
}
