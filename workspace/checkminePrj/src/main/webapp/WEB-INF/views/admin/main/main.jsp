<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/adminCommon/adminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECKMINE 관리자 페이지</title>
    <!-- 풀캘린더 적용 -->
    <link href='${root}/resources/fullcalendar-5.11.3/lib/main.css' rel='stylesheet' />
	<script src='${root}/resources/fullcalendar-5.11.3/lib/main.js'></script>
</head>
<style>
    a{
        text-decoration: none;
        color: black;
    }

    .shadow{
        display: grid;
        grid-template-rows: 1fr 4fr;
        grid-template-columns: repeat(3, 1fr);
    }

    #summary{
        width: 738px;
        height: 181px;
        background-color: #B0D9D1;
        border-radius: 30px;
        display: grid;
        grid-template-rows: 1fr 4fr;
        grid-template-columns: repeat(6, 1fr);
        margin: 60px auto;
        grid-column: span 3;
    }

    #summaryHeader{
        font-size: 20px;
        font-weight: bolder;
        grid-column: span 6;
        margin : 10px 60px;
    }

    .summaryItem{
        margin: auto;
        font-size: 15px;
        text-align: center;
        line-height: 30px;
    }

    .summaryItem > img{
        width: 40px;
        height: 40px;
    }

    .area{
        width: 490px;
        height: 510px;
        margin: 0 8px;
        display: flex;
        flex-direction: column;
    }

    .area > div{
        border: 1px solid lightgray;
        height: 500px;
        margin: 10px;
    }

    .header{
        font-size: 20px;
        font-weight: bolder;
        grid-column: span 6;
        margin : 18px 20px;
        display: inline-block;
        margin-bottom : 40px;
    }

    .list{
        font-size: 13px;
        margin: 0px 20px;
        margin-bottom: 18px;
        border-bottom: 1px solid lightgray;
        width: 428px;
        height: 26px
    }

    .list > span, .list a{
        display: inline-block;
        width: 250px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    #date{
        color: gray;
        width: 130px;
        text-align: end;
        float: right;
        font-size: smaller;
    }

    #more{
        float: right;
        margin: 16px 15px;
        color: gray;
        font-size: 13px;
        background-color: white;
        border: none;
    }

    #currentTime{
        text-align: center;
        line-height: 100px;
        height: 150px;
        border: none;
    }

    #calendar-area{
        border: none;
    }

    #calendar{
        width: 350px;
        height: 345px;
        margin: 0 auto;
    }
   
    .modal-content{
        width: 700px;
        height: 500px;
        padding: 20px;
    }

    .modal-body{
        overflow: auto;
    }

    .list-header{
        text-align: left;
    }

    .book-list {
        margin: 0 auto;
        width: 500px;
    }

    .book-list *{
        width: 250px;
        text-align: center;
        padding: 5px;
    }
    
    a.fc-event {
	  border-radius: 10px; /* round edges */
	  width: 10px; /* fixed width */
      height: 5px;
	  color: transparent; /* hide text */
	}

    .fc-event-title-container{
        height: 5px;
    }

    .fc-daygrid-day-frame{
        height: 46px;
    }
