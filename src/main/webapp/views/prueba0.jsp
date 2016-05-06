<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Scanner</title>

<STYLE type="text/css">
DIV.cabecera {
	background-color: lightskyblue;
	height: 150px;
	width: 90%;
	padding-top: 20px;
	padding-left: 20px;
}

DIV.propiedades {
	width: 90%;
	height: 150px;
	background-color: antiquewhite;
}

DIV.scanner {
	margin-top: 4px;
	width: 90%;
	height: 150px;
	background-color: aliceblue;
}

DIV.top_scanner {
	margin-top: 8px;
	border-top-width: 2px;
	padding-top: 5px;
}

DIV.botom_scanner {
	
}

DIV.vista {
	width: 90%;
	height: 150px;
	background-color: antiquewhite;
}

DIV.preselect {
	width: 60%;
	position: relative;
	float: left;
}

DIV.postselect {
	width: 40%;
	position: relative;
	float: left;
}

DIV.previsualizacion {
	
}

DIV.botonera_default {
	width: 20%;
	position: relative;
	float: left;
	text-align: center;
}

DIV.doblecara {
	position: relative;
	float: right;
	width: 50%
}

DIV.color {
	position: relative;
	float: left;
	width: 50%
}

DIV.deteccion_scanner {
	position: relative;
	float: left;
	width: 50%;
}

DIV.mostrarConfiguracion {
	position: relative;
	float: left;
	width: 50%;
}

img.previa {
	margin-top: 7px;
	width: 300px;
	height: 100px;
}
</STYLE>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

<script src="http://asprise.com/scan/scannerjs/demo/inc/scanner.js"
	type="text/javascript"></script>

