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
</head>
 
<%
    String uploadPath = "/var/lib/tomcat8/webapps/ROOT/uploadfile/"; //파일을 업로드 할 경로
    out.write("[Volatility Result]" + "<br>" + "<br>");
    int maxSize =1024 * 1024 * 500;// 한번에 올릴 수 있는 파일 용량 : 500M로 제한
     
    String profile =""; //profile 이름 
    
    String fileName1 =""; // 중복처리된 이름
    String originalName1 =""; // 중복 처리 전 실제 원본 이름
    
    long fileSize = 0; // 파일 사이즈
    String fileType =""; // 파일 타입
    
    String command=""; //명령어
    
    String s;
    Process p;
         
    MultipartRequest multi =null;
    
    try{
        // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
        multi =new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
        
        //input 명령어 가져오기
        command = multi.getParameter("command");
        //input profile 가져오기
        profile = multi.getParameter("profile");

        // 전송한 전체 파일이름들을 가져옴
        Enumeration files = multi.getFileNames();
 
        while(files.hasMoreElements()){
            // form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져온다.
            String file1 = (String)files.nextElement();
            //실제 파일 이름을 가져옴
            originalName1 = multi.getOriginalFileName(file1);
            //중복에 대한 처리
            fileName1 = multi.getFilesystemName(file1);
            // 파일 타입 정보를 가져옴
            fileType = multi.getContentType(file1);
            // input file name에 해당하는 실제 파일을 가져옴
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

	// session에 명령어 저장
	session.setAttribute("command",command);
	
	//profile로 분류하여 profile이 필요한 다른 명령어 실행
	if(profile.equals("") && command.equals("imageinfo")){
	   realCommand = "volatility -f " + realPath + " " + command; 
	}else{
	   realCommand = "volatility -f " + realPath + " " + "--profile=" + profile + " " + command;
	}
	
	//리눅스 쉘
    String[] cmd = {"/bin/sh" , "-c", realCommand}; 
	
	//리눅스 쉘 실행
	p = Runtime.getRuntime().exec(cmd);
	
	BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
	
	//file write
	while( (s = br.readLine()) != null ){
		fw.write(s);
		fw.write(s);
		
		//명령어 실행 내용 화면 출력
		out.write(s + "<br>");
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
<br><p style="text-weight: bold">[Download]</p>
<a href="http://xxx.xxx.xxx:8080/download.jsp">File Download</a>