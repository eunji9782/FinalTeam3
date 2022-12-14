package com.kh.checkmine.admin.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.member.vo.DeptVo;
import com.kh.checkmine.member.vo.MemberVo;
import com.kh.checkmine.member.vo.PosVo;

@Repository
public class AdminMemberDaoImpl implements AdminMemberDao{

	//총 사원 수
	@Override
	public int selectTotalCnt(SqlSessionTemplate sst, String sort) {
		return sst.selectOne("adminMemberMapper.selectTotalCnt", sort);
	}

	//사원 리스트
	@Override
	public List<MemberVo> selectMemberList(SqlSessionTemplate sst, PageVo pv, String sort) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("adminMemberMapper.selectMemberList", sort, rb);
	}

	//검색 결과 수
	@Override
	public int selectKeywordCnt(SqlSessionTemplate sst, Map<String, String> map) {
		return sst.selectOne("adminMemberMapper.selectTotalKeyword", map);
	}

	//검색 결과
	@Override
	public List<MemberVo> selectMemberKeyword(SqlSessionTemplate sst, PageVo pv, Map<String, String> map) {
		int offset = (pv.getCurrentPage()-1) * (pv.getBoardLimit());
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("adminMemberMapper.selectMemberKeyword", map, rb);
	}

	//부서, 직위 가져오기
	@Override
	public List<DeptVo> selectDeptList(SqlSessionTemplate sst) {
		return sst.selectList("adminMemberMapper.selectDeptList");
	}

	@Override
	public List<PosVo> selectPosList(SqlSessionTemplate sst) {
		return sst.selectList("adminMemberMapper.selectPosList");
	}

	//중복 확인
	@Override
	public String checkDup(SqlSessionTemplate sst, String id) {
		return sst.selectOne("adminMemberMapper.checkDup", id);
	}

	//사원등록
	@Override
	public int insertMember(SqlSessionTemplate sst, MemberVo memberVo) {
		return sst.insert("adminMemberMapper.insertMember", memberVo);
	}

	//사원조회
	@Override
	public MemberVo selectMember(SqlSessionTemplate sst, String no) {
		return sst.selectOne("adminMemberMapper.selectMember", no);
	}

	//사원 수정
	@Override
	public int updateMember(SqlSessionTemplate sst, MemberVo memberVo) {
		return sst.update("adminMemberMapper.updateMember", memberVo);
	}

	//조직도
	@Override
	public List<Map<String, String>> selectMemberCnt(SqlSessionTemplate sst) {
		return sst.selectList("adminMemberMapper.selectMemberCnt");
	}

	//사원정보 영구 삭제
	@Override
	public int delete(SqlSessionTemplate sst, String memberNo) {
		return sst.delete("adminMemberMapper.deleteMember", memberNo);
	}
	
	

}
