<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Volatility</title>
<link href='design.css' rel='stylesheet' type='text/css'>
</head>
<<<<<<< HEAD
  
<h1><strong>Volatility Using</strong> with Web</h1>
  
<form action="fileuploadPro.jsp" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="title">사용할 명령어 <span>를 입력해주세요.</span></label>
     
        <input type="text" name="command" id="command" class="form-controll"/>
    </div>
    <div class="form-group">
      <label for="caption">Profile <span>를 입력해주세요.</span></label>
      <input type="text" name="profile" id="profile" class="form-controll"/>
    </div>
    
    <div class="form-group file-area">
          <label for="images">이미지 파일 <span>을 넣으면 Volatility 명령이 작동됩니다.</span></label>
      <input type="file" name="fileName1"/>
      <div class="file-dummy">
      </div>
    </div>
    
    <div class="form-group">
      <button type="submit">명령어 결과보기</button>
    </div>

</form>


<a href="howToUse.jsp" class="back-to-article" target="_blank">사용법(How to Use)</a>
=======
<center>
    <!-- 파일업로드 --> method="post" enctype="Multipart/form-data" -->
	<h3>Volatility</h3>
    <form action="fileuploadPro.jsp" method="post" enctype="Multipart/form-data">
        <!-- 파일 업로드는 input type="file"로 지정한다. -->
        File: <input type="file" name="fileName1" /><br/>
	Command: <input type="text" name="command"/><br/>
	Profile: <input type="text" name="profile" /><br/>
        <input type="submit" value="전송" />  
        <input type="reset" value="취소" />
    </form>
</center>
>>>>>>> 817ef3ac84cea790ae28603ecd57212b8594aef5
