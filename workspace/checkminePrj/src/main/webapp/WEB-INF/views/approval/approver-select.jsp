<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<meta charset="UTF-8">
<title>checkmine</title>
<style>
    * { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
    #logo img{
        margin: auto;
        display: block;
    }
    #wrapper{
        padding-top: 30px;
        padding-left: 10px;
        padding-right: 10px;
        display: grid;
        grid-template-rows: repeat(5, 1fr);
    }
    .btn{
        color: white;
        background-color: #5d736f;
        display: block;
        margin: auto;
    }
    footer{
        border: none;
        width: 100%;
        padding-left: 10px;
        padding-right: 10px;
    }
    .select-member{
        cursor: pointer;
        display: block;
        margin-top: 10px;
        background-color:white;
        border: none;
    }
    #footer input{
        width: 100%;
    }
</style>
</head>
<body>

    <div id="logo">
        <img src="/checkmine/resources/img/header/logo.png">
    </div>

    <main id="wrapper">
        <div>
            <div>선택항목</div>
            <div class="input-group mb-3">
                <input id="search-first" name="first" type="text" class="form-control" placeholder="1차 결재자">
                <button id="search-first-btn" class="btn" onclick="searchFirst();">검색</button>
            </div>
        </div>
        <div>
            <div>선택항목</div>
            <div class="input-group mb-3">
                <input id="search-second" name="second" type="text" class="form-control" placeholder="2차 결재자" readonly>
                <button id="search-second-btn" class="btn" onclick="searchSecond();">검색</button>
            </div>
        </div>
        <div>
            <div>선택항목</div>
            <div class="input-group mb-3">
                <input id="search-third" name="third" type="text" class="form-control" placeholder="3차 결재자" readonly>
                <button id="search-third-btn" class="btn" onclick="searchThird();">검색</button>
            </div>
        </div>
        <div>
            <div style="color:red;">필수*</div>
            <div class="input-group mb-3">
                <input id="search-final" name="final" type="text" class="form-control" placeholder="최종 결재자">
                <button id="search-final-btn" class="btn" onclick="searchFinal();">검색</button>
            </div>
        </div>
        <div><button class="btn" onclick="submitApprover();">선택</button></div>
    </main>
    <footer id="footer" hidden>
        <input id="btn-input" class="select-member" value="" readonly>
    </footer>

    <script>
        //최종&1차 -> 2차 -> 3차 순으로 사용가능
        $('#search-first').blur(function(){
            if($('#search-first').val() != ""){
                $('#search-second').prop('readonly', false);
            }
        });
        $('#search-second').blur(function(){
            if($('#search-second').val() != ""){
                $('#search-third').prop('readonly', false);
            }
        });
        

        //1차 결재자 검색
        function searchFirst(){
            var approver = $('#search-first').val();
            $.ajax({
  				url : "${rootPath}/approval/first",
  				type : "POST",
  				data : {'approver' : approver},
  				dataType : 'json',
  				success : function(data){
                    var list = JSON.parse(data.list);
                    $('.select-member').hide();
  					if(list.length == 0 || list.length == data.allEmpCnt){
                        //사원 없음
                        alert('해당 사원이 존재하지 않습니다.');
  					}else if(list.length > 1){
                        //사원 존재, 동명이인 있음
                        alert('사원을 선택해주세요.');
                        for(var i=0; i<list.length; i++){
                            $($('.select-member')[i]).val(list[i].no + " " + list[i].name + " " + list[i].email);
                            var oriInput = document.getElementsByClassName('select-member')[i];
                            $(oriInput).css('display','block');
                            var newInput = oriInput.cloneNode(true);
                            oriInput.after(newInput);
                        }
                        $($('.select-member')).on('click', selectMember1);
                        $($('.select-member')[list.length-1]).hide();
                        $('#footer').prop('hidden', false);
  					}else{
                        //사원 존재 동명이인 없음
                        $('#search-first').val(list[0].no + " " + list[0].name + " " + list[0].email);
                    }
  				},
  				error : function(){
  					alert("서버요청실패..");
  				}
  			});
        }

        //2차 결재자 검색
        function searchSecond(){
            var approver = $('#search-second').val();
            $.ajax({
  				url : "${rootPath}/approval/second",
  				type : "POST",
  				data : {'approver' : approver},
  				dataType : 'json',
  				success : function(data){
                    var list = JSON.parse(data.list);
                    $('.select-member').hide();
  					if(list.length == 0 || list.length == data.allEmpCnt){
                        //사원 없음
                        alert('해당 사원이 존재하지 않습니다.');
  					}else if(list.length > 1){
                        //사원 존재, 동명이인 있음
                        alert('사원을 선택해주세요.');
                        for(var i=0; i<list.length; i++){
                            $($('.select-member')[i]).val(list[i].no + " " + list[i].name + " " + list[i].email);
                            var oriInput = document.getElementsByClassName('select-member')[i];
                            $(oriInput).css('display','block');
                            var newInput = oriInput.cloneNode(true);
                            oriInput.after(newInput);
                        }
                        $($('.select-member')).on('click', selectMember2);
                        $($('.select-member')[list.length-1]).hide();
                        $('#footer').prop('hidden', false);
  					}else{
                        //사원 존재 동명이인 없음
                        $('#search-second').val(list[0].no + " " + list[0].name + " " + list[0].email);
                    }
  				},
  				error : function(){
  					alert("서버요청실패..");
  				}
  			});
        }

        //3차 결재자 검색
        function searchThird(){
            var approver = $('#search-third').val();
            $.ajax({
  				url : "${rootPath}/approval/third",
  				type : "POST",
  				data : {'approver' : approver},
  				dataType : 'json',
  				success : function(data){
                    var list = JSON.parse(data.list);
                    $('.select-member').hide();
  					if(list.length == 0 || list.length == data.allEmpCnt){
                        //사원 없음
                        alert('해당 사원이 존재하지 않습니다.');
  					}else if(list.length > 1){
                        //사원 존재, 동명이인 있음
                        alert('사원을 선택해주세요.');
                        for(var i=0; i<list.length; i++){
                            $($('.select-member')[i]).val(list[i].no + " " + list[i].name + " " + list[i].email);
                            var oriInput = document.getElementsByClassName('select-member')[i];
                            $(oriInput).css('display','block');
                            var newInput = oriInput.cloneNode(true);
                            oriInput.after(newInput);
                        }
                        $($('.select-member')).on('click', selectMember3);
                        $($('.select-member')[list.length-1]).hide();
                        $('#footer').prop('hidden', false);
  					}else{
                        //사원 존재 동명이인 없음
                        $('#search-third').val(list[0].no + " " + list[0].name + " " + list[0].email);
                    }
  				},
  				error : function(){
  					alert("서버요청실패..");
  				}
  			});
        }

        //최종 결재자 검색
        function searchFinal(){
            var approver = $('#search-final').val();
            $.ajax({
  				url : "${rootPath}/approval/final",
  				type : "POST",
  				data : {'approver' : approver},
  				dataType : 'json',
  				success : function(data){
                    var list = JSON.parse(data.list);
                    $('.select-member').hide();
  					if(list.length == 0 || list.length == data.allEmpCnt){
                        //사원 없음
                        alert('해당 사원이 존재하지 않습니다.');
  					}else if(list.length > 1){
                        //사원 존재, 동명이인 있음
                        alert('사원을 선택해주세요.');
                        for(var i=0; i<list.length; i++){
                            $($('.select-member')[i]).val(list[i].no + " " + list[i].name + " " + list[i].email);
                            var oriInput = document.getElementsByClassName('select-member')[i];
                            $(oriInput).css('display','block');
                            var newInput = oriInput.cloneNode(true);
                            oriInput.after(newInput);
                        }
                        $($('.select-member')).on('click', selectMember4);
                        $($('.select-member')[list.length-1]).hide();
                        $('#footer').prop('hidden', false);
  					}else{
                        //사원 존재 동명이인 없음
                        $('#search-final').val(list[0].no + " " + list[0].name + " " + list[0].email);
                    }
  				},
  				error : function(){
  					alert("서버요청실패..");
  				}
  			});
        }

        const footerNode = document.querySelector('#footer');

        //1차 동명이인 결재자 선택
        function selectMember1(){
            approver = this.value;
            $('#search-first').val(approver);
            $('#footer').prop('hidden', true);
            $('select-member').hide();
            document.querySelector('#footer').innerHTML = footerNode.innerHTML;
        }

        //2차 동명이인 결재자 선택
        function selectMember2(){
            approver = this.value;
            $('#search-second').val(approver);
            $('#footer').prop('hidden', true);
            $('select-member').hide();
            document.querySelector('#footer').innerHTML = footerNode.innerHTML;
        }

        //3차 동명이인 결재자 선택
        function selectMember3(){
            approver = this.value;
            $('#search-third').val(approver);
            $('#footer').prop('hidden', true);
            $('select-member').hide();
            document.querySelector('#footer').innerHTML = footerNode.innerHTML;
        }

        //최종 동명이인 결재자 선택
        function selectMember4(){
            approver = this.value;
            $('#search-final').val(approver);
            $('#footer').prop('hidden', true);
            $('select-member').hide();
            document.querySelector('#footer').innerHTML = footerNode.innerHTML;
        }

        //결재자 정보 넘기기
        function submitApprover(){
            var searchFirst = $('#search-first').val();
            var searchSecond = $('#search-second').val();
            var searchThird = $('#search-third').val();
            var searchFinal = $('#search-final').val();
            if($('#search-final').val() != null && $('#search-final').val() != ""){
                //결재자 이름 넘기기
                if(searchFirst.split(" ")[1] != undefined){
                    window.opener.document.querySelectorAll('.approver5').forEach(x=>{x.innerHTML = searchFirst.split(" ")[1];});
                }
                if(searchSecond.split(" ")[1] != undefined){
                    window.opener.document.querySelectorAll('.approver6').forEach(x=>{x.innerHTML = searchSecond.split(" ")[1];});
                }
                if(searchThird.split(" ")[1] != undefined){
                    window.opener.document.querySelectorAll('.approver7').forEach(x=>{x.innerHTML = searchThird.split(" ")[1];});
                }
                window.opener.document.querySelectorAll('.approver8').forEach(x=>{x.innerHTML = searchFinal.split(" ")[1];});
                //결재자 번호 넘기기
                if(searchFirst.split(" ")[0] != undefined){
                    window.opener.document.querySelectorAll('.first-approver').forEach(x=>{x.value = searchFirst.split(" ")[0];});
                }
                if(searchSecond.split(" ")[0] != undefined){
                    window.opener.document.querySelectorAll('.second-approver').forEach(x=>{x.value = searchSecond.split(" ")[0];});
                }
                if(searchThird.split(" ")[0] != undefined){
                    window.opener.document.querySelectorAll('.third-approver').forEach(x=>{x.value = searchThird.split(" ")[0];});
                }
                window.opener.document.querySelectorAll('.final-approver').forEach(x=>{x.value = searchFinal.split(" ")[0];});
                window.close();
            }else{
                alert('최종 결재자를 선택하시기 바랍니다.');
                return;
            }
        }

    </script>

</body>
</html>