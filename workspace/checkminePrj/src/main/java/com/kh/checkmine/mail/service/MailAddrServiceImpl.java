package com.kh.checkmine.mail.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.checkmine.mail.dao.MailAddrDao;
import com.kh.checkmine.mail.vo.MailAddrVo;

@Service
public class MailAddrServiceImpl implements MailAddrService{
	
	private final MailAddrDao dao;
	private final SqlSessionTemplate sst; 
	
	@Autowired
	public MailAddrServiceImpl(MailAddrDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}
	
	/**
	 * 사내 주소록 리스트 가져오기
	 */
	@Override
	public List<MailAddrVo> getAddrListInner(String memberNo) {
		return dao.selectAddrListInner(sst, memberNo);
	}
	/**
	 * 사내 주소록 리스트 갯수 가져오기
	 */
	@Override
	public int getInnerAddrListCount(String memberNo) {
		return dao.selectInnerAddrListCount(sst, memberNo);
	}

	/**
	 * 사외 주소록 리스트 가져오기
	 */
	@Override
	public List<MailAddrVo> getAddrListOuter(String memberNo) {
		return dao.selectAddrListOuter(sst, memberNo);
	}
	/**
	 * 사외 주소록 리스트 갯수 가져오기
	 */
	@Override
	public int getOuterAddrListCount(String memberNo) {
		return dao.selectOuterAddrListCount(sst, memberNo);
	}

	/**
	 * 거래처 주소록 리스트 가져오기
	 */
	@Override
	public List<MailAddrVo> getAddrListAcc(String memberNo) {
		return dao.selectAddrListAcc(sst, memberNo);
	}
	/**
	 * 거래처 주소록 리스트 갯수 가져오기
	 */
	@Override
	public int getAccAddrListCount(String memberNo) {
		return dao.selectAccAddrListCount(sst, memberNo);
	}

	/**
	 * 주소록 추가
	 */
	@Override
	public int insertAddr(MailAddrVo mailAddrVo) {
		return dao.insertAddr(sst, mailAddrVo);
	}

	/**
	 * 주소록 삭제
	 */
	@Override
	public int deleteAddr(String targetNo) {
		return dao.deleteAddr(sst, targetNo);
	}

	/**
	 * 주소록 일괄 삭제
	 */
	@Override
	public int addrDeleteAll(String[] addrNoArr) {
		int result = 1;
		
		for(String target:addrNoArr) {
			result = result * dao.deleteAddr(sst, target);
		}
		
		return result;
	}

	/**
	 * 주소록 검색
	 */
	@Override
	public List<MailAddrVo> addrSearch(HashMap<String, String> searchMap) {
		return dao.addrSearch(sst, searchMap);
	}


	

}
