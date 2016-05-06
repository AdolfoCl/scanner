package cl.signosti.scanner.js_example;

import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import com.sun.jersey.api.view.Viewable;

@Stateless
@Path("/")
public class PruebaManager {

	@GET
	@Produces("text/html")
	public Response getIt() {
		return Response.ok(new Viewable("/index")).build();
//		return new Viewable("/index");
	}
	
	@GET
	@Path("prueba0")
	@Produces("text/html")
	public Response getPrueba0() {
		return Response.ok(new Viewable("/views/prueba0")).build();
	}
	
	@GET
	@Path("prueba1")
	@Produces("text/html")
	public Response getPrueba1() {
		return Response.ok(new Viewable("/views/prueba1")).build();
	}
	
	@GET
	@Path("prueba2")
	@Produces("text/html")
	public Response getPrueba2() {
		return Response.ok(new Viewable("/views/prueba2")).build();
	}
	
	@GET
	@Path("prueba3")
	@Produces("text/html")
	public Response getPrueba3() {
		return Response.ok(new Viewable("/views/prueba3")).build();
	}
	
	@GET
	@Path("prueba4")
	@Produces("text/html")
	public Response getPrueba4() {
		return Response.ok(new Viewable("/views/prueba4")).build();
	}
	
	@GET
	@Path("pruebaUploadFile")
	@Produces("text/html")
	public Response getPruebaUploadFile() {
		return Response.ok(new Viewable("/views/uploadFile")).build();
	}
}
