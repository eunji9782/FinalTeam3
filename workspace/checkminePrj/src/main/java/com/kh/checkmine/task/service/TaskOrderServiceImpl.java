package com.kh.checkmine.task.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.task.dao.TaskOrderDao;
import com.kh.checkmine.task.vo.TaskOrderAttVo;
import com.kh.checkmine.task.vo.TaskOrderFileVo;
import com.kh.checkmine.task.vo.TaskOrderVo;

@Service
public class TaskOrderServiceImpl implements TaskOrderService {

	private final TaskOrderDao orderDao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public TaskOrderServiceImpl(TaskOrderDao orderDao, SqlSessionTemplate sst) {
		this.orderDao = orderDao;
		this.sst = sst;
	}

	//지시서 작성
	//지시서 + 수신참조 + 파일
	@Override
	public int write(TaskOrderVo orderVo, List<TaskOrderAttVo> attVoList, List<TaskOrderFileVo> fileVoList) {
		int result1 = orderDao.insertOrder(sst, orderVo);
		int result2 = 1; //수신,참조 첨부
		int result3 = 1; //파일 첨부

		for(int i = 0; i < attVoList.size(); i++) {
			result2 = orderDao.insertOrderAtt(sst, attVoList.get(i));
		}
		
		for(int j = 0; j < fileVoList.size(); j++) {
			result3 *= orderDao.insertFile(sst, fileVoList.get(j)); 
		}
		
		return result1 * result2 * result3;
	}
	//지시서 + 수신참조
	@Override
	public int write(TaskOrderVo orderVo, List<TaskOrderAttVo> attVoList) {
		int result1 = orderDao.insertOrder(sst, orderVo);
		int result2 = 1; //수신,참조 첨부

		for(int i = 0; i < attVoList.size(); i++) {
			result2 = orderDao.insertOrderAtt(sst, attVoList.get(i));
		}
		
		return result1 * result2;
	}

	//전체 지시서 갯수 조회
	@Override
	public int selectTotalCnt() {
		return orderDao.selectCountAll(sst);
	}

	//지시서 목록 조회
	@Override
	public List<TaskOrderVo> selectList(PageVo pv) {
		return orderDao.selectList(sst, pv);
	}
	

}
