CREATE DATABASE IF NOT EXISTS notificacionesAUD;
USE notificacionesAUD;

CREATE TABLE IF NOT EXISTS historicoprecio (
  id_historico_precio  int(11) NOT NULL AUTO_INCREMENT,
  moneda       VARCHAR(10) NULL,
  hora   	   TIMESTAMP NOT NULL,
  precio   	   double NOT NULL,
  PRIMARY KEY (id_historico_precio)
) COMMENT='Tabla para registrar el historico de precios de una moneda AUDUSD';

CREATE TABLE IF NOT EXISTS notificaciones (
  id_notificacion  int(11) NOT NULL AUTO_INCREMENT,
  tipo             VARCHAR(10) NULL COMMENT 'P=activa la notificacion si llega a un precio determinado, D= diferencia de precio supera el valor configurado',
  precio 		   double NOT NULL COMMENT 'si tipo es D es la diferencia entre el precio anterior y nuevo para disparar la notificacion',
  estado      	   VARCHAR(10) NULL COMMENT 'C=configurada, pendiente de activarse, A= activa, lista para enviar la notificacion, F= finalizada, ya se disparo y ya fue atendida finaliza el proceso',
  direccion       VARCHAR(10)  NULL COMMENT 'B=Baja, S=Sube Aplica para tipo=P, para saber si el precio se debe comparar como menor o como mayor',
  titulo           VARCHAR(50) NULL,
  mensaje           VARCHAR(250) NULL,
  PRIMARY KEY (id_notificacion)
) COMMENT='Tabla para configurar las notificaciones';

INSERT INTO notificaciones (tipo,precio,estado,titulo,mensaje) VALUES ('D',0.0005,'C','volatilidad  de precio AUDUSD','El precio de AUDUSD ha superado diferencial de 0.0005 en los ultimos 2 minutos')


