package cl.signosti.scanner.js_example;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

import com.sun.jersey.api.view.Viewable;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

import cl.signosti.scanner.pojos.FileUploaded;

@Path("/files")
public class FileManager {

	private static final String SERVER_UPLOAD_LOCATION_FOLDER = "C://Temp/Upload_Files/";

	/**
	 * Upload a File
	 */

	@POST
	@Path("/upload")
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	@Produces(MediaType.APPLICATION_JSON)
	public FileUploaded uploadFile(@FormDataParam("com_asprise_scannerjs_images[]") InputStream fileInputStream,
							   @FormDataParam("com_asprise_scannerjs_images[]") FormDataContentDisposition contentDispositionHeader, 
							   @FormDataParam("sample-field") String sampleField,
							   @QueryParam("action") String action) {

		String filePath = SERVER_UPLOAD_LOCATION_FOLDER + contentDispositionHeader.getFileName();

		// save the file to the server
		saveFile(fileInputStream, filePath);
		
		return new FileUploaded(4, "Archivo almacenado");
		
	}

	// save uploaded file to a defined location on the server
	private void saveFile(InputStream uploadedInputStream, String serverLocation) {

		OutputStream outpuStream = null;
		try {
			int read = 0;
			byte[] bytes = new byte[1024];

			outpuStream = new FileOutputStream(new File(serverLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				outpuStream.write(bytes, 0, read);
			}
			outpuStream.flush();
			
		} catch (IOException e) {

			e.printStackTrace();
		} finally {
			if(outpuStream != null){
				try {
					outpuStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}
	
	@GET
	@Path("/list")
	public Response getFileList(){
		File folder = new File(SERVER_UPLOAD_LOCATION_FOLDER);
		File[] listOfFiles = folder.listFiles();
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> archivos = new ArrayList<String>();
		
		for(File file: listOfFiles){
			archivos.add(file.getName());
		}
		map.put("archivos", archivos);

		return Response.ok(new Viewable("/views/listFiles", map)).build();
	}
	
	@GET
	@Path("/download/{fileName}")
	public Response getDownLoad(@PathParam("fileName") String fileName){
		
		File file = new File(SERVER_UPLOAD_LOCATION_FOLDER + fileName);
		
		ResponseBuilder response = Response.ok((Object) file);
		response.header("Content-Disposition",
				"attachment; filename="+fileName);
		return response.build();
		
	}
}