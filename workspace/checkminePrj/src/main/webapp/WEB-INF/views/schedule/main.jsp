<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정</title>
<link href='${root}/resources/fullcalendar-5.11.3/lib/main.css' rel='stylesheet' />
<script src='${root}/resources/fullcalendar-5.11.3/lib/main.js'></script>
<script src="${root}/resources/fullcalendar-5.11.3/lib/locales/ko.js"></script>
<!--seweetalert2-->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    #calendar{ /*캘린더 설정*/
        width: 1100px;
        height: 850px;
        margin: auto;
        margin-top: 10px;
        padding: 10px;
    }

    thead > tr{ /*요일 배경*/
        background-color: lightgray;
    }

    .fc-col-header-cell-cushion:hover{ /*요일 호버 색 안바뀌게*/
        color: black !important;
    }
 
    /*글자 색 설정*/
    a{ 
        color: black;
        text-decoration: none;
    }

    .fc-daygrid-day-frame a:hover{
        color: #b0d9d1;
        text-decoration: none !important;
        background-color:#5d736f86;
    }

    [aria-label="일요일"], .fc-day-sun>div>a{
        color: firebrick !important;
    }

    [aria-label="토요일"], .fc-day-sat>div>a, .fc-day-number.fc-sat.fc-past {
        color: dodgerblue !important;
    }


    .fc-daygrid-event { /*이벤트 설정*/
        /* background-color: #5D736F;
        border: 1px solid white; */
        border-radius: 20px;
        text-align: center;
    }
    
    /*하루짜리 이벤트만 다르게 나와서...*/
    .fc-daygrid-event-dot + .fc-event-title{
        font-weight: normal !important;
    }

    .fc-daygrid-event-dot{
        border: 4px solid #b0d9d1 !important;
        border-radius: 4px !important;
    }

    .fc-day-today{ /*오늘 날짜 백그라운드*/
        background-color: #b0d9d14d !important;
    }

    .fc-highlight{ /*날짜칸 클릭시*/
        background-color: #5d736f86 !important;
    }

    /*팝오버&모달 배경 설정*/
    .fc-popover-header, .modal-header{ 
        background-color: #b0d9d1 !important;
    }

    .fc-popover-body{
        background-color: white;
    }

    .modal-footer>.fc-button, .close{
        color: white;
        background-color: #b0d9d1;
        border: 1px solid lightgray;
    }

    .modal-footer>.fc-button:hover, .close:hover{
        background-color: #326A60;
    }

    .modal-footer>.fc-button:focus, .close:focus{
        outline: 5px solid lightgray;
    }

    #content{
        height: 300px;
    }
