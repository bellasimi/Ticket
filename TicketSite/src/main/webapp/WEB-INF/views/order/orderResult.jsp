<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="total_order_goods_qty" value="0"/>
<c:set var="total_goods_point" value="0"/>
<head>
<style>
.pay_info {
	background-color: #f2f2f2;
	float:right;
	 border: 5px solid #444444;
	 padding: 30px;
	 font-size: 35px;
}


</style>
<script type="text/javascript">
window.onload=function()
{
  init_pay_method();
}

function init_pay_method(){
	//var form_order=document.form_order;
	var pay_method=document.form_order.pay_method.value;
	console.log("pay_method"+pay_method);
	if(pay_method=="신용카드") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="visible";
		e_phone.style.visibility="hidden";
		e_account.style.visibility="hidden";
	}
	else if(pay_method=="휴대폰결제") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="visible";
		e_account.style.visibility="hidden";
	}
	else if(pay_method=="무통장입금") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="hidden";
		e_account.style.visibility="visible";
	}
}    



</script> 

</head>
<BODY>
	<H1>주문완료</H1>
	<TABLE class="list_view">
		<TBODY align=center>
			<tr style="background: #33ff00">
			<!--   <td>주문번호 </td> -->   
				<td colspan=2 class="fixed">주문상품명</td>
				<td>수량</td>
				<td>예약일</td>
				<td>주문금액</td>
				<td>적립금</td>
				<td>주문금액합계</td>
			</tr>
			<tr>
				<c:forEach var="item" items="${myOrderList}">
				<!--   <td> ${item.order_id }</td>-->   
				<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
					    <IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					  </a>
					</td>
					<td>
					  <h2>
					     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
					  </h2>
					</td>
					<td><!-- 수량 -->
					  <h2>${item.order_goods_qty}개<h2>
					</td>
					<td>
					${item.goods_ticket_date }
					</td>
				<!--  주문금액 -->
					<!-- 여기는 그냥 가격ㅁ나 나오면 될거같은데  -->
					<td><h2>${item.order_goods_qty *item.goods_sales_price}원</h2></td>
							
				<!-- 적립금 -->
					<td><h2>${item.goods_point }원</h2></td>
					<td>
				<!--  주문금액 합계 -->
					  <h2>${item.order_goods_qty *item.goods_sales_price}원</h2>
					</td>
			</TR>
			<c:set var="total_order_goods_qty" value="${total_order_goods_qty+item.order_goods_qty}"/>
			<c:set var="total_goods_point" value="${total_goods_point+item.goods_point }"/>			
			</c:forEach>
			<tr>
			<td colspan="2"></td>
			<td>${total_order_goods_qty}</td>
			<td></td>
			<td></td>
			<td>${total_goods_point}</td>
			<td>총 주문금액:${myOrderInfo.order_total_price }</td>
			</tr> 
		</TBODY>
	</TABLE>
	<DIV class="clear"></DIV>
<form  name="form_order">
	<br>
	<br>

	<DIV class="clear"></DIV>
	<br>
	<br>
	<br>
	<H1>결제정보</H1>
	<input type="hidden" name="pay_method" value="${myOrderInfo.pay_method }">
	<DIV id="pay_card" class="pay_info" style="visibility:hidden"><!-- 여기도 구분해서 나오게 해야됨 -->
		<ul>
			<li>결제방법 : ${myOrderInfo.pay_method }</li>
			<li>결제카드 : ${myOrderInfo.card_com_name}</li>
			<li>결제카드번호 : ${myOrderInfo.card_number}</li>
		</ul>
		<!-- <table>
			<TBODY>
				<TR class="dot_line">
					<TD class="fixed_join">결제방법</TD>
					<TD>
					   ${myOrderInfo.pay_method }
				    </TD>
				</TR>
				<TR class="dot_line">
					<TD class="fixed_join">결제카드</TD>
					<TD>
					   ${myOrderInfo.card_com_name}
				    </TD>
				</TR>
				<TR class="dot_line">
					<TD class="fixed_join">카드번호</TD>
					<TD>
					   ${myOrderInfo.card_number}
				    </TD>
				</TR>
			</TBODY>
		</table> -->
	</DIV>
	
	
	<div id="pay_phone" class="pay_info" style="visibility:hidden">
		<ul>
			<li>결제방법 : ${myOrderInfo.pay_method }</li>
			<li>통신사 : ${myOrderInfo.pay_hp_com}</li>
			<li>결제 전화번호 : ${myOrderInfo.pay_hp_num}</li>
		</ul>
	</div>
	
	<div id="pay_random_account" class="pay_info" style="visibility:hidden">
		<ul>
			<li>결제방법 : ${myOrderInfo.pay_method }</li>
			<li>계좌번호 : ${myOrderInfo.random_account}</li>
		</ul>
	</div>
	
</form><!-- 이거 앞으로 가도 될것같은데  -->
    <DIV class="clear"></DIV>
	<br>
	<br>
	<br>
	<center>
		<br>
		<br> 
		<a href="${contextPath}/main/main.do"> 
		   <IMG width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
<DIV class="clear"></DIV>		
	
			
			
			