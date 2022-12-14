package com.kh.checkmine.approval.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.checkmine.approval.dao.ApprovalDao;
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

@Service
@Transactional
public class ApprovalServiceImpl implements ApprovalService{
	
	private final ApprovalDao dao;
	private final SqlSessionTemplate sst;

	@Autowired
	public ApprovalServiceImpl(ApprovalDao dao, SqlSessionTemplate sst) {
		super();
		this.dao = dao;
		this.sst = sst;
	}

	//현재 사원의 결재대기문서 전체개수 조회
	@Override
	public int selectTotalCnt(String employeeNo) {
		return dao.selectCountApAll(sst, employeeNo);
	}

	//사원번호로 결재대기문서 리스트 조회
	@Override
	public List<ApprovalDocVo> selectList(String employeeNo, PageVo pv) {
		return dao.selectApListAll(sst, employeeNo, pv);
	}

	//문서번호로 결재문서 조회하기
	@Override
	public ApprovalDocVo selectDocByNo(String dno) {
		return dao.selectDoc(sst, dno);
	}

	//문서번호로 결재정보 조회해오기
	@Override
	public ApprovalVo selectApByDocNo(String dno) {
		return dao.selectAp(sst, dno);
	}

	//문서번호로 기안서 조회하기
	@Override
	public ApprovalDraftVo selectDraftByNo(String dno) {
		return dao.selectDraft(sst, dno);
	}

	//사원번호로 작성자검색
	@Override
	public MemberVo selectEmpByNo(String writerNo) {
		return dao.selectWriter(sst, writerNo);
	}

	//문서번호로 제안서 조회하기
	@Override
	public ApprovalProposalVo selectProposalByNo(String dno) {
		return dao.selectProposal(sst, dno);
	}

	//문서번호로 회의록 조회하기
	@Override
	public ApprovalMinutesVo selectMinutesByNo(String dno) {
		return dao.selectMinutes(sst, dno);
	}

	//문서번호로 지출결의서 조회하기
	@Override
	public List<ApprovalExpenditureVo> selectExpenditureByNo(String dno) {
		return dao.selectExpenditure(sst, dno);
	}

	//문서번호로 구매품의서 조회하기
	@Override
	public ApprovalBuyOrderVo selectBuyOrderByNo(String dno) {
		return dao.selectBuyOrder(sst, dno);
	}

	//문서번호로 전표 조회하기
	@Override
	public List<ApprovalStateVo> selectStateByNo(String dno) {
		return dao.selectState(sst, dno);
	}

	//문서번호로 휴가 조회하기
	@Override
	public ApprovalLeaveVo selectLeaveByNo(String dno) {
		return dao.selectLeave(sst, dno);
	}

	//사원 이름으로 사원 검색하기
	@Override
	public List<MemberVo> selectEmpByName(String approver) {
		return dao.selectEmpList(sst, approver);
	}

	//반려사유 업데이트
	@Override
	public int updateApReturn(ApprovalVo apVo) {
		return dao.updateReturn(sst, apVo);
	}

	//최종 결재 후 결재정보 업데이트
	@Override
	public int updateApStatus(ApprovalVo apVo) {
		return dao.updateStatus(sst, apVo);
	}

	//1차 결재일 업데이트
	@Override
	public int updateApDate1(ApprovalVo apVo) {
		return dao.updateDate1(sst, apVo);
	}

	//2차 결재일 업데이트
	@Override
	public int updateApDate2(ApprovalVo apVo) {
		return dao.updateDate2(sst, apVo);
	}

	//3차 결재일 업데이트
	@Override
	public int updateApDate3(ApprovalVo apVo) {
		return dao.updateDate3(sst, apVo);
	}

	//문서정보 DB에 올리기
	@Override
	public int insertApDoc(ApprovalDocVo docVo) {
		return dao.insertDoc(sst, docVo);
	}

	//결재정보 DB에 올리기
	@Override
	public int insertApproval(ApprovalVo apVo) {
		return dao.insertApproval(sst, apVo);
	}

	//파일정보 DB에 올리기
	@Override
	public int insertFile(ApprovalFileVo fileVo) {
		return dao.insertFile(sst, fileVo);
	}

