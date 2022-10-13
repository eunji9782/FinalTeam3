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
    }
    #content{
        height: 350px;
        margin: 10px;
        border-bottom: 1px solid #5D736F;
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
                <div id="title"><div>공지사항 기타 내용</div></div>
                <div id="info"><div id="writer"><b>관리자</b></div><div>2022.10.13</div></div>
                <div id="content-box">
                    <div id="content">
                        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    </div>
                    <div id="replyArea">
                        <div id="replyTitle">댓글</div>
                        <div id="reply-bot">
                            <div id="replyWriter"><div>테스트 사원</div><div>2022.10.13</div><button type="button" id="deleteReply" onclick="deleteReply()">삭제</button></div>
                            <div>댓글 내용 어쩌구 </div>
                        </div>
                        <div id="write">
                            <textarea name="content" id="text" placeholder="댓글을 남겨보세요."></textarea><button type="button" id="add">등록</button>
                        </div>


                    </div>
                    


                </div>
                <div id="buttonArea">
                    <button type="button" class="btn" id="correct" onclick = "location.href = '#'">수정</button>
                    <button type="button" class="btn" id="delete" onclick="confirm('해당 게시물을 삭제할까요?')">삭제</button>
                </div>
                
            </div>
            
 
            
        </main>
    </div>

    <script>
        


    </script>
</body>
</html>