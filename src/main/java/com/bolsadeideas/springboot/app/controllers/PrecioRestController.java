package com.bolsadeideas.springboot.app.controllers;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RestController;

import com.bolsadeideas.springboot.app.models.service.IPrecioService;







@RestController
@CrossOrigin()
@RequestMapping("/v0")
public class PrecioRestController {
	
	//private Logger logger = LoggerFactory.getLogger(JpaUserDetailsService.class);
	
	@Autowired
	private IPrecioService precioService;
	
	@RequestMapping(value = "/monitorearPrecio", method = RequestMethod.GET)
	public String monitorearPrecio() {		
		//return precioService.monitorearPrecio();
		precioService.monitorearPrecio();
		return "llamo a precio asincrono";		
	}
	
}
