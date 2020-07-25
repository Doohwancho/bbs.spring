package org.zerock.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller //스프링의 빈으로 인식될 수 있게끔
@RequestMapping("/member/*") //board로 시작하면 무조건 이 컨트롤러로
@Log4j
public class MemberController {
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_=@Autowired)
	private DataSource ds;
	
	@Setter(onMethod_=@Autowired)
	private MemberService memberService;
	
	@GetMapping("/register")
	public String register() {
		return "member/customRegister"; 
	}
	
	@PostMapping("/register")
	public String register(MemberVO vo) throws Exception{
		log.info("/member/register..........................");
		log.info("register member.................................: "+vo);
		 
		try {
			String encodedPw = pwencoder.encode(vo.getUserpw());
			vo.setUserpw(encodedPw);
			memberService.register(vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/customLogin";
		
		
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into tbl_member(userid, userpw, username) values (?,?,?)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, pwencoder.encode(vo.getUserpw()));
//			pstmt.setString(2, vo.getUserpw()); 
			pstmt.setString(3, vo.getUserName());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(Exception e) {
					
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch(Exception e) {
					
				}
			}
		}
		
		con = null;
		pstmt = null;
		try {
			String sql_auth = "insert into tbl_member_auth(userid, auth) values(?,?)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql_auth);
			
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, "ROLE_USER");
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(Exception e) {
					
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch(Exception e) {
					
				}
			}
		}
		*/
	}
}
