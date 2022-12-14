package com.kh.checkmine.approval.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.checkmine.approval.vo.ApprovalBuyOrderVo;
import com.kh.checkmine.approval.vo.ApprovalDocVo;
import com.kh.checkmine.approval.vo.ApprovalDraftVo;
import com.kh.checkmine.approval.vo.ApprovalExpenditureVo;
import com.kh.checkmine.approval.vo.ApprovalFileVo;
import com.kh.checkmine.approval.vo.ApprovalLeaveVo;
import com.kh.checkmine.approval.vo.ApprovalMinutesVo;
import com.kh.checkmine.approval.vo.ApprovalProposalVo;
import com.kh.checkmine.approval.vo.ApprovalStateVo;
import com.kh.checkmine.approval.vo.ApprovalVo;
import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.member.vo.MemberVo;
import com.kh.checkmine.personnel.vo.AccountVo;

public interface ApprovalDao {

	//현재 사원의 결재대기문서 전체개수 조회
	int selectCountApAll(SqlSessionTemplate sst, String employeeNo);

	//사원번호로 결재대기문서 전체 리스트 조회 
	List<ApprovalDocVo> selectApListAll(SqlSessionTemplate sst, String employeeNo, PageVo pv);

	//문서번호로 결재문서 조회하기
	ApprovalDocVo selectDoc(SqlSessionTemplate sst, String dno);

	//문서번호로 결재정보 조회해오기
	ApprovalVo selectAp(SqlSessionTemplate sst, String dno);

	//문서번호로 기안서 조회하기
	ApprovalDraftVo selectDraft(SqlSessionTemplate sst, String dno);

	//사원번호로 작성자검색
	MemberVo selectWriter(SqlSessionTemplate sst, String writerNo);

	//문서번호로 제안서 조회하기
	ApprovalProposalVo selectProposal(SqlSessionTemplate sst, String dno);

	//문서번호로 회의록 조회하기
	ApprovalMinutesVo selectMinutes(SqlSessionTemplate sst, String dno);

	//문서번호로 지출결의서 조회하기
	List<ApprovalExpenditureVo> selectExpenditure(SqlSessionTemplate sst, String dno);

	//문서번호로 구매품의서 조회하기
	ApprovalBuyOrderVo selectBuyOrder(SqlSessionTemplate sst, String dno);

	//문서번호로 전표 조회하기
	List<ApprovalStateVo> selectState(SqlSessionTemplate sst, String dno);

	//문서번호로 휴가 조회하기
	ApprovalLeaveVo selectLeave(SqlSessionTemplate sst, String dno);

	//사원 이름으로 사원 검색
	List<MemberVo> selectEmpList(SqlSessionTemplate sst, String approver);

	//반려사유 업데이트
	int updateReturn(SqlSessionTemplate sst, ApprovalVo apVo);

	//최종 결재 후 결재정보 업데이트
	int updateStatus(SqlSessionTemplate sst, ApprovalVo apVo);

	//1차 결재일 업데이트
	int updateDate1(SqlSessionTemplate sst, ApprovalVo apVo);

	//2차 결재일 업데이트
	int updateDate2(SqlSessionTemplate sst, ApprovalVo apVo);

	//3차 결재일 업데이트
	int updateDate3(SqlSessionTemplate sst, ApprovalVo apVo);

	//문서정보 DB에 올리기
	int insertDoc(SqlSessionTemplate sst, ApprovalDocVo docVo);

	//결재정보 DB에 올리기
	int insertApproval(SqlSessionTemplate sst, ApprovalVo apVo);

	//기안서 정보 DB에 올리기
	int insertDraft(SqlSessionTemplate sst, ApprovalDraftVo draftVo);

	//파일정보 DB에 올리기
	int insertFile(SqlSessionTemplate sst, ApprovalFileVo fileVo);

	//가장 최근에 등록된 문서 조회
	ApprovalDocVo selectCurrentDoc(SqlSessionTemplate sst);

	//문서번호로 첨부파일 조회하기
	List<ApprovalFileVo> selectFiles(SqlSessionTemplate sst, String dno);

	//제안서 정보 DB에 올리기
	int insertProposal(SqlSessionTemplate sst, ApprovalProposalVo proposalVo);

	//이름으로 거래처 검색
	List<AccountVo> selectAccountList(SqlSessionTemplate sst, String corporate);

	//회의록 정보 DB에 올리기
	int insertMinutes(SqlSessionTemplate sst, ApprovalMinutesVo minutesVo);

	//지출결의서 정보 DB에 올리기
	int insertExpenditure(SqlSessionTemplate sst, ApprovalExpenditureVo expenditureVo);

	//지출결의서 리스트 DB에 올리기
	int insertExpenditureList(SqlSessionTemplate sst, List<ApprovalExpenditureVo> expList);

	//구매품의서 정보 DB에 올리기
	int insertBuyOrder(SqlSessionTemplate sst, ApprovalBuyOrderVo buyOrderVo);

	//전표 리스트 DB에 올리기
	int insertStateList(SqlSessionTemplate sst, List<ApprovalStateVo> stateList);

	//휴가원 정보 DB에 올리기
	int insertLeave(SqlSessionTemplate sst, ApprovalLeaveVo leaveVo);


}
