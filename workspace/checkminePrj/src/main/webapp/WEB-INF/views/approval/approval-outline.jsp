<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkmine</title>
<style>
    html, body{
        box-sizing: border-box;
    }
    .hr-border {
        margin: 0;
        border: 1px solid #B0D9D1;
    }
    .left-space {
        margin-left: 20px;
    }
    .list-group-horizontal>.list-group-item:nth-child(n) {
        border-radius: 0.25rem 0.25rem 0 0;
    }
    .list-group-item.active {
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0;
        border-color: #B0D9D1;
        background-color: white;
        color: #728D89;
    }
    .top-radius-btn {
        border-color: #8D8D8D;
        border-bottom-color: rgba(255, 255, 255, 0);
        background-color: white;
        color: black;
        border-bottom: 0px;
        font-weight: bold;
        font-size: 23px;
        padding: 8px;
        text-align: center;
        padding-left: 12px;
        padding-right: 12px;
    }
    .tab-content>div{
    	padding : 30px;
    }
    input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
		appearance: none;
		margin: 0;
	}
    input[type=file]::file-selector-button {
        width: 100px;
        margin: 5px;
        height: 30px;
        background: #5D736F;
        border: 1px solid #5D736F;
        color: white;
        border-radius: 10px;
        cursor: pointer;
    }
    #approval-list-btn{
    	color: white;
		background-color: #5d736f;
		margin-left : 20px;
		margin-bottom : 20px;
    }
	#approver-select-btn{
		color: white;
		background-color: #5d736f;
		margin-left : 20px;
		margin-bottom : 20px;
	}
	a:hover{
		color: #5d736f !important;
	}
	#approval-wrapper{
		height: 800px;
	}
	.tab-pane{
		height: 800px !important;
	}
</style>
<c:if test="${docVo ne null}">
	<style>
		a:hover{
			color: black !important;
		}
		a.active{
			color: #5D736F !important;
		}
	</style>
</c:if>
</head>
<body>

<div class="d-flex">
    <%@ include file="/WEB-INF/views/common/side-nav.jsp" %>
    
    <main class="shadow" id="approval-wrapper">
    
    	<br>
    	<a href="${rootPath}/approval/list" class="btn" id="approval-list-btn">????????????</a>
    	<c:if test="${docVo eq null}">
    	<button class="btn" id="approver-select-btn" onclick="selectApprover();">????????? ??????</button>
    	</c:if>
	    <div class="list-group list-group-horizontal left-space" id="list-tab" role="tablist">
	        <a class="list-group-item active top-radius-btn" id="list-draft-list" data-bs-toggle="list" href="#list-draft" role="tab" aria-controls="list-draft">?????????</a>
	        <a class="list-group-item top-radius-btn" id="list-proposal-list" data-bs-toggle="list" href="#list-proposal" role="tab" aria-controls="list-proposal">?????????</a>
	        <a class="list-group-item top-radius-btn" id="list-minutes-list" data-bs-toggle="list" href="#list-minutes" role="tab" aria-controls="list-minutes">?????????</a>
	        <a class="list-group-item top-radius-btn" id="list-expenditure-list" data-bs-toggle="list" href="#list-expenditure" role="tab" aria-controls="list-expenditure">???????????????</a>
	        <a class="list-group-item top-radius-btn" id="list-buy-order-list" data-bs-toggle="list" href="#list-buy-order" role="tab" aria-controls="list-buy-order">???????????????</a>
	        <a class="list-group-item top-radius-btn" id="list-state-list" data-bs-toggle="list" href="#list-state" role="tab" aria-controls="list-state">??????</a>
	        <a class="list-group-item top-radius-btn" id="list-leave-list" data-bs-toggle="list" href="#list-leave" role="tab" aria-controls="list-leave">??????</a>
    	</div>
		<hr class="hr-border">
        <div class="tab-content" id="nav-tabContent">
	        <div class="tab-pane fade show active" id="list-draft" role="tabpanel" aria-labelledby="list-draft-list">
	            <%@ include file="/WEB-INF/views/approval/draft.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-proposal" role="tabpanel" aria-labelledby="list-proposal-list">
	            <%@ include file="/WEB-INF/views/approval/proposal.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-minutes" role="tabpanel" aria-labelledby="list-minutes-list">
	            <%@ include file="/WEB-INF/views/approval/minutes.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-expenditure" role="tabpanel" aria-labelledby="list-expenditure-list">
	            <%@ include file="/WEB-INF/views/approval/expenditure.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-buy-order" role="tabpanel" aria-labelledby="list-buy-order-list">
	            <%@ include file="/WEB-INF/views/approval/buy-order.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-state" role="tabpanel" aria-labelledby="list-state-list">
	            <%@ include file="/WEB-INF/views/approval/state.jsp" %>
	        </div>
	        <div class="tab-pane fade" id="list-leave" role="tabpanel" aria-labelledby="list-leave-list">
	            <%@ include file="/WEB-INF/views/approval/leave.jsp" %>
	        </div>
    	</div>
		
    </main>
