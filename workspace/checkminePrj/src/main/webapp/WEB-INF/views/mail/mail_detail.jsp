<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CheckMine - 메일</title>
<link rel="stylesheet" type="text/css" href="/checkmine/resources/css/mail/mail_basic.css">
<link rel="stylesheet" type="text/css" href="/checkmine/resources/css/mail/mail_detail.css">

<c:set var="imgPath" value="/checkmine/resources/img/mail"/>

</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/common/side-nav.jsp" %>
        
        <main class="shadow">
			
            <div id="container-header" class="d-flex align-items-center">
                <span style="font-size: 30px;">메일</span>
                <div>
                    <img src="${imgPath}/mail_search.png">
                    <input type="text" placeholder="메일검색">
                </div>
            </div>

            <hr style="height: 2px;">

            <div class="d-flex" style="padding-top: 8px;">
                <div id="container-nav">
                    <div>
                        <img src="${imgPath}/mail_send.png">
                        <span>메일 쓰기</span>
                    </div>

                    <ul>
                        <li><div class="container-nav-selected"><a href="">받은편지함</a><span>21</span></div></li>
                        <li><div><a href="">보낸편지함</a><span>21</span></div></li>
                        <li><div><a href="">중요편지함</a><span>21</span></div></li>
                        <li><div><a href="">임시보관함</a><span>21</span></div></li>
                        <li><div><a href="">휴지통</a></div></li>
                        <li><div><a href="">주소록</a></div></li>
                    </ul>
                </div>
                <!-- 여기까지 -->
                <div>
                    <div style="margin-left: 12px; margin-bottom: 3px;">받은편지함</div>
                    <div id="detail-container">
                        <div class="d-flex">
                            <a href=""><img src="${imgPath}/mail_d_arrow_pre.png"></a>
                            <a href=""><img src="${imgPath}/trash_icon.png"></a>
                            <a href=""><img src="${imgPath}/mail_d_star_blank.png"></a>
                            <a href=""><img src="${imgPath}/mail_d_reply.png"></a>
                        </div>

                        <div id="title">제목제목제목제목제목제목제목제목제목제목제목제목제목제목</div>

                        <div class="d-flax">
                            <span>보낸이 : chan0966@gmail.com</span> 
                            <button onclick="">주소록에 추가</button>
                            <span id="time">2022.10.13 12:49</span>
                        </div>

                        <div id="content">
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                            내용내용내용내용내용내용내용내용내용내용내용내용내용
                        </div>

                        <button>
                            <img src="${imgPath}/mail_d_reply.png">
                            답장
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>