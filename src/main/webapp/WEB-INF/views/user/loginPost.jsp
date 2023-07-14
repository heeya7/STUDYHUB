<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- jQuery library -->	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<html>

<script>
$(document).ready(function(e){
	var loginResult = '${loginResult}';
	
	 if (loginResult != null && loginResult != "") {
	    alert(loginResult);
	    window.location.href = '/user/login'; // 리다이렉트할 URL
	 }
	 
}); // end ready function
</script>

</html>