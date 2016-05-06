<!DOCTYPE html>
<html lang="en">
<head>
    <title>scanner.js demo: Scan PDF to Form</title>
    <meta charset='utf-8'>
    <script src="//asprise.com/scan/scannerjs/demo/inc/scanner.js"  type="text/javascript"></script>

    <script>
        //
        // Please read scanner.js developer's guide at: http://asprise.com/document-scan-upload-image-browser/ie-chrome-firefox-scanner-docs.html
        //
        /** Scan: output PDF original and JPG thumbnails */
        function scanToPdfWithThumbnails() {
            asprise_scanner_js_scan(displayImagesOnPage,
                    {
                        "output_settings": [
                            {
                                "type": "return-base64",
                                "format": "pdf",
                                "pdf_text_line": "By ${USERNAME} on ${DATETIME}"
                            },
                            {
                                "type": "return-base64-thumbnail",
                                "format": "jpg",
                                "thumbnail_height": 200
                            }
                        ]
                    }
            );
        }
        /** Processes the scan result */
        function displayImagesOnPage(successful, mesg, response) {
            if(!successful) { // On error
                console.error('Failed: ' + mesg);
                return;
            }
            if(successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { // User cancelled.
                console.info('User cancelled');
                return;
            }
            var scannedImages = getScannedImages(response, true, false); // returns an array of ScannedImage
            for(var i = 0; (scannedImages instanceof Array) && i < scannedImages.length; i++) {
                var scannedImage = scannedImages[i];
                processOriginal(scannedImage);
            }
            var thumbnails = getScannedImages(response, false, true); // returns an array of ScannedImage
            for(var i = 0; (thumbnails instanceof Array) && i < thumbnails.length; i++) {
                var thumbnail = thumbnails[i];
                processThumbnail(thumbnail);
            }
        }
        /** Images scanned so far. */
        var imagesScanned = [];
        /** Processes an original */
        function processOriginal(scannedImage) {
            imagesScanned.push(scannedImage);
        }
        /** Processes a thumbnail */
        function processThumbnail(scannedImage) {
            var elementImg = createDomElementFromModel( {
                'name': 'img',
                'attributes': {
                    'class': 'scanned',
                    'src': scannedImage.src
                }
            });
            document.getElementById('images').appendChild(elementImg);
        }
        /** Upload scanned images by submitting the form */
        function submitFormWithScannedImages() {
            if (asprise_scanner_js_submit_form_with_images('form1', imagesScanned, function (xhr) {
                if (xhr.readyState == 4) { // 4: request finished and response is ready
                    document.getElementById('server_response').innerHTML = "<h2>Respuesta desde el servidor: </h2>" + xhr.responseText;
                    document.getElementById('images').innerHTML = ''; // clear images
                    imagesScanned = [];
                }
            })) {
                document.getElementById('server_response').innerHTML = "Enviando, por favor espere ...";
            } else {
                document.getElementById('server_response').innerHTML = "Env�o del formulario cancelado.";
            }
        }
    </script>

    <style>
        img.scanned {
            height: 200px; /** Sets the display size */
            margin-right: 12px;
        }
        div#images {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h2>Scanea un PDF al formulario y luego se env�a</h2>

    <button type="button" onclick="scanToPdfWithThumbnails();">Scan</button>

    <div id="images"></div>

    <!-- Previous lines are same as demo-01, below is new addition to demo-02 -->

<!--     <form id="form1" action="https://asprise.com/scan/applet/upload.php?action=dump" method="POST" enctype="multipart/form-data" target="_blank" > -->
    <form id="form1" action="files/upload?action=dump" method="POST" enctype="multipart/form-data" target="_blank" >
        <input type="text" id="sample-field" name="sample-field" value="Test scan"/>
        <input type="button" value="Submit" onclick="submitFormWithScannedImages();">
    </form>

    <div id="server_response"></div>

</body>
</html>