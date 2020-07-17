package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	
	public int register(MemberVO vo) throws Exception;
}
