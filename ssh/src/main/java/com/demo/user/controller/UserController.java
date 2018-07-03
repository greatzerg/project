package com.demo.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.demo.framework.util.MD5;
import com.demo.framework.util.MessageSourceUtil;
import com.demo.user.service.UserService;

@Controller
@RequestMapping("/test")
public class UserController{
	
	private String basePath = "/test";
	
    @Autowired
    UserService userService;
    
    @ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/resource/submit.html")
    public Map<String, Object> submitResourceReview(HttpServletRequest httpRequest) {
    	Map<String, Object> results = new HashMap<String, Object>();
    	MultipartResolver resolver = new CommonsMultipartResolver(httpRequest.getSession().getServletContext());
		MultipartHttpServletRequest multipartRequest = resolver.resolveMultipart(httpRequest);

		List<MultipartFile> fileList = multipartRequest.getFiles("file");
    	String[] delFileNos = multipartRequest.getParameterValues("delFileNos");
    	String[] delFileNoArr = delFileNos.length > 0? delFileNos[0].split(","): new String[0];
		List<MultipartFile> list = new ArrayList<MultipartFile>();
		for (MultipartFile file : fileList) {
			Boolean delTrue = false;
			for(String delFileNo: delFileNoArr){
				if(StringUtils.isNotBlank(delFileNo)){
					if(fileList.get(Integer.valueOf(delFileNo)).equals(file)){
						delTrue = true;
						break;
					}
				}
			}
			if(!delTrue){
				list.add(file);
			}
		}
		MultipartFile[] files = new MultipartFile[list.size()];
		list.toArray(files);
		results.put("success", true);
    	return results;
    }
    
    @ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/resource/submitProductReview.html")
    public Map<String, Object> submitResourceReview2(HttpServletRequest httpRequest) {
    	Map<String, Object> results = new HashMap<String, Object>();
    	MultipartResolver resolver = new CommonsMultipartResolver(httpRequest.getSession().getServletContext());
		MultipartHttpServletRequest multipartRequest = resolver.resolveMultipart(httpRequest);

    	String proIndex = multipartRequest.getParameter("proIndex");
		List<MultipartFile> fileList = multipartRequest.getFiles("file"+proIndex);
    	String[] delFileNos = multipartRequest.getParameterValues("delFileNos");
    	String[] delFileNoArr = delFileNos.length > 0? delFileNos[0].split(","): new String[0];
		List<MultipartFile> list = new ArrayList<MultipartFile>();
		for (MultipartFile file : fileList) {
			Boolean delTrue = false;
			for(String delFileNo: delFileNoArr){
				if(StringUtils.isNotBlank(delFileNo)){
					if(fileList.get(Integer.valueOf(delFileNo)).equals(file)){
						delTrue = true;
						break;
					}
				}
			}
			if(!delTrue){
				list.add(file);
			}
		}
		MultipartFile[] files = new MultipartFile[list.size()];
		list.toArray(files);
		
		results.put("success", true);
    	return results;
    }
    @RequestMapping(method = RequestMethod.GET, value="/uploadFile.html")
    public String uploadFile(Model model){
        return basePath + "/uploadFile";
    }

    @RequestMapping(method = RequestMethod.GET, value="/uploadFiles.html")
    public String uploadFiles(Model model){
        return basePath + "/uploadFiles";
    }
    
    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value="/add")
    public Map<String, Object> save(@RequestBody Map<String, Object> params){
    	String username = (String) params.get("username");
    	String password = (String) params.get("password");
    	String conPassword = (String) params.get("conPassword");
    	
        Map<String, Object> map = new HashMap<String, Object>();
        if(password.equals(conPassword)){
            userService.save(username, MD5.getMD5(password));
            map.put("data", userService.findAll());
            map.put("status", true);
        }else{
        	map.put("status", false);
        	map.put("msg", "输入两次密码不一致");
        }
        return map;
    }
    
    @RequestMapping(value="/messageProperties.html", method = {RequestMethod.GET})
    public String test(HttpServletRequest request,Model model, @RequestParam(value="langType", defaultValue="zh") String langType){            
    	MessageSourceUtil.getLangType(request, langType);   
        return basePath + "/messageProperties";
    }
}