<%@page import="java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Volatility</title>
<link href='design.css' rel='stylesheet' type='text/css'>
</head>
<body style="text-align: center;"> 
<%
    // request.getRealPath("상대경로") 를 통해 파일을 저장할 절대 경로를 구해온다.
    // 운영체제 및 프로젝트가 위치할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는게 좋음
    String uploadPath = "/var/lib/tomcat8/webapps/ROOT/uploadfile/";
%>
    <p style="margin-top: 10%; font-size: 20px; font-weight: bold"> [Volatility Result] </p>
<%    
    int maxSize =1024 * 1024 * 500;// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
     
    String profile =""; //profile name 
    String fileName1 =""; // 중복처리된 이름
    String originalName1 =""; // 중복 처리전 실제 원본 이름
    long fileSize = 0; // 파일 사이즈
    String fileType =""; // 파일 타입
    String command=""; //command
    
    String s;
    Process p;
         
    MultipartRequest multi =null;
    
    try{
        // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
        multi =new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
         
        command = multi.getParameter("command");
        profile = multi.getParameter("profile");

        // 전송한 전체 파일이름들을 가져옴
        Enumeration files = multi.getFileNames();
 
        while(files.hasMoreElements()){
            // form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져온다.
            String file1 = (String)files.nextElement();// 파일 input에 지정한 이름을 가져옴
            // 그에 해당하는 실재 파일 이름을 가져옴
            originalName1 = multi.getOriginalFileName(file1);
            // 파일명이 중복될 경우 중복 정책에 의해 뒤에 1,2,3 처럼 붙어 unique하게 파일명을 생성하는데
            // 이때 생성된 이름을 filesystemName이라 하여 그 이름 정보를 가져온다.(중복에 대한 처리)
            fileName1 = multi.getFilesystemName(file1);
            // 파일 타입 정보를 가져옴
            fileType = multi.getContentType(file1);
            // input file name에 해당하는 실재 파일을 가져옴
            File file = multi.getFile(file1);
            // 그 파일 객체의 크기를 알아냄
            fileSize = file.length();
        }
	
	//file Name
	String fileName = uploadPath + command + ".txt";

	File file = new File(fileName);
	FileWriter fw = new FileWriter(file);
	String pathfile = uploadPath + fileName1;
	String realCommand = "";
	String realPath = pathfile;

	// session save
	session.setAttribute("command",command);
	
	//command
	if(profile.equals("") && command.equals("imageinfo")){
	   realCommand = "volatility -f " + realPath + " " + command; 
	}else{
	   realCommand = "volatility -f " + realPath + " " + "--profile=" + profile + " " + command;
	}

        String[] cmd = {"/bin/sh" , "-c", realCommand}; 
		
	p = Runtime.getRuntime().exec(cmd);
	
	BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
	
	//file write
	while( (s = br.readLine()) != null ){
		fw.write(s);
		fw.write("\n");
%>
		<%= s %> <br>
<%
		
	}

	fw.flush();

	p.waitFor();
	p.destroy();

	fw.close();
                    
    }catch(Exception e){
        e.printStackTrace();
    } 
    
%>

<!--
    a태그로 클릭시 download하는 jsp페이지로 이동하도록 함
-->
<br><p style="font-size: 20px; font-weight: bold">[Download]</p>
<a href="http://192.168.10.235:8080/download.jsp">File Download Click!</a>
<br><br>
<a href="index.jsp">File Upload GO!</a>
