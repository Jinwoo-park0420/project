<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String fileName=request.getParameter("fileName");

	String sDownPath="d:/upload";
	String sFilePath=sDownPath+"/"+fileName;
	
	FileInputStream in=new FileInputStream(sFilePath);
	
	//response 헤더 설정 설정
	response.setContentType("application/octet-stream");
	String agent=request.getHeader("User-Agent");
	
	boolean ieBrowser = (agent.indexOf("MSIE")>-1)||(agent.indexOf("Trident")>-1)||(agent.indexOf("Edge")>-1);
	
	if(ieBrowser){
		fileName=URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20");
	}else{
		fileName=new String(fileName.getBytes("UTF-8"),"iso-8859-1");
	}
	
	//_를 기준으로 fileName 잘라내기
	int start=fileName.lastIndexOf("_");
	fileName=fileName.substring(start+1);
	
	out.clear();
	out=pageContext.pushBody();
	
	response.setHeader("Content-Disposition", "attachment;filename="+fileName);
	BufferedOutputStream buf=new BufferedOutputStream(response.getOutputStream());
	
	int numRead;
	byte[] b=new byte[4896];
	while((numRead=in.read(b,0,b.length))!=-1){
		buf.write(b,0,numRead);
	}
	buf.flush();
	buf.close();
	in.close();
%>