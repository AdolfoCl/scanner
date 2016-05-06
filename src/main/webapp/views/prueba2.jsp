<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prueba 2</title>
<script type="text/javascript" src="../js/scanner.js"></script>
<script type="text/javascript">
	function scan() {
		com_asprise_scan_request(myCallBackFunc, // callback on dialog closed
		com_asprise_scan_cmd_method_SCAN, // action: SCAN
		com_asprise_scan_cmd_return_IMAGES_AND_THUMBNAILS, // return types
		{
			'wia-version' : 2
		} // options
		);
	}

	function myCallBackFunc(success, mesg, thumbs, images) {
		for (var i = 0; (images instanceof Array) && i < images.length; i++) {
			addImage(images[i], document.getElementById('images'));
		}
	}

	var imagesScanned = []; // global var to store all images scanned
	function addImage(imgObj, domParent) {
		imagesScanned.push(imgObj);
		var imgSrc = imgObj.datatype == com_asprise_scan_datatype_BASE64 ? 'data:'
				+ imgObj.mimetype + ';base64,' + imgObj.data
				: imgObj.data;
		var elementImg = createDomElementFromModel({
			'name' : 'img',
			'attributes' : {
				'class' : 'scanned',
				'src' : imgSrc,
				'height' : '100',
				'class' : 'zoom'
			}
		});
		domParent.appendChild(elementImg);
	}
</script>
</head>
<body>
	<form id="form1"
		action="http://asprise.com/scan/applet/upload.php?action=dump"
		method="POST" enctype="multipart/form-data" target="_blank">
		<label for="field1"
			style="display: inline-block; width: 150px; text-align: right;">Field
			1</label> <input id="field1" name="field1" type="text" value="value 1" /> <br>
		<span style="height: 4px;"></span><br> <label
			style="display: inline-block; width: 150px; text-align: right;">Documents</label>
		<button type="button" onclick="scan();">Scan</button>
		<div id="images" style="margin-left: 154px; margin-top: 10px;">
		</div>
		<input type="button" value="Submit form" onclick="submitForm1();"
			style="margin-left: 154px; margin-top: 20px;">
	</form>
</body>
</html>