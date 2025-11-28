package com.bolsadeideas.springboot.app.models.dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import com.bolsadeideas.springboot.app.models.entity.Notificacion;

public interface INotificacionDao extends CrudRepository<Notificacion, Long>{

	public List<Notificacion> findByEstado(String estado);
}
