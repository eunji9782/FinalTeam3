<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<style>
	#draft-wrapper, form{
		width : 100%;
		height : 100%;
		border: none;
	}
	#main-top{
		width : 100%;
		height : 200px;
		display: flex;
	}
	#write-info{
		width : 60%;
		height : 100%;	
		display: grid;
		grid-template-rows: repeat(2, 1fr);
		align-items: center;
	}
	#write-info div{
		color: white;
		width: 90%;
		height: 90%;
		margin: 10px;
		padding: 10px;
		padding-top: 25px;
		padding-left: 20px;
		background-color:#91b3ac;
		border-radius: 15px;
		font-size: 23px;
		align-items: center;
	}
	#approver-info{
		width: 40%;
		height: 100%;
		border-top: 1px solid black;
		border-right: 1px solid black;
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		grid-template-rows: 1fr 3fr 1fr;
	}
	#approver-info div{
		border-left: 1px solid black;
		border-bottom: 1px solid black;
		padding: 10px;
		text-align: center;
	}
	#main-bot{
		height: 80vh;
		margin-top : 30px;
	}
	#approval-title-div{
		height: 10%;
		display : grid;
		grid-template-columns : 1fr 6fr;
		border-top : 1px solid black;
		border-bottom : 1px solid black;
		margin-bottom: 15px;
	}
	#approval-title{
		border-right : 1px solid black;
		font-size : 20px;
	}
	#approval-content-div{
		height: 80%;
		display: grid;
		grid-template-columns: 1fr 6fr;
		grid-template-rows: 1fr 10fr;
	}
	#approval-content{
		height: 100%;
		resize: none;
		grid-column: 1/3;
	}
	#approval-btn-div{
		height: 10%;
	}
	#approval-btn{
		color: white;
		background-color: #5d736f;
		margin: auto;
		display: block;
	}
	.form-check{
		margin-left: 20px;
	}
	.form-check>input:checked{
		background-color: #5d736f !important;
	}
	#state-name{
		display: grid;
		grid-template-columns: 1fr 5fr;
	}
	#state-content{
		height: 100%;
		width: 100%;
		display: grid;
		grid-template-columns: 1fr 6fr;
		grid-template-rows: 1fr 1fr 4fr;
	}
	#state-content>textarea{
		resize: none;
	}
	.spanning{
		display: inline-block;
		margin-top: 5px;
	}
</style>



<main id="draft-wrapper">

	<div id="main-top">
		<div id="write-info">
			<div id="writer-div">
				작성자 : (작성자영역)
			</div>
			<div id="write-date-div">
				작성일 : (작성년월일)
			</div>
		</div>
		<div id="approver-info">
			<div id="approver1">1</div>
			<div id="approver2">2</div>
			<div id="approver3">3</div>
			<div id="approver4">4</div>
			<div id="approver5">5</div>
			<div id="approver6">6</div>
			<div id="approver7">7</div>
			<div id="approver8">8</div>
			<div id="approver9">9</div>
			<div id="approver10">10</div>
			<div id="approver11">11</div>
			<div id="approver12">12</div>
		</div>
	</div>
	<div id="main-bot">

		<form action="${rootPath}/approval/state" method="multipart/form-data">

			<div id="approval-title-div">
				<div id="approval-title" class="input-group-text">제목</div>
				<input type="text" maxlength="250" class="form-control">
			</div>
			<div id="approval-content-div">
				<div id="form-check-div" class="form-control">
					<div class="form-check spanning">
						<input class="form-check-input" type="checkbox" id="in" name="R" value="R">
						<label class="form-check-label" for="in">입금</label>
					</div>
					<div class="form-check spanning">
						<input class="form-check-input" type="checkbox" id="out" name="P" value="P">
						<label class="form-check-label" for="out">출금</label>
					</div>
				</div>
				<div id="state-name">
					<div class="input-group-text">품목명</div>
					<input type="text" maxlength="50" class="form-control" name="stateName">
				</div>
				<div id="approval-content">
					<div id="state-content">
						<div class="input-group-text">입금액</div>
						<input type="number" class="form-control" id="in-money" name="inMoney" min="0" disabled>
						<div class="input-group-text">출금액</div>
						<input type="number" class="form-control" id="out-money" name="outMoney" min="0" disabled>
						<div class="input-group-text">적요</div>
						<textarea maxlength="100" class="form-control" name="brief"></textarea>
					</div>
				</div>
			</div>
			<div id="approval-btn-div">
				<input type="file" name="stateFile" id="">
				<button id="approval-btn" class="btn btn-lg">결재</button>
			</div>

		</form>

	</div>

	<script>
		//입금 누르면 입금액 입력가능
		$("#in").click(function(){
            if($("#in").is(":checked") == true){
            	$("#in-money").prop("disabled", false);
        	}else{
				$("#in-money").prop("disabled", true);
			}
        });

		//출금 누르면 출금액 입력가능
		$('#out').click(function(){
			if($("#out").is(":checked") == true) {
				$("#out-money").prop("disabled", false);
			}else{
				$("#out-money").prop("disabled", true);
			}
		});
		
	</script>

</main>