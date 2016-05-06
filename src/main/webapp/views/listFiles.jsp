<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Archivos Disponibles</title>
</head>
<body>
	<p>
	<h1>Archivos en carpeta :</h1>
	<br />
	<c:forEach var="archivo" items="${it.archivos}">
        <a href="download/${archivo}">${archivo}</a><br />
	</c:forEach>
	</p>
</body>