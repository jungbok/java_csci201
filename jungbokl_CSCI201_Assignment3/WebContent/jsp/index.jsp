<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<form action="${pageContext.request.contextPath}/ChooseFile"
		method="post" enctype="multipart/form-data">
		<div>
			<label>Please choose a JSON file</label> <br /> <input accept=".json"
				type="file" id="file" name="file">
		</div>
		<div>
			Choose Your Style: <br />
			<label><input type='radio' id="css1" name='stylecss' value='1' checked>style 1</label><br />
			<label><input type='radio' id="css2" name='stylecss' value='2'>style 2</label>
		</div>
		<div>
			<input type="submit" value="Upload File" />
		</div>
	</form>
</body>
</html>