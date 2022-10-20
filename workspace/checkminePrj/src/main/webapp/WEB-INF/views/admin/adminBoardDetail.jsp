<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/adminCommon/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECKMINE 게시물 상세보기</title>
<style>


    main > div {
        width: 1450px;
        margin: 10px auto;
    }
    
    #area{
        height: 130px;
        display: flex;
        justify-content:space-between;
        align-items: center;
    }
    #infoWrap{
        height: 700px;
    }
    #area button:first-child{
        width: 20px; 
        height: 20px; 
        border: none; 
        background-color: white;
        font-size: 20px;
        font-weight: bolder;
    }

    #header{
        font-size: 20px;
        font-weight: bolder;
    }
    #title{
        width: 1450px;
        height: 70px;
        background-color: #B0D9D1;
        border-bottom: 1px solid black;
    }
    #title > div{
        font-size: 30px;
        margin-left: 20px;
        line-height: 65px;
    }
    #info{
        height: 40px;
        border-bottom: 1px solid #5D736F;
        display: flex;
        justify-content: end;
    }
    #info > div{
        display: inline-block;
        margin-right: 15px;
        line-height: 40px;
        font-size: 20px;
    }
    #content-box{
        height: 550px;
        overflow: auto;
        margin-bottom: 10px;
    }
    #content{
   		width:98%;
   		min-height: 340px;
        margin: 10px;
        border-bottom: 1px solid #5D736F;
        display: inline-block;
    }
    #content > img {
        max-width: 100%;
        display: block;
    }
    #replyArea{
        height: 150px;
        margin: 20px;
        
    }
    #reply-bot{
        margin-left: 30px;
        border-bottom: 1px solid lightgrey;

    }
    #replyTitle{
        color: #5D736F;
        font-weight: bolder;
    }
    #replyWriter{
        width: 100%;
    }
    #replyWriter > div{
        display: inline-block;
        margin-right: 10px;
    }
    
    #replyWriter button {
        background-color: white;
        border: none;
        color: gray;
        
    }
    textarea {
        resize: none;
        border: 1px solid gray;
        width: 1300px;
        margin-left: 30px;
        margin-top: 5px;
    }
    #write > button{
        background-color: #5D736F;
        border: none;
        color: white;
        height: 30px;
        width: 60px;
        margin: auto;
    }
    #write {
        display: flex;
        justify-content: space-around;
    }
    .btn{
        width: 88px;
        font-size: 16px;
        background-color: #5D736F; 
        border-radius: 10px;
        color: white;
    }
    #buttonArea{
        display: flex;
        justify-content:right;
    }
    #buttonArea > button{
        margin-right: 10px;
    }

  


  
    
    
   

</style>
</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/adminCommon/adminSide-nav.jsp" %>
        
        <main class="shadow">
            <div id="area">
                <div>
                    <button onclick="history.back()">←</button>
                    <span id="header">&nbsp;&nbsp;상세보기</span>
                </div>
            </div>
            
            <div id="infoWrap">
                <div id="title">
                	<div>
                	<c:if test="${board.type eq 'N'}">[공지]&nbsp</c:if>
                		${board.title}
                	</div>
                </div>
                <div id="info"><div>조회수 ${board.hit}</div><div id="writer"><b>${board.department}&nbsp${board.writer}</b></div><div>${board.enrollDate}</div></div>
                <div id="content-box">
                    <div id="content">
                    	<c:if test="${fn:length(attList) != 0}">
                    		<c:forEach items="${attList}" var="a">
                    			<c:choose>
                    				<c:when test="${fn:endsWith(a.name, '.png')}">
                    					<img src="${root}/resources/upload/board/${a.name}">
                    				</c:when>
                    				<c:when test="${fn:endsWith(a.name, '.jpg')}">
                    					<img src="${root}/resources/upload/board/${a.name}">
                    				</c:when>
                    				<c:when test="${fn:endsWith(a.name, '.gif')}">
                    					<img src="${root}/resources/upload/board/${a.name}">
                    				</c:when>
	                    			<c:otherwise>
	                    				<a download href="${root}/resources/upload/board/${a.name}">${a.name}</a>
	                    			</c:otherwise>
                    		</c:choose>
                    		</c:forEach>
                    	</c:if>
                        ${board.content}
                    </div>
                    <div id="replyArea">
                        <div id="replyTitle">댓글</div>
                        <c:if test="${fn:length(replyList) != 0}">
                    		<c:forEach items="${replyList}" var="r">
	                        <div id="reply-bot">
	                            <div id="replyWriter"><div>${r.replier}&nbsp${r.position}</div><div>${r.replyDate}</div><button type="button" id="deleteReply" onclick="deleteReply()">삭제</button></div>
	                            <div>${r.content}</div>
	                        </div>
                        	</c:forEach>
                        </c:if>
                        <div id="write">
                            <textarea name="content" id="text" placeholder="댓글을 남겨보세요."></textarea><button type="button" id="add">등록</button>
                        </div>


                    </div>
                    


                </div>
                <div id="buttonArea">
                    <button type="button" class="btn" id="correct" onclick = "location.href = '#'">수정</button>
                    <button type="button" class="btn" id="delete" onclick="deleteBoard()">삭제</button>
                </div>
                
            </div>
            
 
            
        </main>
    </div>

    <script>
	  //게시물 삭제 시 컨펌으로 한번더 확인
	    function deleteBoard(){
	        const answer = confirm('해당 게시물을 삭제할까요?');
	        if(answer == true){
	            location.href="##";
	        }
	    }


    </script>
</body>
</html>