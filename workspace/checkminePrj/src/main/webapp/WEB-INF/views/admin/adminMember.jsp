<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/adminCommon/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECKMINE 사원관리</title>
<style>


    main > div {
        width: 1389px;
        margin: 10px auto;
    }
    
    #area1{
        height: 65px;
        display: flex;
        justify-content:space-between;
        align-items: center;
    }
    #area2{
        height: 65px;
        display: flex;
        justify-content:space-between;
        align-items: center;
    }

    #listArea{
        height: 596px;
        margin: 20px auto;
        border: 1px solid lightgray;
    }
    #pageArea {
        height: 30px;
        display: flex;
        justify-content: center;
    }
    #header{
        font-size: 20px;
        font-weight: bolder;
    }

    .btn{
        width: 178px;
        font-size: 16px;
        background-color: #5D736F; 
        border-radius: 30px;
        color: white;
    }

    #filter{
        width: 110px;
    }
    #option{
        width: 183px;
    }

    input[type="text"]{
        width: 230px;
        display: inline-block;
        border: none;
    }
    #search{
        background:url(${root}/resources/img/admin/search.png);
        background-repeat: no-repeat;
        width:20px;
        height:20px;
        border: none;
        
    }
    #listArea > table{
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        
    }

    #pageArea > a{
        padding: 15px;
        text-decoration: none;
        color: black;
    }
   

</style>
</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/adminCommon/adminSide-nav.jsp" %>
        
        <main class="shadow">
            <div id="area1">
                <span id="header">사원 관리</span>
                <button type="button" class="btn">사원등록</button>
            </div>
			<div id="area2">
                <select class="form-select" id="filter">
                    <option>모두</option>
                    <option>재직</option>
                    <option>퇴직</option>
                </select>
                <form action="">
                    <select class="form-select" id="option" required style="display: inline-block;">
                        <option>이름</option>
                        <option>부서</option>
                        <option>아이디</option>
                    </select>
                    <div style="width: 267px; border: 1px solid lightgray; display: inline-block;" >
                        <input type="text" name="keyword" id="keyword" class="form-control" required>
                        <input type="submit" id="search" value="">
                    </div>
                    
                </form>
          


            </div>
            <div id="listArea">
                <table class="table table-hover">
                    <thead style="background-color: #C4F2EA;">
                        <tr>
                            <th>사원번호</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직위</th>
                            <th>아이디</th>
                            <th>입사일자</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody style="border-top: none;">
                        <tr onclick="location.href='#'">
                            <td>1</td>
                            <td>테스트</td>
                            <td>총무부</td>
                            <td>대리</td>
                            <td>CHECKMINE1</td>
                            <td>2022.10.13</td>
                            <td>재직</td>
                        
                        </tr>

                    </tbody>
                    
                </table>
            </div>
            <div id="pageArea">
                <a href="#">&lt;</a>
                <a href="#">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">&gt;</a>
            </div>
        </main>
    </div>
</body>
</html>