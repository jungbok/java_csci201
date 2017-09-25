<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>First Page</title>
</head>
<body>
	<div>
		<h3><strong> Please choose a JSON file</strong> </h3>
	<form method="POST" action = "JsonServlet" enctype = "multipart/form-data">
	<b>Select File:</b><input type = "file" name="file" id="file"><br/>
	<input type= "submit" value="submit">
	</form>
	</div>
</body>
</html>