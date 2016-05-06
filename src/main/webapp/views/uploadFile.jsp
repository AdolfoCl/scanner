<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Page</title>
</head>
<body>
	<h1>Sube un archivo</h1>

	<form action="files/upload?action=dump" method="POST"
		enctype="multipart/form-data">

		<p>
			Seleccione un archivo : <input type="file" name="file" size="50" />
		</p>
		
		<input type="text" id="sample-field" name="sample-field" value="Test scan"/>
		
		<input type="submit" value="Upload It" />
	</form>

</body>
</html>