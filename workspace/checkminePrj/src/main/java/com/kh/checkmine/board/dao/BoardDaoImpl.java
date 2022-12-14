package com.kh.checkmine.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.checkmine.board.vo.BoardAttVo;
import com.kh.checkmine.board.vo.BoardVo;
import com.kh.checkmine.common.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{

	//게시물 리스트
	@Override
	public int selectTotalCnt(SqlSessionTemplate sst, String type) {
		return sst.selectOne("boardMapper.selectTotalCnt", type);
	}

	@Override
	public List<BoardVo> selectBoardList(SqlSessionTemplate sst, PageVo pv, Map<String, String> map) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		return sst.selectList("boardMapper.selectBoardListByType", map, rb); 
	}

	//검색
	@Override
	public int selectTotalKeyword(SqlSessionTemplate sst, String keyword) {
		return sst.selectOne("boardMapper.selectTotalCntByKeyword", keyword);
	}

	@Override
	public List<BoardVo> selectBoardKeyword(SqlSessionTemplate sst, PageVo pv, String keyword) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		return sst.selectList("boardMapper.selectBoardListByKeyword", keyword, rb);
	}

	//글 작성
	@Override
	public int insertBoard(SqlSessionTemplate sst, BoardVo boardVo) {
		return sst.insert("boardMapper.insertBoard", boardVo);
	}

	@Override
	public int insertBoardAtt(SqlSessionTemplate sst, List<BoardAttVo> attVoList) {
		return sst.insert("boardMapper.insertBoardAtt", attVoList);
	}
	
	//게시글 상세보기 + 조회수 증가
	@Override
	public int increaseHit(SqlSessionTemplate sst, String no) {
		return sst.update("boardMapper.increaseHit", no);
	}

	@Override
	public BoardVo selectOne(SqlSessionTemplate sst, String no) {
		return sst.selectOne("boardMapper.selectOne", no);
	}

	@Override
	public List<BoardAttVo> selectAtt(SqlSessionTemplate sst, String no) {
		return sst.selectList("boardMapper.selectAtt", no);
	}

	//추천
	@Override
	public int recommend(SqlSessionTemplate sst, Map<String, String> map) {
		return sst.insert("boardMapper.recommend", map);
	}

	//추천수만 가져오기
	@Override
	public String selectBoardRecommend(SqlSessionTemplate sst, String bNo) {
		return sst.selectOne("boardMapper.selectBoardRecommend", bNo);
	}

	//추천 기록 확인
	@Override
	public int selectRecommend(SqlSessionTemplate sst, Map<String, String> map) {
		return sst.selectOne("boardMapper.selectRecommend", map);
	}

	//추천 취소
	@Override
	public int recommendDelete(SqlSessionTemplate sst, Map<String, String> map) {
		return sst.delete("boardMapper.recommendDelete", map);
	}

	//게시글 삭제
	@Override
	public int delete(SqlSessionTemplate sst, String boardNo) {
		return sst.update("boardMapper.deleteBoard", boardNo);
	}

	//게시글 수정
	@Override
	public int edit(SqlSessionTemplate sst, BoardVo boardVo) {
		return sst.update("boardMapper.edit", boardVo);
	}

	//파일 수정 (새로운 파일 업로드)
	@Override
	public int edit(SqlSessionTemplate sst, List<BoardAttVo> attVoList) {
		return sst.insert("boardMapper.updateBoardAtt", attVoList);
	}

	//기존 파일 삭제
	@Override
	public int deleteAtt(SqlSessionTemplate sst, BoardVo boardVo) {
		return sst.delete("boardMapper.deleteAtt", boardVo);
	}
}
