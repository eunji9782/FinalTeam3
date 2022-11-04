<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

    .shadow{
       padding: 20px;
       display: flex;
       flex-direction: row;
       flex-wrap: wrap;
       justify-content: flex-start;
    }

    #top{
        width: 100%;
        height: 10%;
    }

    #side{
        width: 170px;
        height: 740px;
        background-color: #C4F2EA;
        border-radius: 10px;
    }

    #side-content{
        text-align : center;
        padding : 100px 0;
        display: flex;
        flex-direction: column;
    }

    #side-content a{
        color: black;
        text-decoration: none;
    }

    #side-content *{
        margin-top: 30px;
    }

    #side-goods{
        display: grid;
        grid-template-columns: repeat(1, 1fr);
    }

    #side-place{
        display: grid;
        grid-template-columns: repeat(1, 1fr);
    }

    .content{
        width: 70%;
        height: 90;
        display: grid;
    }

    #content-top{
        width: 100%;
        height: 20%;
        padding-left: 2%;
        grid-column: 1/span 2;
        margin-bottom: 0%;
    }

    #content-goods{
        width: 100%;
        height: 100%;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        text-align: center;
    }

    #content-goods>h3{
        grid-column: 1/span 3;
    }

    #content-goods button{
        background: #5D736F;
        border-radius: 10px;
        color: white;
    }

    #content-place{
        width: 100%;
        height: 100%;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        text-align: center;
    }

    #content-place>h3{
        grid-column: 1/span 3;
    }

    #content-place button{
        background: #5D736F;
        border-radius: 10px;
        color: white;
    }

    .modal a{
        background: #5D736F;
        border-radius: 10px;
        color: white;
    }

</style>
</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/common/side-nav.jsp" %>
        
        <main class="shadow">

			<div id="top">

                <h1>예약</h1>
			    <hr>

            </div>

            <div id="side">
                
                <div id="side-content">

                    <h4><a href="/checkmine/reservation/myreservation">나의 예약</a></h4>

                    <div id="side-goods">
                        <h4>공유물</h4>

                        <a href="/checkmine/reservation/goodsone">빔 프로젝트</a>
                        <a href="/checkmine/reservation/goodstwo">법인차</a>
                    </div>

                   <div id="side-place">
                        <h4>장소</h4>

                        <a href="/checkmine/reservation/placeone">회의실</a>
                        <a href="/checkmine/reservation/placetwo">응접실</a>
                   </div>

                </div>
                
            </div>

            <div class="content">

                <div id="content-top">
                    <h1>나의 예약</h1>
                </div>
    
                <div id="content-goods">
                    <h3>공유물</h3>
					<c:forEach items="${voListGoods}" var="vo">
                    <div id="name" value="${vo.no}">${vo.name}</div>

                    <div id="time">${vo.borrow} ~ ${vo.rsvEnd}</div>

                    <div id="rd-btn">
                        <button id="reservation" class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModalGoods">예약 취소</button>
                    </div>
                    </c:forEach>
                </div>

                <div id="content-place">
                    <h3>장소</h3>
					<c:forEach items="${voListPlace}" var="vo">
                    <div id="name" value="${vo.no}">${vo.name}</div>

                    <div id="time">${vo.rsvBegin} ~ ${vo.rsvEnd}</div>

                    <div id="rd-btn">
                        <button id="reservation" class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModalPlace">예약 취소</button>
                    </div>
					</c:forEach>                    
                </div>

            </div>

            <!-- Modal 스타일 -->
            <style>
                #exampleModal #reservation{
                    background: #5D736F;
                    border-radius: 10px;
                    color: white;
                }

                #exampleModal #close{
                    background: white;
                    border-radius: 10px;
                    color: #5D736F;
                }
            </style>

             <!-- 공유물 취소 -->
             <div class="modal fade" id="exampleModalGoods" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">예약취소</h1>
                        </div>

                        <div class="modal-body">
                            예약을 정말 취소하시겠습니까?
                        </div>

                        <div class="modal-footer">
                            <a href="${rootPath}/reservation/goodsDelbtn/${no}" id="goods-reservation" class="btn btn-light btn-sm">예</a>
                            <button id="close" class="btn btn-light btn-sm" data-bs-dismiss="modal">아니오</button>
                        </div>
                    </div>
                </div>
             </div>

             <!-- 장소 취소 -->
             <div class="modal fade" id="exampleModalPlace" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">예약취소</h1>
                        </div>

                        <div class="modal-body">
                            예약을 정말 취소하시겠습니까?
                        </div>

                        <div class="modal-footer">
                            <a href="${rootPath}/reservation/placeDelbtn/${no}" id="place-reservation" class="btn btn-light btn-sm">예</a>
                            <button id="close" class="btn btn-light btn-sm" data-bs-dismiss="modal">아니오</button>
                        </div>
                    </div>
                </div>
             </div>

        </main>
    </div>

    <script>
        $('#goods-reservation').on('click', function(){
            $.ajax({
                url  :  '${rootPath}/reservation/goodsDelbtn',
                method : 'get',
                data : JSON.stringify({no : $('#name').attr('value')}),
                dataType : 'text',
                contentType : 'application/json',
                success : function(){
                    console.log('성공');
                }
                })
        })

        $('#place-reservation').on('click', function(){
            $.ajax({
                url  :  '${rootPath}/reservation/placeDelbtn',
                method : 'get',
                data : JSON.stringify({no : $('#name').attr('value')}),
                dataType : 'text',
                contentType : 'application/json',
                success : function(){
                    console.log('성공');
                }
                })
        })
    </script>

</body>
</html>