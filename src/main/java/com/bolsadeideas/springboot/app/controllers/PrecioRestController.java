package com.bolsadeideas.springboot.app.controllers;



import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RestController;

import com.bolsadeideas.springboot.app.models.dto.MonitoreoPrecioDto;
import com.bolsadeideas.springboot.app.models.entity.Notificacion;
import com.bolsadeideas.springboot.app.models.service.IPrecioService;

@RestController
@CrossOrigin()
@RequestMapping("/v0")
public class PrecioRestController {
	
	//private Logger logger = LoggerFactory.getLogger(JpaUserDetailsService.class);
	
	@Autowired
	private IPrecioService precioService;
	
	@RequestMapping(value = "/monitorearPrecio", method = RequestMethod.GET)
	public MonitoreoPrecioDto monitorearPrecio() {		
		return precioService.monitorearPrecio();
		//precioService.monitorearPrecio();
		//return "llamo a precio asincrono";		
	}
	
	@RequestMapping(value = "/enviarNotificaciones", method = RequestMethod.GET)
	public String enviarNotificaciones() {		
		try {
			return precioService.enviarNotificacion();
		}
		catch (Exception e)
		{
			return e.toString();
		}
	}
	
	@RequestMapping(value = "/actualizarNotificacion/{id}", method = RequestMethod.PATCH)
	public Notificacion actualizarNotificacion(@PathVariable Long id,@RequestBody Map<String, Object> cambios) {
		return precioService.actualizarNotificacion(id, cambios);
	}
	
	@GetMapping("/ping")
	public String ping() { return "ok"; }
	
}
