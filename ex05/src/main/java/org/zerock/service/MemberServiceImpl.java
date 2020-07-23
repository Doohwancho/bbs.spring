package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper memberMapper;
	
	@Transactional
	@Override
	public int register(MemberVO vo) throws Exception {
		int resultRegisterUser = memberMapper.registerUser(vo);
		int resultRegisterAuth = memberMapper.registerAuth(vo);
		return resultRegisterUser+resultRegisterAuth-1;
	}
}
