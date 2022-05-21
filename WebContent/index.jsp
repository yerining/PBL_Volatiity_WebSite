<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Volatility</title>
</head>
<center>
    <!-- 파일업로드 --> method="post" enctype="Multipart/form-data" -->
	<h3>Volatility</h3>
    <form action="fileuploadPro.jsp" method="post" enctype="Multipart/form-data">
        <!--
            파일 업로드는 input type="file"로 지정한다.
         -->
        File: <input type="file" name="fileName1" /><br/>
	Command: <input type="text" name="command"/><br/>
	Profile: <input type="text" name="profile" /><br/>
        <input type="submit" value="전송" />  
        <input type="reset" value="취소" />
    </form>
</center>