</div>

<!-- ???????????? ????????? ?????? -->
<c:if test="${docVo eq null}">
	<script>
		//????????? ???????????? ??????
		function selectApprover(){
			window.open("${rootPath}/approval/select", "none", "width=500px, height=800px");
		}

		//?????? ????????? ??????
		function approval(){
			if(window.document.querySelectorAll('.final-approver')[0].value == ""){
				alert('???????????? ?????????????????? ????????????.');
				return false;
			}else{
				if(confirm("?????????????????????????")){
					//???
					return true;
				}else{
					//?????????
					return false;
				}
			}
		}
	</script>
</c:if>

<!-- ???????????? ????????? ?????? -->
<c:if test="${docVo ne null}">
	<script>
		//?????? ????????? ????????? ??????
		function approval(){
			//???????????? ?????? ??????
	        if(confirm("?????????????????????????")){
	            //???
	            return true;
	        }else{
	            //?????????
	            const result = prompt('???????????? :');
	            if(result == null){
	                return false;
	            }else if(result.length == 0){
					alert('??????????????? ?????????????????? ????????????.');
					return false;
				}else{
					window.document.querySelectorAll('.return-reason').forEach(x=>{x.value = result;});
	                return true;
	            }
	        }
	    }
	
		//?????????????????? ???????????? ??? ?????? ???????????? ????????????
		const type = '${docVo.type}';
		$('#list-tab').children().prop('disabled',true);
		$('#list-draft-list').removeClass('active');
        $('#list-draft').removeClass('active');
        $('#list-draft').removeClass('show');
	    if(type == 'D'){
	        $('#list-draft-list').addClass('active');
	        $('#list-draft').addClass('active');
	        $('#list-draft').addClass('show');
	    }else if(type == 'P'){
	        $('#list-proposal-list').addClass('active');
	        $('#list-proposal').addClass('active');
	        $('#list-proposal').addClass('show');
	    }else if(type == 'M'){
	        $('#list-minutes-list').addClass('active');
	        $('#list-minutes').addClass('active');
	        $('#list-minutes').addClass('show');
	    }else if(type == 'B'){
	        $('#list-buy-order-list').addClass('active');
	        $('#list-buy-order').addClass('active');
	        $('#list-buy-order').addClass('show');
	    }else if(type == 'E'){
	        $('#list-expenditure-list').addClass('active');
	        $('#list-expenditure').addClass('active');
	        $('#list-expenditure').addClass('show');
	    }else if(type == 'S'){
	        $('#list-state-list').addClass('active');
	        $('#list-state').addClass('active');
	        $('#list-state').addClass('show');
	    }else if(type == 'L'){
	        $('#list-leave-list').addClass('active');
	        $('#list-leave').addClass('active');
	        $('#list-leave').addClass('show');
	    }
	
	    //????????? ?????? ????????? ?????? ?????? input/textarea ????????????
	    $('input').prop('readonly', true);
		$('#in').prop('disabled',true);
		$('#out').prop('disabled',true);
		$('#plus-btn').prop('disabled', true);
		$('#eplus-btn').prop('disabled', true);
	    $('textarea').prop('readonly',true);
	</script>
</c:if>

</body>
</html>