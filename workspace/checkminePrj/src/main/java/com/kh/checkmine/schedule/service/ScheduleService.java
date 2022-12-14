package com.kh.checkmine.schedule.service;

import java.util.List;

import com.kh.checkmine.schedule.vo.ScheduleVo;
import com.kh.checkmine.task.vo.TaskOrderVo;

public interface ScheduleService {
	

	//업무 리스트
	List<TaskOrderVo> selcetOrderList();

	//일정 가져오기
	List<ScheduleVo> selectScheduleList();

	//일정 등록
	int insertSchedule(ScheduleVo vo);

	//일정 삭제
	int updateSchedule(String no);

}