</style>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/adminCommon/adminSide-nav.jsp" %>
        
        <main class="shadow">
			<div id="summary">
                <!-- 총 사원 수를 제외한 항목들 오늘을 기준으로 조회함 -->
                <div id="summaryHeader">요약</div>
                <div class="summaryItem" style="grid-column: 2;">
                    <img src="${root}/resources/img/admin/user-icon.png">
                    <div>사원정보 변동</div>
                    <div id="memberChange">${summary.EMPLOYEECHANGE}건</div>
                </div>
                <div class="summaryItem">
                    <img src="${root}/resources/img/admin/user-icon-b.png">
                    <div>총 사원수</div>
                    <div id="memberTotal">${summary.EMPLOYEETOTAL}명</div>
                </div>
                <div class="summaryItem">
                    <img src="${root}/resources/img/admin/board-icon.png">
                    <div>등록된 게시물수</div>
                    <div id="boardTotal">${summary.BOARD}건</div>
                </div>
                <div class="summaryItem">
                    <img src="${root}/resources/img/admin/time-icon.png">
                    <div>오늘 예약건</div>
                    <div id="bookTotal">${summary.BOOK}건</div>
                </div>
            </div>

            <div class="area">
                <div id="memberChangeArea">
                    <div class="header">사원정보 변동</div>
                    <c:forEach items="${memberList}" var="m" end="2">
                        <div class="list">
                            <span>${m.name}님이 
                                <c:choose>
                                    <c:when test="${m.modifyDate ne null}">
                                        수정되었습니다.
                                    </c:when>
                                    <c:otherwise>
                                        등록되었습니다.
                                    </c:otherwise>
                                </c:choose>
                            </span>  
                            <span id="date">
                                <c:choose>
                                    <c:when test="${m.modifyDate ne null}">
                                        ${m.modifyDate}
                                    </c:when>
                                    <c:otherwise>
                                        ${m.enrollDate}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </c:forEach>
                </div>
    
                <div id="bookArea">
                    <div class="header">예약 현황</div>
                    <button id="more" data-bs-toggle="modal" data-bs-target="#myModal">더보기</button>
                    <c:forEach items="${bookList}" var="r" end="2">
                        <div class="list">
                            <span>[${r.plNo}] ${r.empNo}님이 예약하였습니다.</span>  
                            <span id="date">${r.rsvDate}</span>
                        </div>
                    </c:forEach>

                    <c:if test="${fn:length(bookList) == 0}">
                        <div class="list">금일 예약된 장소가 없습니다.</div>
                    </c:if>
                </div>
            </div>

            <div class="area">
                <div id="boardArea">
                    <div class="header">게시판 현황</div>
                    <a href="${root}/admin/board/list" id="more">더보기</a>
                    <div>
                        <c:forEach items="${boardList}" var="b" end="8">
                            <div class="list">
                                <a href="${root}/admin/board/detail/${b.no}">${b.title}</a>
                                <span id="date">${b.enrollDate}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="area">
                <div id="currentTime" style="font-size: 20px;">
                    현재 시간 <b style="font-size: 30px;" id="clock"></b>
                </div>
                <div id="calendar-area">
                    <div id="calendar"></div>
                </div>
            </div>

            <!-- 예약 관련 The Modal -->
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
            
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">예약 현황</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                    
                        <!-- Modal body -->
                        <div class="modal-body" align="center">
                            <div style="color: gray; font-size: smaller;">* 장소 예약만 조회됩니다. 자세한 사항은 공유물 관리 메뉴를 이용해주세요.</div><br>
                            <c:forEach items="${bookList}" var="r">
                                <div class="list-header">[${r.plNo}] ${r.empNo}님의 예약 내역입니다.</div>
                                <hr>
                                <table class="book-list">
                                    <tr>
                                        <th>예약자</th>
                                        <td>${r.empNo}</td>
                                    </tr>
                                    <tr>
                                        <th>등록일자</th>
                                        <td>${r.rsvDate}</td>
                                    </tr>
                                    <tr>
                                        <th>예약일자</th>
                                        <td>${r.rsvBegin}</td>
                                    </tr>
                                    <tr>
                                        <th>종료일자</th>
                                        <td>${r.rsvEnd}</td>
                                    </tr>
                                </table>
                                <br><br>
                            </c:forEach>
                            <c:if test="${fn:length(bookList) == 0}">
                                <div style="margin-top: 100px;">금일 예약된 장소가 없습니다.</div>
                            </c:if>
                        </div>
                    
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn" style="background-color: #5D736F; color: white;" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // 현재 시간 표시
        var Target = document.getElementById("clock");
        function clock() {
            var time = new Date().toTimeString().split(" ")[0];
            Target.innerHTML = time;
        }

        clock();
        setInterval(clock, 1000); // 1초마다 실행하여 실시간으로 보여주기

       
        //풀캘린더 라이브러리 적용
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                googleCalendarApiKey : "AIzaSyAE-9fkmGRA-7ctlIj5SemknsE-SI5glxY",
                contentHeight:"auto",
                eventSources :[ 
                    {
                        googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
                        , color: 'red'   // an option!
                    } 
                ]
            });
            calendar.render();
        })

    </script>
</body>
</html>