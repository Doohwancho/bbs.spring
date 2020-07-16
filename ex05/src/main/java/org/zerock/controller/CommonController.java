package org.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : "+ auth); 
		
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, @RequestParam(value="registerLoginSelector", required=false) String registerLoginSelector, Model model) {
		log.info("error: " + error); 
		
		log.info("logout: "+ logout);
		
		log.info("registerLoginSelector " + registerLoginSelector);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account!");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
		if(registerLoginSelector == null) {
			log.info("registerLoginSelector가 없습니다."); 
		}
		else if(registerLoginSelector.equals("registerActive")) {
			model.addAttribute("registerLoginSelector", "registerActive"); 
		} else if(registerLoginSelector.equals("loginActive")) {
			model.addAttribute("registerLoginSelector", "loginActive");
		}
	}
	
	//로그아웃시 세션을 무효화 시키는 설정이나 특정한 쿠키를 지우는 작업을 지정할 수 있음
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}

	
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("post custom logout");
	}
}
