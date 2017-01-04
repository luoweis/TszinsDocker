<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<html>
    <head>
        <meta http-equiv='content-type' content='text/html;charset=utf-8'>
    </head>
    <title>Tszins</title>
    <body>
        <h1 align="center">欢迎，访问青岛三藏信息科技有限公司！</h1>
        <h3 align="center">just for test</h3>
        <h4>
        <%
        Date dNow = new Date( );
        SimpleDateFormat ft =
         new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
        out.print( "<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
        %>
        </h4>

   </body>
</html>