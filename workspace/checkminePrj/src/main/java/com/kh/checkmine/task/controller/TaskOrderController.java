package com.kh.checkmine.task.controller;

import java.io.File;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.checkmine.common.FileUploader;
import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.common.Pagination;
import com.kh.checkmine.member.service.MemberService;
import com.kh.checkmine.member.vo.MemberVo;
import com.kh.checkmine.task.service.TaskOrderService;
import com.kh.checkmine.task.vo.TaskOrderAttVo;
import com.kh.checkmine.task.vo.TaskOrderFileVo;
import com.kh.checkmine.task.vo.TaskOrderVo;

@Controller
@RequestMapping("task/order")
public class TaskOrderController {
	
	private final TaskOrderService orderService;
	private final MemberService memberService;
	
	public TaskOrderController(TaskOrderService orderService, MemberService memberService) {
		this.orderService = orderService;
		this.memberService = memberService;
	}
	
	//지시서 목록
	@GetMapping("list/{pno}")
	public String orderList(Model model, @PathVariable int pno) {
		
		int totalCount = orderService.selectTotalCnt();

		PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 15);
		TaskOrderAttVo attVo = new TaskOrderAttVo();
		
		List<TaskOrderVo> voList = orderService.selectList(pv);
		List<TaskOrderAttVo> attList = orderService.selectAttList(attVo);
		
		model.addAttribute("voList", voList);
		//TODO order의 no값을 받아와서 해당 값의 수신자만 보이게... 
		//현재 LISTAGG를 이용해서 같은 지시서의 수신자들끼리는 묶어둠!! 
		model.addAttribute("attList", attList);  
		model.addAttribute("pv", pv);
		
		return "task/order-list";
	}
		
	//지시서 조회
	@GetMapping(value = {"detail/{no}", "detail"})
	public String orderDetail(@PathVariable(required = false) String no, Model model) {
		
		TaskOrderVo vo = orderService.selectOne(no);
		//MemberVo eVo = memberService.selectOneByNo(vo.getOrderer()); //TODO 이름으로 가져와져서 숫자로 가져오게 찾아보기. 
		//TaskOrderAttVo attVo = orderService.selectAttOne(vo.getNo());
		
		//orderVo에 task_att join해서 해보고 안되면 복구~~~
		
		//여기까지~~ 삭제~~~
		
		model.addAttribute("vo", vo);
		//model.addAttribute("eVo", eVo);
		//model.addAttribute("attVo", attVo);
		
		return "task/order-detail";
	}
	
		
	
	//지시서 작성(화면)
	@GetMapping("write")
	public String orderWrite() {
		return "task/order-write";
	}
	
	//지시서 작성
	@PostMapping("write")
	public String orderWrite(TaskOrderVo orderVo, TaskOrderAttVo orderAttVo, TaskOrderFileVo orderFileVo, HttpServletRequest req, HttpSession session) {
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		
		//지시서 입력
		String orderer = loginMember.getNo();
		String deptNo = loginMember.getDeptNo();
				
		String attNoA = orderAttVo.getAttNoA();
		String attNoR = orderAttVo.getAttNoR();

		orderVo.setOrderer(orderer);
		orderVo.setDeptNo(deptNo);
		
		int orderResult = 0;
		int attNoAResult = 0;
		int attNoRResult = 0;

		//파일 등록
		MultipartFile[] fArr = orderFileVo.getFiles();
		List<TaskOrderFileVo> fileVoList = new ArrayList<TaskOrderFileVo>();
		
		//수신 참조 등록
		Gson gson = new Gson();
		List<Map> listAttNoA = gson.fromJson(attNoA, ArrayList.class);
		List<Map> listAttNoR = gson.fromJson(attNoR, ArrayList.class);
		List<TaskOrderAttVo> attVoList = new ArrayList<TaskOrderAttVo>();
		
		//att 추가 테스트 (안되면 삭제)
		if(listAttNoA != null) { //attA not null 일 때
			for(Map m : listAttNoA) {
				TaskOrderAttVo attVo = new TaskOrderAttVo();
				String value = (String)m.get("value");
				attVo.setEmpNo(value);
				attVo.setType("A");
				attVoList.add(attVo); 
			}
			
			if(listAttNoR != null){
				for(Map m : listAttNoR) {
					TaskOrderAttVo attVo = new TaskOrderAttVo();
					String value = (String)m.get("value");
					attVo.setEmpNo(value);
					attVo.setType("R");
					attVoList.add(attVo);
				}
			}
			
			//테스트 해보고 att때문에 오류나면 이 아래로는 삭제하기 전에 if문 바깥으로 빼서 복구해야함.
			if(!fArr[0].isEmpty() && fArr != null) {
				String savePath = req.getServletContext().getRealPath("/resources/upload/task/order/");
				
				for(int i = 0; i < fArr.length; i++) {
					TaskOrderFileVo fileVo = new TaskOrderFileVo();
					MultipartFile f = fArr[i];
					
					String changeName = FileUploader.fileUpload(f, savePath);
					fileVo.setName(changeName);
					fileVo.setPath(savePath);
					fileVoList.add(fileVo);
				}
				
				orderResult = orderService.write(orderVo, attVoList, fileVoList);
			}else {
				orderResult = orderService.write(orderVo, attVoList);
			}
			//여기까지.
		}
		
		
		if(orderResult == 1) {
			session.setAttribute("alertMsg", "지시서가 작성되었습니다.");
			return "redirect:/task/order/list";
		}else {
			//문제 발생 시 파일 제거
			if(!fileVoList.isEmpty()) {
				for(int i=0; i<fileVoList.size(); i++) {
					String savePath = fileVoList.get(i).getPath()+fileVoList.get(i).getName();
					new File(savePath).delete();
				}
			}
			session.setAttribute("alertMsg", "지시서가 작성되지 못했습니다.");
			return "redirect:/task/order/list";
		}
	}
	
	
	
}
