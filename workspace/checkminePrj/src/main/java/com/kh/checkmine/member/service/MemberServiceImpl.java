package com.kh.checkmine.member.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.checkmine.board.vo.BoardVo;
import com.kh.checkmine.board.vo.ReplyVo;
import com.kh.checkmine.mail.dao.MailDao;
import com.kh.checkmine.mail.vo.MailVo;
import com.kh.checkmine.member.dao.MemberDao;
import com.kh.checkmine.member.vo.MemberVo;
import com.kh.checkmine.schedule.vo.ScheduleVo;
import com.kh.checkmine.task.vo.TaskOrderVo;

@Service
public class MemberServiceImpl implements MemberService {
	
	private final SqlSessionTemplate sst;
	private final MemberDao dao;
	private final BCryptPasswordEncoder pwdEnc;
	private final MailDao mailDao;
	
	@Autowired
	public MemberServiceImpl(SqlSessionTemplate sst, MemberDao dao, BCryptPasswordEncoder pwdEnc, MailDao mailDao) {
		this.sst = sst;
		this.dao = dao;
		this.pwdEnc = pwdEnc;
		this.mailDao = mailDao;
	}

	@Override
	public MemberVo login(MemberVo vo) {
		
		MemberVo dbMember = dao.selectOneById(sst, vo);
		
		if(dbMember != null) {
			if(pwdEnc.matches(vo.getPwd(), dbMember.getPwd())) {			
				return dbMember;
			}else {
				return null;
			}
		}else {
			return null;
		}
		
	}

	@Override
	public int changePwd(MemberVo vo) {
		vo.encodePwd(pwdEnc);
		
		return dao.updatePwd(sst, vo);
	}

	@Override
	public int changeInfo(MemberVo vo) {
		return dao.updateInfo(sst, vo);
	}

	@Override
	public MemberVo selectOneByNo(String no) {
		return dao.selectOneByNo(sst, no);
	}

	@Override
	public MemberVo changePhoto(MemberVo vo) {
		int result = dao.updatePhoto(sst, vo);
		
		MemberVo updatedMember = null;
		if(result == 1) {
			updatedMember = dao.selectOneByNo(sst, vo.getNo());
		}
		
		return updatedMember;
	}

	@Override
	public String findIdByMail(String email) {
		return dao.selectIdByMail(sst, email);
	}

	@Override
	public String findMailByVo(MemberVo vo) {
		return dao.selectMailByOne(sst, vo);
	}

	@Override
	public int changePwdById(MemberVo vo) {
		vo.encodePwd(pwdEnc);
		
		return dao.updatePwdById(sst, vo);
	}

	@Override
	public HashMap<String, Object> getUserInfo (String access_Token) {
		
	    //???????????? ????????????????????? ?????? ????????? ?????? ??? ????????? HashMap???????????? ??????
	    HashMap<String, Object> userInfo = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	   
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        //????????? ????????? Header??? ????????? ??????
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        System.out.println(access_Token);
	        
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("===========================");
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("response body : " + result);
	        
	        JsonElement element = JsonParser.parseString(result);
	        
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        
	        System.out.println(kakao_account);
	        if(kakao_account.get("email") != null) {
	        	String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        	userInfo.put("email", email);
	        }
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return userInfo;
	}

	@Override
	public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST ????????? ?????? ???????????? false??? setDoOutput??? true???
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST ????????? ????????? ???????????? ???????????? ???????????? ?????? ??????
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=9f5225ef543fafc73d86a09fb5c33da9");
            sb.append("&redirect_uri=http://localhost:8888/checkmine/member/kakaoLogin");
            sb.append("&code=" + authorize_code);
            //sb.append("&property_keys=kakao_account.email");
            bw.write(sb.toString());
            bw.flush();
            
            //    ?????? ????????? 200????????? ??????
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    ????????? ?????? ?????? JSON????????? Response ????????? ????????????
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //    Gson ?????????????????? ????????? ???????????? JSON?????? ?????? ??????
            JsonElement element = JsonParser.parseString(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        } 
        
        return access_Token;
    }

	@Override
	public List<MailVo> selectMailList(String no) {
		return dao.selectMailList(sst, no);
	}

	@Override
	public List<TaskOrderVo> selectTaskList(String no) {
		return dao.selectTaskList(sst, no);
	}

	@Override
	public List<BoardVo> selectBoardList(String no) {
		return dao.selectBoardList(sst, no);
	}

	@Override
	public List<ReplyVo> selectReplyList(String no) {
		return dao.selectReplyList(sst, no);
	}

	@Override
	public List<ScheduleVo> selectEventList(String no) {
		return dao.selectEventList(sst, no);
	}

	@Override
	public int getPublicCnt(String no) {
		return dao.getPublicCnt(sst, no);
	}

	@Override
	public int countMail(String no) {
		//????????? ???????????? ?????????
		HashMap<String, String> mailCountMap1 = new HashMap<String, String>();
		mailCountMap1.put("memberNo", no);
		mailCountMap1.put("type", "A");
		//????????? ???????????? ?????????
		HashMap<String, String> mailCountMap2 = new HashMap<String, String>();
		mailCountMap2.put("memberNo", no);
		mailCountMap2.put("type", "R");
		int mailSum = mailDao.getNotReadCount(sst, mailCountMap1) + mailDao.getNotReadCount(sst, mailCountMap2);
		return mailSum;
	}


}//class
