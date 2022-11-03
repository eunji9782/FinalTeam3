package com.kh.checkmine.alarm.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.checkmine.alarm.vo.AlarmVo;

public interface AlarmDao {

	//알람 전체 리스트 조회해오기
	List<AlarmVo> selectAlarmList(SqlSessionTemplate sst, String no);

	//결재 건수 알람테이블에 집어넣기
	int insertApprovalAlarm(SqlSessionTemplate sst, Map<String, Object> appMap);

	//알람 삭제
	int deleteAlarm(SqlSessionTemplate sst, String no);

	//메일 건수 알림 테이블에 집어넣기
	int insertMailAlarm(SqlSessionTemplate sst, Map<String, Object> mailMap);

	//알림 읽음처리
	int updateAlarm(SqlSessionTemplate sst, String no);

}
