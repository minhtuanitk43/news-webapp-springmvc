<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@page import ="com.laptrinhjavaweb.util.SecurityUtils" %>
<c:url var="newsDetail" value="/xem-chi-tiet"/>
<c:url var="commentAPI" value="/api/comment"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<div id="navbar" class="navbar navbar-default ace-save-state">
    <div class="navbar-container ace-save-state" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="#" class="navbar-brand">
                <small>
                    <i class="fa fa-leaf"></i>
                    Trang quản trị
                </small>
            </a>
        </div>
        <div class="navbar-buttons navbar-header pull-right collapse navbar-collapse" role="navigation">
            <ul class="nav ace-nav">      
                <li class="light-blue dropdown-modal">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        Xin chào, <%=SecurityUtils.getPrincipal().getFullName()%> !
                    </a>
				</li>
				
				<li class="purple dropdown-modal">
					<div class="dropdown">
					  <button onclick="myFunction()" class="dropbtn">
					  	<i class="ace-icon fa fa-bell"></i>
					  	<c:set var="count" scope="session" value="0"/>
					  	<c:forEach var="item" items="${notifications }">
					  		<c:if test="${item.status==1 }"> <c:set var="count" value="${count + 1}" /></c:if>
					  	</c:forEach>					  	
						<span class="badge badge-important">${count }</span>
					  </button>
					  <div id="myDropdown" class="dropdown-content">
					  <c:forEach var="item" items="${notifications }">
					    <a href="${newsDetail }?id=${item.newId}" <c:if test="${item.status == 1 }">class="status_1" onClick="updateCommentStatus(${item.commentId})"</c:if>>				    					
					    	<div class="clearfix">						
								<span class="pull-left">
								<i class="btn btn-xs no-hover btn-pink fa fa-comment"></i>									
									<strong>${item.userName } </strong>  đã bình luận về bài viết (${item.createdDate })
								</span>							
							</div>
						</a>
						</c:forEach>					 
					  </div>
					</div>
				</li>	
                <li class="light-blue dropdown-modal">
                    <a href='<c:url value='/thoat'/>'>
                        <i class="ace-icon fa fa-power-off"></i>
                        Thoát
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
};
function updateCommentStatus(id) {	
	var data = [""+id+""];
    $.ajax({
        url: '${commentAPI}/update-status',
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
