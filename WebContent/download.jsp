<%@ page contentType="application;" %>
<%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
<%
	//세션에 저장한 command 가져오기
	String command=(String) session.getAttribute("command");
	//파일 이름
	String fileName = command + ".txt";
	String strFilenameOutput=new String(fileName.getBytes("euc-kr"),"8859_1");
	
	//파일 경로
	File file=new File("/var/lib/tomcat8/webapps/ROOT/uploadfile/"+fileName);
	
	byte b[]=new byte[(int)file.length()];
	
	response.setHeader("Content-Disposition","attachment;filename="+strFilenameOutput);
	response.setHeader("Content-Length",String.valueOf(file.length()));
	
	if(file.isFile()){
	 BufferedInputStream fin=new BufferedInputStream(new FileInputStream(file));
	 BufferedOutputStream outs=new BufferedOutputStream(response.getOutputStream());
	 
	 int read=0;
	 
	 while((read=fin.read(b))!=-1){
		 outs.write(b,0,read);
	 }
	 
	 outs.close();
	 fin.close();
}
%>