<script type="text/javascript">
	function scan() {
		displayStatus(true, 'Scanning', true);
		asprise_scanner_js_scan(handleImages, {
			"output_settings" : [ {
				"type" : "return-base64",
				"format" : "jpg",
				"thumbnail_height": 200
			} ]
		}, true, false);

		//* com_asprise_scan_request(myCallBackFunc, // callback on dialog closed
		//*	com_asprise_scan_cmd_method_SCAN, // action: SCAN
		//*	com_asprise_scan_cmd_return_IMAGES_AND_THUMBNAILS, // return types
		//*	{'wia-version': 2} // options
		//* ); 
	}

	/**
	 * Appends image to given dom node.
	 * @param scannedImage ScannedImage
	 * @param domParent
	 */
	function appendImage(scannedImage, domParent, isThumbnail) {
		if (!scannedImage) {
			return;
		}
		logToConsole("Appending scanned image: " + scannedImage.toString());
		if (!isThumbnail) {
			imagesScanned.push(scannedImage);
		}
		if (scannedImage.mimeType == MIME_TYPE_BMP
				|| scannedImage.mimeType == MIME_TYPE_GIF
				|| scannedImage.mimeType == MIME_TYPE_JPEG
				|| scannedImage.mimeType == MIME_TYPE_PNG) {
// 			var elementImg = createDomElementFromModel({
// 				'name' : 'img',
// 				'attributes' : {
// 					'class' : 'scanned zoom thumb thumb-img',
// 					'src' : scannedImage.src,
// 					'height' : '100'
// 				}
// 			});
// 			domParent.appendChild(elementImg);
			$(domParent).attr('src', scannedImage.src).addClass('scanned zoom thumb thumb-img').attr('height', '100');
			// optional UI effect that allows the user to click the image to zoom.
			//enableZoom();

		} else if (scannedImage.mimeType == MIME_TYPE_PDF) {
// 			var elementA = createDomElementFromModel({
// 				'name' : 'a',
// 				'attributes' : {
// 					'href' : 'javascript:previewPdf('
// 							+ (imagesScanned.length - 1) + ');',
// 					'class' : 'thumb thumb-pdf'
// 				}
// 			});
// 			domParent.appendChild(elementA);
			$(domParent).attr('href', 'javascript:previewPdf(' + (imagesScanned.length - 1) + ');').addClass('thumb thumb-pdf');
		}
	}

	/** Returns true if it is successfully or false if failed and reports error. */
	function checkIfSuccessfully(successful, mesg, response) {
		displayStatus(false, '', true);
		if (successful && mesg != null
				&& mesg.toLowerCase().indexOf('user cancel') >= 0) { // User cancelled.
			displayStatus(false, '<pre>' + "User cancelled." + '</pre>', true);
			return false;
		} else if (!successful) {
			displayStatus(false, '<pre>' + "Failed: " + mesg + "\n" + response
					+ '</pre>', true);
			return false;
		}
		return true;
	}

	/** Callback function to retrieve scanned images. Returns number of images retrieved. */
	function handleImages(successful, mesg, response) {
		if (!checkIfSuccessfully(successful, mesg, response)) {
			return 0;
		}

		var scannedImages = getScannedImages(response, true, false);
		displayStatus(false, '<pre>' + "Scanned Successfully" + '</pre>', true);
		for (var i = 0; (scannedImages instanceof Array)
				&& i < scannedImages.length; i++) {
			var img = scannedImages[i];
			displayStatus(false, "\n<pre>  " + img.toString() + "</pre>", false);
			appendImage(img, document.getElementById('images'));
		}
		return (scannedImages instanceof Array) ? scannedImages.length : 0;
	}

	function myCallBackFunc(success, mesg, thumbs, images) {
		for (var i = 0; (thumbs instanceof Array) && i < thumbs.length; i++) {
			addImage(thumbs[i], document.getElementById('images'));
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

	// -------------- Optional status display, depending on JQuery --------------
	function displayStatus(loading, mesg, clear) {
		if (loading) {
			$('#info')
					.html(
							(clear ? '' : $('#info').html())
									+ '<p><img src="https://asprise.com/legacy/product/_jia/applet/loading.gif" style="vertical-align: middle;" hspace="8"> '
									+ mesg + '</p>');
		} else {
			$('#info').html((clear ? '' : $('#info').html()) + mesg);
		}
	}

	$(document).ready(function() {
		$(".optDocumentos").on("change", function() {
			alert("Cambio la opcion de documentos");
		});
		$(':input[name="doblecara"]').on('change', function() {
			alert('doble cara');
		});
		$(':input[name="color"]').on('change', function() {
			alert('color');
		});
		$(':input[name="predeterminado"]').on('change', function() {
			alert('predeterminado');
		});
		$(':input[name="mostrarConfiguracion"]').on('change', function() {
			alert('mostrarConfiguracion');
		});

	})
</script>
</head>

<body>
	<div class="cabecera">
		<select class="optDocumentos">
			<option>-- Seleccione --</option>
			<option>Padrón</option>
			<option>Permiso de Circulación</option>
			<option>Solicitud de Primera Inscripción</option>
			<option>Acta de devolución TAG</option>
			<option>Compra/Venta de vehículo</option>
			<option>Cédula de Identidad</option>
			<option>Licencia</option>
		</select>


	</div>

	<div class="propiedades"></div>

	<div class="scanner">
		<div class="preselect">
			<div class="top_scanner">
				<input type="checkbox" name="predeterminado" value="scanner">
				Scanner predeterminado<br>
			</div>
			<div class="middle_scanner">
				<div class="deteccion_scanner">
					<button type="button" onclick="scan();">Scan</button>
				</div>
				<div class="mostrarConfiguracion">
					<input type="checkbox" name="mostrarConfiguracion"
						value="mostrarConfiguracion"> Mostrar configuración<br>
				</div>
			</div>
			<div class="botom_scanner">
				<div class="doblecara">
					<input type="checkbox" name="doblecara" value="doble">
					Doble cara<br>
				</div>
				<div class="color">
					<input type="checkbox" name="color" value="color"> Color<br>
				</div>
			</div>
		</div>

		<div class="postselect">
			<div class="previsualizacion">
				<img class="previa" id="images" />
			</div>
			<div class="botonera_imagenes">
				<div class="botonera_printer botonera_default">P</div>
				<div class="botonera_left botonera_default">L</div>
				<div class="botonera_right botonera_default">R</div>
			</div>
		</div>
	</div>

	<div class="vista"></div>
	<div id="info"></div>
</body>
</html>