</style>
</head>
<body>
	<div class="d-flex">
        <%@ include file="/WEB-INF/views/common/side-nav.jsp" %>
        
        <main class="shadow">
			<div id="calendar"></div>
        </main>
    </div>

    <!-- 특정 인물만 버튼 보이게 설정,input name 수정 -->
    <!-- 일정 추가용 modal -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="${root}/schedule/add" method="post" id="modal-data" onsubmit="return check();">
                    
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="taskId" class="col-form-label">일정명</label>
                            <input type="text" class="form-control" id="title" name="title">
                            <label for="taskId" class="col-form-label">일정 내용</label>
                            <textarea class="form-control" id="content" name="content"></textarea>
                            <label for="taskId" class="col-form-label">시작 날짜 / 시간</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" > <input class="form-control" type="time" name="startTime">
                            <label for="taskId" class="col-form-label">종료 날짜 / 시간</label>
                            <input type="date" class="form-control" id="endDate" name="endDate"> <input class="form-control" type="time" name="endTime">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn fc-button fc-button-primary" id="addSchedule">추가</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="sprintSettingModalClose">취소</button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <!-- confirm 모달을 쓸 페이지에 추가 start-->
    <section class="modal modal-section type-confirm">
        <div class="enroll_box">
            <p class="menu_msg"></p>
        </div>
        <div class="enroll_btn">
            <button class="btn pink_btn btn_ok">확인</button>
            <button class="btn gray_btn modal_close">취소</button>
        </div>
    </section>
    <!-- confirm 모달을 쓸 페이지에 추가 end-->
    
        <!-- alert 모달을 쓸 페이지에 추가 start-->
        <section class="modal modal-section type-alert">
            <div class="enroll_box">
                <p class="menu_msg"></p>
            </div>
            <div class="enroll_btn">
                <button class="btn pink_btn modal_close">확인</button>
            </div>
        </section>
        <!-- alert 모달을 쓸 페이지에 추가 end-->

    <script>
        var memberDept = '${loginMember.deptNo}';
        var dept = "인사부";

        const currentDate = new Date();
        const options = {
            weekday: "long",
            year: "numeric",
            month: "short",
            day: "numeric",
            hour: "numeric",
            minute: "numeric"
        };

        //풀캘린더 라이브러리 적용
        document.addEventListener('DOMContentLoaded', function() {
            //data 받아오는 ajax
            $(function(){
                 request = $.ajax({
                    url:"${root}/schedule/list",
                    method:"GET",
                    //dataType:"JSON",
                    success:function(data){
                        console.log(data);

                        //이부분부터 fullcalenadar 라이브러리
                        var calendarEl = document.getElementById('calendar');
                        var calendar = new FullCalendar.Calendar(calendarEl, {
                            initialView: 'dayGridMonth',
                            locale: 'ko', // 한국어 설정
                            headerToolbar: {
                                left: 'prevYear prev today next nextYear',
                                center: 'title',
                                right: 'dayGridMonth,timeGridWeek,timeGridDay'
                            },
                            footerToolbar:{
                                right: 'addEventButton'
                            }, 
                            displayEventTime: function(data){
                                if(data.event.start != data.event.end){
                                    true;
                                }else{
                                    false;
                                };
                            }, //시간 표시
                            customButtons: { //일정 추가 커스텀
                                addEventButton: { // 추가한 버튼 설정
                                    text : "일정 추가",  // 버튼 내용
                                    click : function(){ // 버튼 클릭 시 이벤트 추가
                                        // var memberDept = '${loginMember.deptNo}';
                                        // var dept = "인사부";
                                        console.log("멤버 : " + memberDept);
                                        console.log("부서 : " + dept);
                                        if(dept == memberDept){//인사부만 등록
                                            $("#calendarModal").modal("show"); // modal 나타내기
                                            $("#addCalendar").on("click",function(){  // modal의 추가 버튼 클릭 시

                                                var content = $("#calendar_content").val();
                                                var start_date = $("#calendar_start_date").val();
                                                var end_date = $("#calendar_end_date").val();
                                                                                            
                                                //내용 입력 여부 확인
                                                if(content == null || content == ""){
                                                    alert("내용을 입력하세요.");
                                                }else if(start_date == "" || end_date ==""){
                                                    alert("날짜를 입력하세요.");
                                                }else if(new Date(end_date)- new Date(start_date) < 0){ // date 타입으로 변경 후 확인
                                                    alert("종료일이 시작일보다 먼저입니다.");
                                                }else{ // 정상적인 입력 시
                                                    var obj = {
                                                        "title" : content,
                                                        "start" : start_date,
                                                        "end" : end_date
                                                    }//전송할 객체 생성
                                                    console.log(obj); //서버로 해당 객체를 전달해서 DB 연동 가능
                                                }
                                            })
                                        }else{
                                            Swal.fire({
                                                icon:'error',
                                                title: '해당 권한이 없습니다.',
                                                confirmButtonColor: '#6c757d',
                                                confirmButtonText: '확인'
                                            })
                                        };
                                    }
                                }
                            },
                            navLinks: true, //날짜 선택시 day 캘린더로 링크
                            selectable: true, //달력 일자 드래그 설정
                            dayMaxEvents: true, //이벤트 오버되면 높이 제한
                            eventLimit:true,
                            editable:true,//draggable 작동
                            displayEventEnd:{
                                month: false,
                                basickWeek: true
                            },
                            //구글 캘린더 - 공휴일 연동
                            googleCalendarApiKey : "AIzaSyAE-9fkmGRA-7ctlIj5SemknsE-SI5glxY", //api id
                            eventSources :[
                                {
                                    googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com', //캘린더 id
                                    color: '#a51b0b',
                                    textColor: 'white',
                                }
                            ],
                            allDaySlot: false,
                            events: data,
                            eventClick : function(data, element){
                                var eventObj = data.event;
                                var start = eventObj.start;
                                var end = eventObj.end;

                                start = start.toLocaleDateString("ko", options);
                                end = end.toLocaleDateString("ko", options)

                                if(eventObj.id > 0){
                                    Swal.fire({
                                        title : "<" + eventObj.title + ">",
                                        icon: 'question',
                                        text :  "해당 지시서로 이동하시겠습니까?",
                                        showCancelButton: true,
                                        confirmButtonColor: '#b0d9d1',
                                        cancelButtonColor: '#6c757d',
                                        confirmButtonText: '네',
                                        cancelButtonText: '아니오'
                                    }).then((result)=>{
                                        if(result.isConfirmed){
                                            window.open('${root}/task/order/detail/' + data.event.id);
                                        }
                                    })
                                }else{
                                    Swal.fire({
                                        icon:'info',
                                        title: eventObj.title,
                                        html: '시작일시 : ' + start + ' <br> ' + '종료일시 : ' + end + '<br><br>' + eventObj.extendedProps.content,
                                        confirmButtonColor: '#b0d9d1'
                                    })
                                }

                            },
                            eventDragStop:
                            function(data, jsEvent, ui, view){
                                var eventObj = data.event.id;
                                if(eventObj.charAt(0) == 'S'){
                                    Swal.fire({
                                        icon:'warning',
                                        title:"<" + eventObj.title + ">" + '\n' + "해당 일정을 삭제하겠습니까?",
                                        showCancelButton: true,
                                        confirmButtonColor: '#b0d9d1',
                                        cancelButtonColor: '#6c757d',
                                        confirmButtonText: '네',
                                        cancelButtonText: '아니오',
                                        preConfirm: () => {
                                            return fetch(`${root}/schedule/del/` + eventObj)
                                            .then((result) => {
                                                if (result.ok) {
                                                    Swal.fire({
                                                    title: '삭제되었습니다.',
                                                    confirmButtonColor: '#6c757d',
                                                    confirmButtonText: '확인',
                                                    preConfirm: ()=>{
                                                        location.reload()
                                                    }
                                                    })
                                                }
                                            })
                                        }
                                    })
                                }
                            }
                            
                        });
                        calendar.render();
                    },
                    error : function(e){
                        alert("실패");
                        console.log(e);
                    }
                });
            });
            
            

        });
    </script>

<script>
    
    //일정 입력시 날짜 표시 : 현재로
    document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
    document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
    
    //일정 입력 빈칸 방지
        const title = document.querySelector('#title');
        const content = document.querySelector('#content');
        const startDate = document.querySelector('#startDate');
        const endDate = document.querySelector('#endDate');

        function check(){
            //제목
            if(title.value.length == 0){
                alert("제목을 작성해주세요.");
                return false;
            }

            //본문
            if(content.value.length == 0){
                alert("내용을 작성해주세요.");
                return false;
            }
            
            //시작일
            if(startDate.value.length == 0){
                alert("시작일을 지정해주세요.");
                return false;
            }
            
            //마감일
            if(endDate.value.length == 0){
                alert("종료일을 지정해주세요.");
                return false;
            }
        }
    </script>
</body>
</html>