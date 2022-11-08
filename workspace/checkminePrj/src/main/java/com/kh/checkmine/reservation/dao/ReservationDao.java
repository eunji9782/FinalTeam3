package com.kh.checkmine.reservation.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.reservation.vo.GoodsBookVo;
import com.kh.checkmine.reservation.vo.GoodsVo;
import com.kh.checkmine.reservation.vo.PlaceBookVo;

public interface ReservationDao {

	//내가 예약한 공유물
	List<GoodsBookVo> selectListGoods(String no, SqlSessionTemplate sst);

	//내가 예약한 장소
	List<PlaceBookVo> selectListPlace(String no, SqlSessionTemplate sst);

	//공유물 예약 취소
	int goodsDelbtn(GoodsBookVo vo, SqlSessionTemplate sst);

	//장소 예약 취소
	int placeDelbtn(PlaceBookVo vo, SqlSessionTemplate sst);

	//빔
	List<GoodsVo> selectList(SqlSessionTemplate sst);

	//빔 예약
	int insertRsvb(GoodsBookVo vo, SqlSessionTemplate sst);

	//빔 예약 목록
	List<GoodsBookVo> selectListBimRsv(PageVo pv, SqlSessionTemplate sst);

	//빔 예약 페이징
	int bimrsvTotalCount(SqlSessionTemplate sst);

}