CREATE TABLE IF NOT EXISTS users (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_empresa int(11) NOT NULL,
  username varchar(30) NOT NULL,
  password varchar(60) NOT NULL,
  tipo_identificacion varchar(5) DEFAULT NULL,
  num_identificacion varchar(20) DEFAULT NULL,
  nombre varchar(200) DEFAULT NULL,
  telefono varchar(50) DEFAULT NULL,
  ciudad varchar(200) DEFAULT NULL,
  departamento varchar(200) DEFAULT NULL,
  direccion varchar(200) DEFAULT NULL,
  email varchar(150) DEFAULT NULL,  
  enabled tinyint(1) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY username (username),
  KEY FK_id_empresa (id_empresa),
  CONSTRAINT FK_user_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_GENERAL_CI;

CREATE TABLE IF NOT EXISTS authorities (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  authority varchar(30) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY user_id_authority (user_id,authority),
  CONSTRAINT FK_authorities_users_usuarioId FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS depuraciones (
	id_depuracion INT(11) NOT NULL AUTO_INCREMENT,
	id_empresa  int(11) NOT NULL,
	id_user int(11) NOT NULL,
	fecha date DEFAULT NULL,
	PRIMARY KEY (id_depuracion) USING BTREE,
	CONSTRAINT FK_depuraciones_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT FK_depuraciones_user FOREIGN KEY (id_user) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION
	
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS afiliados (
  id_afiliado int(11) NOT NULL AUTO_INCREMENT,
  id_empresa int(11) NOT NULL,
  fec_afiliacion date DEFAULT NULL,
  tipo_identificacion varchar(5) DEFAULT NULL,
  num_identificacion varchar(20) DEFAULT NULL,
  nombre varchar(200) DEFAULT NULL,
  fec_expedicion date DEFAULT NULL,
  telefono varchar(50) DEFAULT NULL,
  ciudad varchar(200) DEFAULT NULL,
  departamento varchar(200) DEFAULT NULL,
  pais_origen varchar(200) DEFAULT NULL,
  titularidad varchar(200) DEFAULT NULL,
  predio varchar(200) DEFAULT NULL,
  lgtbiq bit DEFAULT 0,
  direccion varchar(200) DEFAULT NULL,
  ocupacion varchar(150) DEFAULT NULL,
  fec_nacimiento date DEFAULT NULL,
  edad int(11) DEFAULT NULL,
  comision_trabajo varchar(150) DEFAULT NULL,
  genero varchar(50) DEFAULT NULL,
  email varchar(150) DEFAULT NULL,
  estado int(11) DEFAULT NULL,
  id_depuracion int(11) DEFAULT NULL,
  discapacidad varchar(150) DEFAULT NULL,
  grupo_etnico varchar(150) DEFAULT NULL,
  nivel_educativo varchar(150) DEFAULT NULL,
  hecho_victimizante varchar(150) DEFAULT NULL,
  huella varchar(200) DEFAULT NULL,
  PRIMARY KEY (id_afiliado),
  UNIQUE KEY num_identificacion (num_identificacion),
  KEY FK_afiliado_depuracion (id_depuracion),
  KEY FK_afiliado_empresa (id_empresa),
  CONSTRAINT FK_afiliado_depuracion FOREIGN KEY (id_depuracion) REFERENCES depuraciones (id_depuracion) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_afiliado_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

alter table empresas add KEY FK_empresas_afiliado_presidente (id_afiliado_presidente);
alter table empresas add KEY FK_empresas_afiliado_secretario (id_afiliado_secretario);
alter table empresas add CONSTRAINT FK_empresas_afiliado_presidente FOREIGN KEY (id_afiliado_presidente) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION;
alter table empresas add CONSTRAINT FK_empresas_afiliado_secretario FOREIGN KEY (id_afiliado_secretario) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE IF NOT EXISTS reuniones (
  id_reunion int(11) NOT NULL AUTO_INCREMENT,
  id_empresa int(11) DEFAULT NULL,
  nombre varchar(255) DEFAULT NULL,
  direccion varchar(255) DEFAULT NULL,
  ciudad varchar(255) DEFAULT NULL,
  departamento varchar(255) DEFAULT NULL,
  fecha datetime DEFAULT NULL,
  fec_convocatoria datetime DEFAULT NULL,
  fec_cierre_afiliados datetime DEFAULT NULL,
  estado int(11) DEFAULT NULL,
  tipo int(11) DEFAULT NULL,
  id_reunion_origen int(11) DEFAULT NULL,
  PRIMARY KEY (id_Reunion) USING BTREE,
  KEY FK_reunion_empresa (id_empresa) USING BTREE,
  CONSTRAINT FK_reunion_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS asistentes (
  id_asistente int(11) NOT NULL AUTO_INCREMENT,
  id_afiliado int(11) NOT NULL,
  id_reunion int(11) NOT NULL,
  estado varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_asistente),
  UNIQUE KEY id_afiliado_id_Reunion (id_afiliado,id_Reunion),
  CONSTRAINT FKAsistenteAfiliado FOREIGN KEY (id_afiliado) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FKAsistenteReunion FOREIGN KEY (id_Reunion) REFERENCES reuniones (id_Reunion) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para registrar los asistentes a una reunión';

CREATE TABLE IF NOT EXISTS ordendia (
  id_orden_dia int(11) NOT NULL AUTO_INCREMENT,
  nombre varchar(255) DEFAULT NULL,
  texto varchar(3000) DEFAULT NULL,
  texto1 varchar(3000) DEFAULT NULL,
  texto2 varchar(3000) DEFAULT NULL,
  texto3 varchar(3000) DEFAULT NULL,
  texto4 varchar(3000) DEFAULT NULL,
  PRIMARY KEY (id_orden_dia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS reunionordendia (
  id_reunion_orden_dia int(11) NOT NULL AUTO_INCREMENT,
  id_orden_dia int(11) NOT NULL,
  id_Reunion int(11) NOT NULL,
  orden int(11) NOT NULL,
  PRIMARY KEY (id_reunion_orden_dia),
  UNIQUE KEY id_orden_dia_id_Reunion (id_orden_dia,id_Reunion),
  CONSTRAINT FKOrdenDia FOREIGN KEY (id_orden_dia) REFERENCES ordendia (id_orden_dia) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FKReunion FOREIGN KEY (id_Reunion) REFERENCES reuniones (id_Reunion) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para relacionar reuniones con ordenes del dia (muchos a muchos)';

-- Volcando estructura para tabla sysrepjac.actareuniones
CREATE TABLE IF NOT EXISTS actareuniones (
  id_acta_reunion int(11) NOT NULL AUTO_INCREMENT,
  id_reunion int(11) NOT NULL,
  ano int(11) NOT NULL,
  numero_acta int(11) DEFAULT NULL,
  afiliados int(11) DEFAULT 0,
  quorum50mas1primero int(11) DEFAULT 0,
  inicia50mas1primero int(11) DEFAULT 0, #--0 NO, 1 SI
  fec50mas1primero TIMESTAMP NULL DEFAULT NULL,
  quorumsegundo int(11) DEFAULT 0,
  iniciasegundo int(11) DEFAULT 0, #--0 NO, 1 SI
  fecsegundo TIMESTAMP NULL DEFAULT NULL,
  quorumtercero int(11) DEFAULT 0,
  iniciatercero int(11) DEFAULT 0, #--0 NO, 1 SI
  fectercero TIMESTAMP NULL DEFAULT NULL,
  id_reunion_reagenda int(11) NULL DEFAULT NULL,
  asistentes int(11) DEFAULT 0,
  id_afiliado_presidente int(11) DEFAULT NULL,
  id_afiliado_secretario int(11) DEFAULT NULL,
  votos_elegir_presidente int (11) DEFAULT 0,
  votos_elegir_secretario int (11) DEFAULT 0,
  aprobado_presid_secre int(11) DEFAULT 0,
  aprobado_orden_dia int(11) DEFAULT 0,
  aprobado_proposicion int (11) DEFAULT 0,
  votos_proposicion int (11) DEFAULT 0,
  aprobado_lectura int(11) DEFAULT 0,
  votos_lectura int(11) DEFAULT 0,
  num_capitulos_estatutos int(11) DEFAULT 0,
  num_articulos_estatutos int(11) DEFAULT 0,
  votos_orden_dia int(11) DEFAULT 0,
  id_afiliado_tribunal INT(11) DEFAULT NULL,
  id_afiliado_tribunalA INT(11) DEFAULT NULL,
  id_afiliado_tribunalB INT(11) DEFAULT NULL,
  id_afiliado_tribunalC INT(11) DEFAULT NULL,
  id_afiliado_tribunalD INT(11) DEFAULT NULL,
  id_afiliado_tribunalE INT(11) DEFAULT NULL,  
  aprobado_tribunal INT(11) DEFAULT 0,
  votos_tribunal INT(11) DEFAULT 0,
  id_afiliado_jurado INT(11) DEFAULT NULL,
  id_afiliado_jurado_testigo INT(11) DEFAULT NULL,
  aprobado_jurado INT(11) DEFAULT 0,
  votos_jurado INT(11) DEFAULT 0,
  sistema_eleccion varchar(100) DEFAULT NULL,
  aprobado_sistema_eleccion INT(11) DEFAULT 0,
  votos_sistema_eleccion INT(11) DEFAULT 0,
  tipo_candidatizacion varchar(100) DEFAULT NULL,
  aprobado_planchas INT(11) DEFAULT 0,
  votos_planchas INT(11) DEFAULT 0,
  aprobado_determinacion INT(11) DEFAULT 0,
  votos_determinacion INT(11) DEFAULT 0,
  aprobado_plazo_planchas INT(11) DEFAULT 0,
  votos_plazo_planchas INT(11) DEFAULT 0,
  fec_plazo_presentacion TIMESTAMP NULL DEFAULT NULL,
  aprobado_presentacion_candidatos INT(11) DEFAULT 0,
  votos_presentacion_candidatos INT(11) DEFAULT 0,
  hora_instalacion_jornada TIMESTAMP NULL DEFAULT NULL,
  aprobado_instalacion_mesas INT(11) DEFAULT 0,
  hora_instalacion_mesas TIMESTAMP NULL DEFAULT NULL,
  votos_instalacion_mesas INT(11) DEFAULT 0,
  hora_apertura_votacion TIMESTAMP NULL DEFAULT NULL,
  aprobado_apertura_votacion INT(11) DEFAULT 0,
  votos_apertura_votacion INT(11) DEFAULT 0,
  hora_cierre_votacion TIMESTAMP NULL DEFAULT NULL,
  aprobado_cierre_votacion INT(11) DEFAULT 0,
  votos_cierre_votacion INT(11) DEFAULT 0,
  hora_elaboracion_escrutinios TIMESTAMP NULL DEFAULT NULL,
  aprobado_elaboracion_escrutinios INT(11) DEFAULT 0,
  votos_urna1 INT(11) DEFAULT 0,
  votos_urna2 INT(11) DEFAULT 0,
  votos_urna3 INT(11) DEFAULT 0,
  votos_urna4 INT(11) DEFAULT 0,
  votos_urna5 INT(11) DEFAULT 0,
  votos_urna6 INT(11) DEFAULT 0,
  conclusion_conteo varchar(255) NULL,
  hora_asignacion_cargos TIMESTAMP NULL DEFAULT NULL,
  aprobado_asignacion_cargos INT(11) DEFAULT 0,
  votos_asignacion_cargos INT(11) DEFAULT 0,
  hora_aceptacion_cargos TIMESTAMP NULL DEFAULT NULL,
  aprobado_aceptacion_cargos INT(11) DEFAULT 0,
  votos_aceptacion_cargos INT(11) DEFAULT 0,
  aprobado_elaboracion_lectura_acta INT(11) DEFAULT 0,
  votos_elaboracion_lectura_acta INT(11) DEFAULT 0,
  hora_cierre_asamblea TIMESTAMP NULL DEFAULT NULL,
  aprobado_contra_dignatario INT(11) DEFAULT 0,
  votos_contra_dignatario INT(11) DEFAULT 0,
  aprobado_descargos_dignatario INT(11) DEFAULT 0,
  votos_descargos_dignatario INT(11) DEFAULT 0,
  id_afiliado_tesorero INT(11) DEFAULT NULL,
  aprobado_revocatoria_tesorero INT(11) DEFAULT 0,
  votos_revocatoria_tesorero INT(11) DEFAULT 0,
  hora_reforma_estatutaria TIMESTAMP NULL DEFAULT NULL,
  aprobado_reforma_estatutaria INT(11) DEFAULT 0,
  votos_reforma_estatutaria INT(11) DEFAULT 0,
  hora_desarrollo_estrategico TIMESTAMP NULL DEFAULT NULL,
  aprobado_desarrollo_estrategico INT(11) DEFAULT 0,
  votos_desarrollo_estrategico INT(11) DEFAULT 0,
  hora_plan_accion TIMESTAMP NULL DEFAULT NULL,
  aprobado_plan_accion INT(11) DEFAULT 0,
  votos_plan_accion INT(11) DEFAULT 0,
  aprobado_presentacion_presupuesto INT(11) DEFAULT 0,
  votos_presentacion_presupuesto INT(11) DEFAULT 0,
  lugar_votacion varchar(100) DEFAULT NULL,
  fecha_hora_votacion datetime DEFAULT NULL,
  
  PRIMARY KEY (id_acta_reunion) USING BTREE,
  UNIQUE KEY id_reunion (id_reunion),
  UNIQUE KEY id_reunion_reagenda (id_reunion_reagenda),
  UNIQUE KEY ano_consecutivo (ano,numero_acta) USING BTREE,
  KEY FK_acta_reunion (id_reunion),
  KEY FK_acta_reunion_reagenda (id_reunion_reagenda),
  KEY FK_acta_afiliado_presidente (id_afiliado_presidente),
  KEY FK_acta_afiliado_secretario (id_afiliado_secretario),
  KEY FK_acta_afiliado_tribunal (id_afiliado_tribunal),
  KEY FK_acta_afiliado_tribunalA (id_afiliado_tribunalA),
  KEY FK_acta_afiliado_tribunalB (id_afiliado_tribunalB),
  KEY FK_acta_afiliado_tribunalC (id_afiliado_tribunalC),
  KEY FK_acta_afiliado_tribunalD (id_afiliado_tribunalD),
  KEY FK_acta_afiliado_tribunalE (id_afiliado_tribunalE),
  KEY FK_acta_afiliado_jurado (id_afiliado_jurado),
  KEY FK_acta_afiliado_jurado_testigo (id_afiliado_jurado_testigo),
  KEY FK_acta_afiliado_tesorero (id_afiliado_tesorero),
  CONSTRAINT FK_acta_afiliado_presidente FOREIGN KEY (id_afiliado_presidente) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_secretario FOREIGN KEY (id_afiliado_secretario) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_reunion FOREIGN KEY (id_reunion) REFERENCES reuniones (id_Reunion) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_reunion_reagenda FOREIGN KEY (id_reunion_reagenda) REFERENCES reuniones (id_Reunion) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunal FOREIGN KEY (id_afiliado_tribunal) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunalA FOREIGN KEY (id_afiliado_tribunalA) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunalB FOREIGN KEY (id_afiliado_tribunalB) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunalC FOREIGN KEY (id_afiliado_tribunalC) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunalD FOREIGN KEY (id_afiliado_tribunalD) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tribunalE FOREIGN KEY (id_afiliado_tribunalE) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_jurado FOREIGN KEY (id_afiliado_jurado) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_jurado_testigo FOREIGN KEY (id_afiliado_jurado_testigo) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_acta_afiliado_tesorero FOREIGN KEY (id_afiliado_tesorero) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS testigos (
  id_testigo int(11) NOT NULL AUTO_INCREMENT,
  id_acta_reunion int(11) NOT NULL,
  id_afiliado int(11) NOT NULL,
  PRIMARY KEY (id_testigo),
  CONSTRAINT FKTestigosAfiliado FOREIGN KEY (id_afiliado) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FKTestigoActa FOREIGN KEY (id_acta_reunion) REFERENCES actareuniones (id_acta_reunion) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para registrar los testigos de un acta de elecciones';

CREATE TABLE IF NOT EXISTS actaordendia (
  id_acta_orden_dia int(11) NOT NULL AUTO_INCREMENT,
  id_acta_reunion int(11) NOT NULL,
  id_orden_dia int(11) NOT NULL,
  nombre varchar(255) DEFAULT NULL,
  texto varchar(3000) DEFAULT NULL,
  texto1 varchar(3000) DEFAULT NULL,
  texto2 varchar(3000) DEFAULT NULL,
  texto3 varchar(3000) DEFAULT NULL,
  texto4 varchar(3000) DEFAULT NULL,
  orden int(11) NOT NULL,
  PRIMARY KEY (id_acta_orden_dia),
  INDEX FK_actaOrdenDia_actaReunion (id_acta_reunion) USING BTREE,
  CONSTRAINT FK_actaOrdenDia_actaReunion FOREIGN KEY (id_acta_reunion) REFERENCES actareuniones (id_acta_reunion) ON UPDATE NO ACTION ON DELETE CASCADE,
  INDEX FK_actaOrdenDia_idOrdenDia(id_orden_dia) USING BTREE,
  CONSTRAINT FK_actaOrdenDia_idOrdenDia FOREIGN KEY (id_orden_dia) REFERENCES ordendia (id_orden_dia) ON UPDATE NO ACTION ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando estructura para tabla sysrepjac.actareuniones
CREATE TABLE IF NOT EXISTS planchas (
  id_planchas int(11) NOT NULL AUTO_INCREMENT,
  id_reunion int(11) NOT NULL,
  id_afiliado_presidente int(11) NOT NULL,
  id_afiliado_vice_presidente int(11) NOT NULL,
  id_afiliado_tesorero int(11) NOT NULL,
  id_afiliado_secretario int(11) NOT NULL,
  id_afiliado_fiscal_A int(11) NOT NULL,
  id_afiliado_fiscal_B int(11) NOT NULL,
  id_afiliado_conciliador_A int(11) NOT NULL,
  id_afiliado_conciliador_B int(11) NOT NULL,
  id_afiliado_conciliador_C int(11) NOT NULL,
  id_afiliado_delegado_A int(11) NOT NULL,
  id_afiliado_delegado_suplente_A int(11) NOT NULL,
  id_afiliado_delegado_B int(11) NOT NULL,
  id_afiliado_delegado_suplente_B int(11) NOT NULL,
  id_afiliado_delegado_C int(11) NOT NULL,
  id_afiliado_delegado_suplente_C int(11) NOT NULL,
  id_afiliado_delegado_presidente_D int(11) NOT NULL,
  id_afiliado_delegado_suplente_vicepresidente int(11) NOT NULL,
  id_afiliado_comision_salud int(11) NOT NULL,
  id_afiliado_comision_obras int(11) NOT NULL,
  id_afiliado_comision_educacion int(11) NOT NULL,
  id_afiliado_comision_deportes int(11) NOT NULL,
  id_afiliado_comision_ambiental int(11) NOT NULL,
  id_afiliado_comision_ddhh int(11) NOT NULL,
  id_afiliado_delegado_empresarias_A int(11) NOT NULL,
  id_afiliado_delegado_empresarias_B int(11) NOT NULL,
  id_afiliado_delegado_empresarias_C int(11) NOT NULL,
  id_afiliado_presentado_por int(11) NOT NULL,

  PRIMARY KEY (id_planchas) USING BTREE,
  KEY FK_plancha_afiliado_presidente (id_afiliado_presidente),
  KEY FK_plancha_afiliado_vice_presidente (id_afiliado_vice_presidente),
  KEY FK_plancha_afiliado_tesorero (id_afiliado_tesorero),
  KEY FK_plancha_afiliado_secretario (id_afiliado_secretario),
  KEY FK_plancha_afiliado_fiscal_A (id_afiliado_fiscal_A),
  KEY FK_plancha_afiliado_fiscal_B (id_afiliado_fiscal_B),
  KEY FK_plancha_afiliado_conciliador_A (id_afiliado_conciliador_A),
  KEY FK_plancha_afiliado_conciliador_B (id_afiliado_conciliador_B),
  KEY FK_plancha_afiliado_conciliador_C (id_afiliado_conciliador_C),
  KEY FK_plancha_afiliado_delegado_A (id_afiliado_delegado_A),
  KEY FK_plancha_afiliado_delegado_suplente_A (id_afiliado_delegado_suplente_A),
  KEY FK_plancha_afiliado_delegado_B (id_afiliado_delegado_B),
  KEY FK_plancha_afiliado_delegado_suplente_B (id_afiliado_delegado_suplente_B),
  KEY FK_plancha_afiliado_delegado_C (id_afiliado_delegado_C),
  KEY FK_plancha_afiliado_delegado_suplente_C (id_afiliado_delegado_suplente_C),
  KEY FK_plancha_afiliado_delegado_presidente_D (id_afiliado_delegado_presidente_D),
  KEY FK_plancha_afiliado_delegado_suplente_vicepresidente (id_afiliado_delegado_suplente_vicepresidente),
  KEY FK_plancha_afiliado_comision_salud (id_afiliado_comision_salud),
  KEY FK_plancha_afiliado_comision_obras (id_afiliado_comision_obras),
  KEY FK_plancha_afiliado_comision_educacion (id_afiliado_comision_educacion),
  KEY FK_plancha_afiliado_comision_deportes (id_afiliado_comision_deportes),
  KEY FK_plancha_afiliado_comision_ambiental (id_afiliado_comision_ambiental),
  KEY FK_plancha_afiliado_comision_ddhh (id_afiliado_comision_ddhh),
  KEY FK_plancha_afiliado_delegado_empresarias_A (id_afiliado_delegado_empresarias_A),
  KEY FK_plancha_afiliado_delegado_empresarias_B (id_afiliado_delegado_empresarias_B),
  KEY FK_plancha_afiliado_delegado_empresarias_C (id_afiliado_delegado_empresarias_C),
  KEY FK_plancha_afiliado_presentado_por (id_afiliado_presentado_por),
  CONSTRAINT FK_plancha_afiliado_presidente FOREIGN KEY (id_afiliado_presidente) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_vice_presidente FOREIGN KEY (id_afiliado_vice_presidente) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_tesorero FOREIGN KEY (id_afiliado_tesorero) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_secretario FOREIGN KEY (id_afiliado_secretario) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_fiscal_A FOREIGN KEY (id_afiliado_fiscal_A) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_fiscal_B FOREIGN KEY (id_afiliado_fiscal_B) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_conciliador_A FOREIGN KEY (id_afiliado_conciliador_A) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_conciliador_B FOREIGN KEY (id_afiliado_conciliador_B) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_conciliador_C FOREIGN KEY (id_afiliado_conciliador_C) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_A FOREIGN KEY (id_afiliado_delegado_A) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_suplente_A FOREIGN KEY (id_afiliado_delegado_suplente_A) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_B FOREIGN KEY (id_afiliado_delegado_B) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_suplente_B FOREIGN KEY (id_afiliado_delegado_suplente_B) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_C FOREIGN KEY (id_afiliado_delegado_C) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_suplente_C FOREIGN KEY (id_afiliado_delegado_suplente_C) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_presidente_D FOREIGN KEY (id_afiliado_delegado_presidente_D) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_suplente_vicepresidente FOREIGN KEY (id_afiliado_delegado_suplente_vicepresidente) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_salud FOREIGN KEY (id_afiliado_comision_salud) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_obras FOREIGN KEY (id_afiliado_comision_obras) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_educacion FOREIGN KEY (id_afiliado_comision_educacion) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_deportes FOREIGN KEY (id_afiliado_comision_deportes) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_ambiental FOREIGN KEY (id_afiliado_comision_ambiental) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_comision_ddhh FOREIGN KEY (id_afiliado_comision_ddhh) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_empresarias_A FOREIGN KEY (id_afiliado_delegado_empresarias_A) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_empresarias_B FOREIGN KEY (id_afiliado_delegado_empresarias_B) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_delegado_empresarias_C FOREIGN KEY (id_afiliado_delegado_empresarias_C) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_plancha_afiliado_presentado_por FOREIGN KEY (id_afiliado_presentado_por) REFERENCES afiliados (id_afiliado) ON DELETE NO ACTION ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS conceptosegresos (
  id_concepto_egresos int(11) NOT NULL AUTO_INCREMENT,
  tipo varchar(255) DEFAULT NULL,
  concepto varchar(255) DEFAULT NULL,
  cuenta int(11) NOT NULL,
  PRIMARY KEY (id_concepto_egresos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS egresos (
  id_egresos int(11) NOT NULL AUTO_INCREMENT,
  id_empresa  int(11) NOT NULL,
  numero int(11) NOT NULL,
  fecha date DEFAULT NULL,
  beneficiario varchar(255) DEFAULT NULL,  
  identificacion varchar(20) DEFAULT NULL,
  ciudad     varchar(255) DEFAULT NULL,
  departamento varchar(255) DEFAULT NULL,
  direccion  varchar(255) DEFAULT NULL,
  telefono   varchar(255) DEFAULT NULL,
  banco varchar(255) DEFAULT NULL,
  cheque varchar(50) DEFAULT NULL,
  efectivo int(11) DEFAULT 0,
  id_users int(11) NOT NULL,
  PRIMARY KEY (id_egresos),
  UNIQUE KEY egresoNumero (numero),
  KEY FK_egresos_empresa (id_empresa),
  KEY FK_egresos_users (id_users),
  CONSTRAINT FK_egresos_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_egresos_users FOREIGN KEY (id_users) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS itemegresos (
  id_itemegresos int(11) NOT NULL AUTO_INCREMENT,
  id_egresos  int(11) NOT NULL,
  id_concepto_egresos int(11) NOT NULL,
  concepto varchar(255) DEFAULT NULL,  
  valor bigint(20) DEFAULT 0,
  PRIMARY KEY (id_itemegresos),
  KEY FK_itemegresos_egresos (id_egresos),
  KEY FK_itemegresos_conceptosegresos (id_concepto_egresos),
  CONSTRAINT FK_itemegresos_egresos FOREIGN KEY (id_egresos) REFERENCES egresos (id_egresos) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_itemegresos_conceptosegresos FOREIGN KEY (id_concepto_egresos) REFERENCES conceptosegresos (id_concepto_egresos) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS conceptosingresos (
  id_concepto_ingresos int(11) NOT NULL AUTO_INCREMENT,
  concepto varchar(255) DEFAULT NULL,
  cuenta int(11) NOT NULL,
  PRIMARY KEY (id_concepto_ingresos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS ingresos (
  id_ingresos int(11) NOT NULL AUTO_INCREMENT,
  id_empresa  int(11) NOT NULL,
  numero int(11) NOT NULL,
  fecha date DEFAULT NULL,
  recibido_de varchar(255) DEFAULT NULL,  
  identificacion varchar(20) DEFAULT NULL,
  ciudad     varchar(255) DEFAULT NULL,
  departamento varchar(255) DEFAULT NULL,
  direccion  varchar(255) DEFAULT NULL,
  telefono   varchar(255) DEFAULT NULL,
  banco varchar(255) DEFAULT NULL,
  cheque varchar(50) DEFAULT NULL,
  efectivo int(11) DEFAULT 0,
  id_users int(11) NOT NULL,
  PRIMARY KEY (id_ingresos),
  UNIQUE KEY ingresoNumero (numero),
  KEY FK_ingresos_empresa (id_empresa),
  KEY FK_ingresos_users (id_users),
  CONSTRAINT FK_ingresos_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_ingresos_users FOREIGN KEY (id_users) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS itemingresos (
  id_itemingresos int(11) NOT NULL AUTO_INCREMENT,
  id_ingresos  int(11) NOT NULL,
  id_concepto_ingresos int(11) NOT NULL,
  concepto varchar(255) DEFAULT NULL,  
  valor bigint(20) DEFAULT 0,
  PRIMARY KEY (id_itemingresos),
  KEY FK_itemingresos_ingresos (id_ingresos),
  KEY FK_itemingresos_conceptosingresos (id_concepto_ingresos),
  CONSTRAINT FK_itemingresos_ingresos FOREIGN KEY (id_ingresos) REFERENCES ingresos (id_ingresos) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_itemingresos_conceptosingresos FOREIGN KEY (id_concepto_ingresos) REFERENCES conceptosingresos (id_concepto_ingresos) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS entradas (
  id_inventario int(11) NOT NULL AUTO_INCREMENT,
  id_empresa  int(11) NOT NULL,
  tipo varchar(3) DEFAULT NULL,  
  numero int(11) NOT NULL,
  fecha date DEFAULT NULL,
  tercero varchar(255) DEFAULT NULL,  
  identificacion varchar(20) DEFAULT NULL,
  ciudad     varchar(255) DEFAULT NULL,
  departamento varchar(255) DEFAULT NULL,
  direccion  varchar(255) DEFAULT NULL,
  telefono   varchar(255) DEFAULT NULL,
  causal varchar(255) DEFAULT NULL,
  id_users int(11) NOT NULL,
  PRIMARY KEY (id_inventario),
  KEY FK_entradas_empresa (id_empresa),
  KEY FK_entradas_users (id_users),
  CONSTRAINT FK_entradas_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_entradas_users FOREIGN KEY (id_users) REFERENCES users (id) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS itementradas (
  id_itementradas int(11) NOT NULL AUTO_INCREMENT,
  id_inventario  int(11) NOT NULL,
  cantidad int(11) NOT NULL,
  concepto varchar(255) DEFAULT NULL,  
  valor bigint(20) DEFAULT 0,
  PRIMARY KEY (id_itementradas),
  KEY FK_itementradas_entradas (id_inventario),
  CONSTRAINT FK_itementradas_entradas FOREIGN KEY (id_inventario) REFERENCES entradas (id_inventario) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `librotesoreria` AS SELECT id_empresa, fecha, concepto,'I' as tipo,numero,i.id_concepto_ingresos, valor as debito, 0 as credito 
FROM ingresos ing
  INNER JOIN itemingresos i ON ing.id_ingresos=i.id_ingresos
UNION ALL
SELECT id_empresa, fecha, concepto,'E' as tipo,numero,id_concepto_egresos, 0 as debito, valor as credito 
FROM egresos e
  INNER JOIN itemegresos i ON e.id_egresos=i.id_egresos ;
  
--eliminacion de los drop