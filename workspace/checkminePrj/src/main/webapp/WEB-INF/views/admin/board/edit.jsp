<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/adminCommon/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECKMINE 글 수정하기</title>
    
<!-- summernote -->
<script src="${root}/resources/summernote/summernote-lite.js"></script>
<script src="${root}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${root}/resources/summernote/summernote-lite.css">

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
        border: 1px solid lightgrey;
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
        width: 100%;
        border-bottom: 1px solid lightgray;
    }

    #title input{
        height: 100%;
        width: 100%;
        border: none;
    }

    #content{
        height: 590px;
        margin: 10px;
        border: 1px solid #5D736F;
    }

    input[name=attach]{
        width: 200px;
        display: none;
    }

    #showFiles{
        width: 350px;
        height: 38px;
        overflow: auto;
        font-size: small;
        margin-left: 10px;
    }

    #attach label {
        color: white;
        height: 38px;
        width: 100px;
        line-height: 35px;
        text-align: center;
        background-color: #5D736F;
        cursor: pointer;
        border-radius: 30px;
    }
  
    #regist{
        width: 178px;
        font-size: 16px;
        background-color: #5D736F; 
        border-radius: 30px;
        color: white;
    }

    #footer{
        margin: 10px;
        display: flex;
        justify-content: space-between;
    }

    .dropdown-toggle::after {
        display:none;
    }

    .note-modal-footer{
        height: 50px;
    }

    .note-modal-footer .note-btn{
        background-color: #5D736F; 
        color: white;
        opacity: 100%;
        border: none;
    }
    
    .note-editable{
    	background-color: white; 
    }
</style>
</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/adminCommon/adminSide-nav.jsp" %>
        
        <main class="shadow">
            <div id="area">
                <div>
                    <button type="button" onclick="history.back()">←</button>
                    <span id="header">&nbsp;&nbsp;글 수정하기</span>
                </div>
            </div>
            
            <div id="infoWrap">
                <form action="${root}/admin/board/edit/${board.no}" name="form" method="post" enctype="multipart/form-data" onSubmit="return Checkform();">
                    <div id="title"><input type="text" class="form-control" value=${board.title} name="title"></div>
                    <div id="content-box">
                        <div id="content">
                            <textarea class="summernote" name="content">${board.content}</textarea>
                        </div>
                        <div id="footer">
                            <div style="display: flex; align-items: flex-start;">
                                <div id="attach">
                                    <label for="file">첨부파일</label> 
                                    <input type="file" name="attach" id="file" multiple>
                                </div>
                                    <div style="display: inline-block;" id="showFiles"></div>
                                </div>
                            <div id="buttonArea"><button type="submit" class="btn" id="regist">수정하기</button></div>
                        </div>
                    </div>
                </form>
            </div> 
        </main>
    </div>
   
    <script>
        //첨부된 파일 목록 보여주기
        target = document.querySelector('input[name=attach]');
            target.addEventListener('change', function(){
                fileList = "";
                for(i = 0; i < target.files.length; i++){
                    fileList += target.files[i].name + '<br>';
                }
                target2 = document.getElementById('showFiles');
                target2.innerHTML = fileList + '----- 총 ' + target.files.length +'개 -----';
            });
    </script>

    <script>
        //썸머노트 적용
        $('.summernote').summernote({
            height: 533,
            lang: "ko-KR",
            disableResizeEditor: true,
           
            //콜백 함수
            callbacks : { 
            	onImageUpload : function(files, editor, welEditable) {
            // 파일 업로드(다중업로드를 위해 반복문 사용)
            for (var i = files.length - 1; i >= 0; i--) {
            uploadSummernoteImageFile(files[i], this);
            		}
            	}
            }
	    });
        
        //썸머노트 이미지 업로드 ajax
        function uploadSummernoteImageFile(file, el) {
                data = new FormData();
                data.append("file", file);
                $.ajax({
                    data : data,
                    type : "POST",
                    url : "${root}/admin/board/uploadSummernoteImageFile",
                    contentType : false,
                    enctype : 'multipart/form-data',
                    processData : false,
                    success : function(data) {
                        $(el).summernote('editor.insertImage', "${root}/resources/upload/board/" +data.fileName);
                    }
                });
            }

        //필수 입력값 확인
        function Checkform(){
            if(form.title.value == "") {
                form.title.focus();
                alert("제목을 입력해주세요.");
                return false;
            }else if(form.content.value == ""){
                alert("내용을 입력해주세요.");
                return false;
            }
        }
    </script>
</body>
</html>