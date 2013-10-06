<%--
  - Author  : HNJ
  - Date  : 2011.01.24
  - Copyright (c) 1999-2005 (?)ACTSoft All rights reserved
  - @(#)
  - Description : 
  --%>
<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
 <%-- 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
 <title>list</title>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
 <script type="text/javascript" src="/commons/scripts/jquery-1.4.2.js"></script>
 <script type="text/javascript">
 
  <%-- 과정/차수에 해당하는 정보 가져오기 --%>
  function applctList() {
   $.ajax({
     type: "POST",
     url: "<c:url value="/menutest/listjson.do" />",
     data: $("#searchFrm").serialize(),
     dataType: "json",
     async: false,
     success: function(data){
      $('#firstName').val(data.firstName);
      $('#lastName').val(data.lastName);
      $('#email').val(data.email);
      alert('success!');
     }
     ,error: function(){
       alert('error!');
     }
     });
  }
 
 </script>
 
</head>
<body>
<form name="searchFrm" id="searchFrm" method="post" >
* 전송값<br />
 value1 = <input type="text" id="useStart" name="useStart" value="${resultMap.value1}" /><br />
 value2 = <input type="text" id="useExpire" name="useExpire" value="${resultMap.value2}" /><br />
 <a href="#" onclick="javascript:applctList();">전송</a><br /><br />
</form> 
* 받은값 <br />
<input type="text" id="firstName" name="firstName"  /><br />
<input type="text" id="lastName" name="lastName"  /><br />
<input type="text" id="email" name="email"  /><br />
 
</body>
</html>



