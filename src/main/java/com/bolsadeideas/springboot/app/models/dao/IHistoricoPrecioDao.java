package com.bolsadeideas.springboot.app.models.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.bolsadeideas.springboot.app.models.entity.HistoricoPrecio;

public interface IHistoricoPrecioDao extends CrudRepository<HistoricoPrecio, Long>{

	@Query ("SELECT h FROM HistoricoPrecio h WHERE h.hora = (SELECT MAX(h2.hora) FROM HistoricoPrecio h2)")
	HistoricoPrecio findUltimoPrecio();
	
}
