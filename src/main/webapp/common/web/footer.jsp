<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer class="py-2 bg-light">
	<div class="container text-dark text-center">
		<p>Trường CĐ Công Thương Hồ Chí Minh</p>
		<p>Khoa Công Nghệ Thông Tin</p>
		<p>Đồ án chuyên ngành - News Website - Java web</p>
		<p>Sinh viên thực hiện: Triệu Minh Tuấn_2119110065</p>
		<p>Copyright &copy; javaweb 9-2021</p>
	</div>
</footer>
<script>
function increasedViews(id) {	
	var data = [""+id+""];
    $.ajax({
        url: '${newAPI}/increased-views',
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify(data), 
        success: function (result){
        },
        errror: function (error){
        	alert("Lỗi hệ thống");
        }
    });
}
</script>

