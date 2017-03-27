/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.school.counterapi.endpoints;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author Mikkel
 */
@Path("/counter")
public class CounterResource {
    Data data = new Data();
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCounter(){
        ++Count.counter;
        data.update();
        return Response.ok(data).header("Access-Control-Allow-Origin", "*")
			.header("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT")
			.allow("OPTIONS").build();
    }
    
    
    @PUT
    @Path("{value}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response setCounter(@PathParam("value") String value) {
        Count.counter = Integer.parseInt(value);
        data.update();
        return Response.ok(data).build();
    }
}