	//기안서 넣는 작업
	@Override
	public ApprovalDocVo approvalDraft(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalDraftVo draftVo) {

		//기안서 관련 문서정보, 결재정보, 기안서 정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		int draftResult = dao.insertDraft(sst, draftVo);
		
		if(docResult*apResult*draftResult == 1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//문서번호로 첨부파일 가져오기
	@Override
	public List<ApprovalFileVo> selectFilesByNo(String dno) {
		return dao.selectFiles(sst, dno);
	}

	//제안서 결재 및 문서정보 가져오기
	@Override
	public ApprovalDocVo approvalProposal(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalProposalVo proposalVo) {
		
		//제안서 관련 문서정보, 결재정보, 제안서 정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		int proResult = dao.insertProposal(sst, proposalVo);
		
		if(docResult*apResult*proResult == 1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//거래처 이름으로 조회하기
	@Override
	public List<AccountVo> selectAccountByName(String corporate) {
		return dao.selectAccountList(sst, corporate);
	}

	//회의록 결재 및 문서정보 가져오기
	@Override
	public ApprovalDocVo approvalMinutes(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalMinutesVo minutesVo) {
		
		//회의록 관련 문서정보, 결재정보, 회의록 정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		int minResult = dao.insertMinutes(sst, minutesVo);
		
		if(docResult*apResult*minResult == 1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//지출결의서 결재 및 문서정보 가져오기
	@Override
	public ApprovalDocVo approvalExpenditure(ApprovalDocVo docVo, ApprovalVo apVo,
			ApprovalExpenditureVo expenditureVo) {

		//지출결의서 관련 문서정보, 결재정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		
		//지출결의서 값 나누기
		List<ApprovalExpenditureVo> expList = new ArrayList<ApprovalExpenditureVo>();
		String dno = expenditureVo.getDocNo();
		String[] briefList = expenditureVo.getBrief().split(",", -1);
		String[] amountList = expenditureVo.getAmount().split(",", -1);
		String[] noteList = expenditureVo.getNote().split(",", -1);
		if(amountList.length == 0) {
			return null;
		}
		for(int i=0; i<amountList.length;i++) {
			ApprovalExpenditureVo vo = new ApprovalExpenditureVo();
			vo.setDocNo(dno);
			vo.setBrief(briefList[i]);
			vo.setAmount(amountList[i]);
			vo.setNote(noteList[i]);
			expList.add(vo);
		}
		
		int expResult = dao.insertExpenditureList(sst, expList);
		
		if(docResult*apResult*expResult == -1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//구매품의서 결재하기
	@Override
	public ApprovalDocVo approvalBuyOrder(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalBuyOrderVo buyOrderVo) {
		
		//구매품의서 관련 문서정보, 결재정보, 구매품의서 정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		int orderResult = dao.insertBuyOrder(sst, buyOrderVo);
		
		if(docResult*apResult*orderResult == 1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//전표 결재하기
	@Override
	public ApprovalDocVo approvalState(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalStateVo stateVo) {
		//전표 관련 문서정보, 결재정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		
		//전표 값 나누기
		List<ApprovalStateVo> stateList = new ArrayList<ApprovalStateVo>();
		String dno = stateVo.getDocNo();
		String stateRp = stateVo.getStateRp();
		String account = stateVo.getAccount();
		String[] nameList = stateVo.getName().split(",", -1);
		String[] briefList = stateVo.getBrief().split(",", -1);
		String[] moneyList = stateVo.getMoney().split(",", -1);
		if(nameList.length == 0) {
			return null;
		}
		for(int i=0; i<nameList.length;i++) {
			ApprovalStateVo vo = new ApprovalStateVo();
			vo.setDocNo(dno);
			vo.setStateRp(stateRp);
			vo.setAccount(account);
			vo.setName(nameList[i]);
			vo.setBrief(briefList[i]);
			vo.setMoney(moneyList[i]);
			stateList.add(vo);
		}
		
		int stateResult = dao.insertStateList(sst, stateList);
		
		if(docResult*apResult*stateResult == -1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

	//휴가원 결재하기
	@Override
	public ApprovalDocVo approvalLeave(ApprovalDocVo docVo, ApprovalVo apVo, ApprovalLeaveVo leaveVo) {
		//휴가원 관련 문서정보, 결재정보, 휴가원 정보 DB에 올리기
		int docResult = dao.insertDoc(sst, docVo);
		int apResult = dao.insertApproval(sst, apVo);
		if(leaveVo.getType() == "반차") {
			leaveVo.setApply("0.5");
		}
		int leaveResult = dao.insertLeave(sst, leaveVo);
		
		if(docResult*apResult*leaveResult == 1) {
			//방금 넣은 문서정보 가져오기
			return dao.selectCurrentDoc(sst);		
		}else {
			return null;
		}
	}

}//class
