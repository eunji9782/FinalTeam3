package com.kh.checkmine.admin.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.kh.checkmine.admin.board.service.AdminBoardService;
import com.kh.checkmine.admin.vo.AdminVo;
import com.kh.checkmine.board.vo.BoardAttVo;
import com.kh.checkmine.board.vo.BoardVo;
import com.kh.checkmine.common.FileUploader;
import com.kh.checkmine.common.PageVo;
import com.kh.checkmine.common.Pagination;

/*
 * 관리자 > 게시판
 * */
@Controller
@RequestMapping("admin/board")
public class AdminBoardController {
	
	private final AdminBoardService service;
	
	@Autowired
	public AdminBoardController(AdminBoardService service) {
		this.service = service;
	}
	
	//게시물 조회
	@GetMapping("list")
	public String list(@RequestParam(value = "p", defaultValue = "1") int pno, @RequestParam(value = "sort", defaultValue = "a") String sort, Model model) {
		
		int totalCount = service.selectTotalCnt(sort);
		
		PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 15);
		
		List<BoardVo> boardList = service.selectBoardList(pv, sort);
		model.addAttribute("boardList", boardList);
		model.addAttribute("sort", sort);
		model.addAttribute("pv", pv);
		return "admin/board/list";
		
	}
	
	
	//게시물 선택삭제
	@PostMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="checkArr[]") ArrayList<String> checkArr, HttpSession session) {
		 
		 for(int i = 0; i < checkArr.size(); i++) { 
			 int result = service.delete(checkArr.get(i));
		 if(result == -1) { 
			 session.setAttribute("msg", "게시글 삭제 실패"); 
			 return "fail"; 
			 }
		 }
		 
		return "ok";
	}
	
	//게시물 검색
	@GetMapping("search")
	public String search(@RequestParam(value = "p", defaultValue = "1") int pno, @RequestParam String option, @RequestParam String keyword, Model model) {
		Map<String, String> map = new HashMap<>(2);
		map.put("option", option);
		map.put("keyword", keyword);
		int totalCount = service.selectKeywordCnt(map);
		
		PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 15);
		
		List<BoardVo> boardList = service.selectBoardKeyword(pv, map);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pv", pv);
		model.addAttribute("option", option);
		model.addAttribute("keyword", keyword);
		
		return "admin/board/search";
	}
	
	//공지사항 작성 페이지
	@GetMapping("write")
	public String write() {
		return "admin/board/noticeWrite";
	}
	
	//공지사항 작성
	@PostMapping("write")
	public String write(BoardVo vo, BoardAttVo attVo, HttpServletRequest req, HttpSession session) {
		String loginAdminNo = ((AdminVo)session.getAttribute("loginAdmin")).getNo(); 
		
		vo.setWriter(loginAdminNo);
		vo.setType("N"); //관리자 화면에서는 공지사항 작성만 
		
		int result = 0;
		
		//첨부파일 업로드 후 attVo에 담기
		MultipartFile[] fArr =  attVo.getAttach();
		List<BoardAttVo> attVoList = new ArrayList<BoardAttVo>();
		
		if(!fArr[0].isEmpty()) { //전달받은 파일있음
			String savePath = req.getServletContext().getRealPath("/resources/upload/board/");
			
			for(int i = 0; i < fArr.length; i++) {
				BoardAttVo att = new BoardAttVo();
				MultipartFile f = fArr[i];
				
				String changeName = FileUploader.fileUpload(f, savePath);
				att.setName(changeName);
				att.setFilePath(savePath);
				attVoList.add(att);

			}

			result = service.insertBoard(vo, attVoList);

		}else {
			//첨부파일 없이 글만 작성
			result = service.insertBoard(vo);
		}
		
		if(result > 0) {
			session.setAttribute("msg", "정상적으로 등록되었습니다.");
			return "redirect:/admin/board/list";
			
		}else {
			//문제 발생하면 이전에 올렸던 파일 제거
			if(!attVoList.isEmpty()) {
				for(int i = 0; i < attVoList.size(); i++) {
					String savepath = attVoList.get(i).getFilePath()+ attVoList.get(i).getName();
					new File(savepath).delete();
				}
			}
			session.setAttribute("msg", "죄송합니다. 문제가 발생하였습니다.");
			return "redirect:/admin/board/list";
			
		}
	}
	
	//상세보기
	@GetMapping("detail/{no}")
	public String detail(@PathVariable String no, Model model) {
		BoardVo vo = service.selectOne(no);
		
		List<BoardAttVo> attList = service.selectAttList(no);
	
		model.addAttribute("board", vo);
		model.addAttribute("attList", attList);
			
		return "admin/board/detail";
	}
	
	
	//게시물 삭제
	@GetMapping("delete/{no}")
	public String delete(@PathVariable String no, HttpSession session, Model model) {
		int result = service.delete(no);
		
		if(result == 1) {
			session.setAttribute("msg", "게시물을 삭제하였습니다.");
			return "redirect:/admin/board/list";
		}else {
			session.setAttribute("msg", "삭제 처리 중 문제가 발생하였습니다.");
			return "redirect:/admin/board/list";
		}
	}
	
	
	//게시물 수정 화면
	@GetMapping("edit/{no}")
	public String edit(@PathVariable String no, Model model) {
		BoardVo boardVo = service.selectOne(no);
		model.addAttribute("board", boardVo);
		
		return "admin/board/edit";
	}
	
	
	//게시물 수정
	@PostMapping("edit/{no}")
	public String edit(@PathVariable String no, BoardVo boardVo, BoardAttVo attVo, HttpSession session, HttpServletRequest req) {

		//기존 파일 있는지 확인
		List<BoardAttVo> existFileList = service.selectAttList(no);
		
		//새로 첨부된 파일 처리
		int result = 0;
		
		MultipartFile[] fArr =  attVo.getAttach();
		List<BoardAttVo> attVoList = new ArrayList<BoardAttVo>();
		
		if(!fArr[0].isEmpty()) { //전달받은 파일있음
			//기존 파일 삭제 (저장소 내 파일)
			String savePath = req.getServletContext().getRealPath("/resources/upload/board/");
			
			if(!existFileList.isEmpty()) {
				for(int i = 0; i < existFileList.size(); i++) {
					File file = new File(savePath + existFileList.get(i).getName());
					if(file.exists()) {
						file.delete();
					}
				}	
			}
			
			for(int i = 0; i < fArr.length; i++) {
				BoardAttVo att = new BoardAttVo();
				MultipartFile f = fArr[i];
				
				String changeName = FileUploader.fileUpload(f, savePath);
				att.setName(changeName);
				att.setFilePath(savePath);
				att.setBNo(no);
				attVoList.add(att);
			}
		
			result = service.edit(boardVo, attVoList, existFileList);
			
		}else {
			//제목 또는 내용만 수정 시
			result = service.edit(boardVo);
		}

		if(result > 0) {
			session.setAttribute("msg", "게시물을 수정하였습니다.");
			return "redirect:/admin/board/detail/" + no;
		}else {
			session.setAttribute("msg", "처리 중 문제가 발생하였습니다.");
			return "redirect:/admin/board/list";
		}
	}
	
	//썸머노트 본문 파일 처리
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest req)  {
		JsonObject jsonObject = new JsonObject();
	
		// 내부경로로 저장
		String savePath = req.getServletContext().getRealPath("/resources/upload/board/");
		String changeName = FileUploader.fileUpload(multipartFile, savePath);

		jsonObject.addProperty("fileName", changeName); 
		jsonObject.addProperty("responseCode", "success");
		
		String a = jsonObject.toString();
		return a;
	}
	

}
