<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<div class="container">
	<c:if test="${embed =='ty-gia-ngoai-te'}">
		<h3 class="bg-light text-dark">Tỷ giá ngoại tệ</h3>
		<div>
			<iframe style="border: none; width: 100%; height: 500px"
				src="https://tygiado.com/nhung-ngoai-te/"></iframe>
		</div>
	</c:if>

	<c:if test="${embed =='ty-gia-vang'}">
		<h3 class="bg-light text-dark mt-1">Tỷ giá vàng</h3>
		<div>
			<iframe frameborder="0" width="100%" height="500px"
				src="https://webtygia.com/api/vang?bgheader=b53e3e&colorheader=ffffff&padding=5&fontsize=13&undefined"></iframe>
		</div>
	</c:if>

	<c:if test="${embed =='gia-xang-dau'}">
		<h3 class="bg-light text-dark mt-1">Giá xăng dầu</h3>
		<div>
			<iframe frameborder="0" width="100%" height="500px"
				src="https://webtygia.com/api/xang-dau?bgheader=3727b0&colorheader=ffffff&padding=5&fontsize=13&undefined"></iframe>
		</div>
	</c:if>

	<c:if test="${embed =='lich-cat-dien'}">
		<h3 class="bg-light text-dark mt-1">Lịch cắt điện</h3>
		<div>
			<iframe frameborder="0" width="100%" height="500px"
				src="https://topsvn.com/api/cat-dien?bgheader=ff5722&colorheader=ffffff&padding=5&fontsize=13&hienthi=&"></iframe>
		</div>
	</c:if>

	<c:if test="${embed =='ket-qua-xo-so'}">
		<h3 class="bg-light text-dark mt-1">Kết quả xổ số</h3>
		<div>
			<iframe src="https://www.minhngoc.net.vn/free/index.php" width="100%"
				height="2000" frameborder="0" scrolling="auto"
				id="iframe_xosominhngoc" name="iframe_xosominhngoc"></iframe>
		</div>
	</c:if>

	<c:if test="${embed =='lich-phat-song'}">
		<h3 class="bg-light text-dark mt-1">Lịch phát sóng</h3>
		<div>
			<iframe src="https://bongda.com.vn/truyenhinh.aspx" width="100%"
				height="500" frameborder="1" scrolling="yes"></iframe>
		</div>
	</c:if>
	<c:if test="${embed =='thoi-tiet'}">
		<!-- weather widget start -->
		<div>
			<iframe frameborder="0" marginwidth="0" marginheight="0" src="http://thienduongweb.com/tool/weather/?r=0&w=1&g=0&d=0" width="100%" height="200" scrolling="no"></iframe>
		</div>
		
		<div class=row>
			<div class="col-4 my-3">
				<a target="_blank" href="https://hotelmix.vn/weather/hanoi-19487"><img
					src="https://w.bookcdn.com/weather/picture/3_19487_1_33_137AE9_160_ffffff_333333_08488D_1_ffffff_333333_0_6.png?scode=124&domid=1180&anc_id=41413"
					alt="booked.net" width="100%" /></a>
			</div>
			<div class="col-4 my-3">
				<a target="_blank" href="https://hotelmix.vn/weather/ho-chi-minh-city-18408"><img
					src="https://w.bookcdn.com/weather/picture/3_18408_1_33_137AE9_160_ffffff_333333_08488D_1_ffffff_333333_0_6.png?scode=124&domid=1180&anc_id=30097"
					alt="booked.net" width="100%" /></a>
			</div>
			<div class="col-4 my-3">
				<a target="_blank" href="https://hotelmix.vn/weather/binh-duong-40276"><img
					src="https://w.bookcdn.com/weather/picture/3_40276_1_33_137AE9_160_ffffff_333333_08488D_1_ffffff_333333_0_6.png?scode=124&domid=1180&anc_id=66924"
					alt="booked.net" width="100%" /></a>
			</div>
			
			<div class="col-4 my-3">
				<a target="_blank" href="https://hotelmix.vn/weather/binh-phuoc-w464281"><img
					src="https://w.bookcdn.com/weather/picture/3_w464281_1_33_137AE9_160_ffffff_333333_08488D_1_ffffff_333333_0_6.png?scode=124&domid=1180&anc_id=76345"
					alt="booked.net" width="100%"/></a>
			</div>	
		</div>
	</c:if>
</div>