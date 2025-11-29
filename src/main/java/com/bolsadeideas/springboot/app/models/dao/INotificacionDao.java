package com.bolsadeideas.springboot.app.models.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.bolsadeideas.springboot.app.models.entity.Notificacion;

public interface INotificacionDao extends JpaRepository<Notificacion, Long>{

	public List<Notificacion> findByEstado(String estado);
	//public Notificacion findById(Long id);
}
