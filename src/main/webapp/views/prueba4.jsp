<!DOCTYPE html>
<html lang="en">
<head>
    <title>scanner.js demo: Scan and Upload Directly</title>
    <meta charset='utf-8'>
    <script src="//asprise.com/scan/scannerjs/demo/inc/scanner.js"  type="text/javascript"></script>

    <script>
        //
        // Please read scanner.js developer's guide at: http://asprise.com/document-scan-upload-image-browser/ie-chrome-firefox-scanner-docs.html
        //
        /** Scan and upload in one go */
        function scanAndUploadDirectly() {
            asprise_scanner_js_scan(displayServerResponse,
                {
                    "output_settings": [
                        {
                            "type": "upload",
                            "format": "pdf",
                            "upload_target": {
                                "url": "http://localhost:8080/js-example/rest/file/upload?action=dump",
                                "post_fields": {
                                    "sample-field": "Test scan"
                                },
                                "cookies": document.cookie,
                                "headers": [
                                    "Referer: " + window.location.href,
                                    "User-Agent: " + navigator.userAgent
                                ]
                            }
                        }
                    ]
                }
            );
        }
        function displayServerResponse(successful, mesg, response) {
            if(!successful) { // On error
                document.getElementById('server_response').innerHTML = 'Fall�: ' + mesg;
                return;
            }
            if(successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { // User cancelled.
                document.getElementById('server_response').innerHTML = 'Cancelado por el usuario';
                return;
            }
            document.getElementById('server_response').innerHTML = getUploadResponse(response);
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

    <h2>Scanea y Sube Directamente</h2>

    <button type="button" onclick="scanAndUploadDirectly();">Scanea y Sube</button>

    <div id="server_response"></div>

</body>
</html>