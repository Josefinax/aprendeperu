CREATE DATABASE aprende_peru_db;
USE aprende_peru_db;

CREATE TABLE personas (
    idpersona 			BIGINT PRIMARY KEY AUTO_INCREMENT,
    apellidos 			VARCHAR(255)			NOT NULL,
    nombres 			VARCHAR(255)			NOT NULL,
    dni 				CHAR(8)					NOT NULL,
    telefono 			CHAR(9) 				NOT NULL,
    email 				VARCHAR(255)			NOT NULL
)ENGINE = INNODB;

INSERT INTO personas (apellidos, nombres, dni, telefono, email) VALUES
('Gonzales Ruiz', 'Ana María', '11111111', '912345678', 'ana@gmail.com'),
('Torres Medina', 'Luis Alberto', '22222222', '923456789', 'luis@gmail.com'),
('Soto Vargas', 'Carmen Elena', '33333333', '934567890', 'carmen@gmail.com'),
('Quispe Pérez', 'José Manuel', '44444444', '945678901', 'jose@gmail.com'),
('Lopez Díaz', 'Pedro Pablo', '55555555', '956789012', 'pedro@gmail.com');

SELECT * FROM personas;

CREATE TABLE administradores (
    idadministrador 	BIGINT PRIMARY KEY AUTO_INCREMENT,
    idpersona 			BIGINT					NOT NULL,
    nomuser 			VARCHAR(255)			NOT NULL,
    contraseña  		VARCHAR(255)			NOT NULL,
    nivelacceso 		CHAR(1)					NOT NULL,
    CONSTRAINT fk_idpersona_per FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
)ENGINE = INNODB;

INSERT INTO administradores (idpersona, nomuser, contraseña, nivelacceso) VALUES
(1, 'admin_ana', 'clave123', 'A'),
(2, 'admin_luis', 'clave456', 'B'),
(3, 'admin_carmen', 'clave789', 'A'),
(4, 'admin_jose', 'clave000', 'B'),
(5, 'admin_pedro', 'clave111', 'C');

SELECT * FROM administradores;

CREATE TABLE categorias (
    idcategoria			BIGINT PRIMARY KEY AUTO_INCREMENT,
    categoria 			VARCHAR(255)			NOT NULL
)ENGINE = INNODB;

INSERT INTO categorias (categoria) VALUES
('Lógica matemática'),
('Lectura crítica'),
('Razonamiento verbal'),
('Matemática básica'),
('Ciencias sociales');

SELECT * FROM categorias;

CREATE TABLE evaluaciones (
    idevaluacion		BIGINT PRIMARY KEY AUTO_INCREMENT,
    idadministrador 	BIGINT					NOT NULL,
    idcategoria 		BIGINT					NOT NULL,
    titulo 				VARCHAR(255)			NOT NULL,
    fechacreacion 		DATETIME				NOT NULL,
    duracion 			SMALLINT				NOT NULL,
    fechainicio 		DATETIME				NOT NULL,
    fechafin 			DATETIME				NOT NULL,
    CONSTRAINT fk_idadministrador_ad FOREIGN KEY (idadministrador) REFERENCES administradores(idadministrador),
    CONSTRAINT fk_idcategoria_cat FOREIGN KEY (idcategoria) REFERENCES categorias(idcategoria)
)ENGINE = INNODB;

INSERT INTO evaluaciones (idadministrador, idcategoria, titulo, fechacreacion, duracion, fechainicio, fechafin) VALUES
(1, 1, 'Evaluación lógica 1', NOW(), 30, '2025-06-03', '2025-06-03'),
(2, 2, 'Comprensión lectora', NOW(), 40, '2025-06-03', '2025-06-03'),
(3, 3, 'Razonamiento verbal básico', NOW(), 25, '2025-06-03', '2025-06-03'),
(4, 4, 'Operaciones básicas', NOW(), 20, '2025-06-03', '2025-06-03'),
(5, 5, 'Historia del Perú', NOW(), 35, '2025-06-03', '2025-06-03');

SELECT * FROM evaluaciones;

CREATE TABLE preguntas (
    idpregunta 			BIGINT PRIMARY KEY AUTO_INCREMENT,
    idevaluacion 		BIGINT 					NOT NULL,
    pregunta 			TEXT 					NOT NULL,
    puntaje 			TINYINT 				NOT NULL,
    rutaimagen 			VARCHAR(255) 			NOT NULL,
    CONSTRAINT fk_idevaluacion_evl FOREIGN KEY (idevaluacion) REFERENCES evaluaciones(idevaluacion)
)ENGINE = INNODB;

INSERT INTO preguntas (idevaluacion, pregunta, puntaje, rutaimagen) VALUES
(1, '¿Cuantos es 5 + 3', 4, ''),
(2, '¿Cómo se llama el conejo del cuento?', 4, ''),
(3, 'Antónimo de “frío”', 4, ''),
(4, '¿Cuánto es 5 + 7?', 4, ''),
(5, '¿Quién fue el libertador del Peru?', 4, '');

SELECT * FROM preguntas;

CREATE TABLE alternativas (
    idalternativa		BIGINT PRIMARY KEY AUTO_INCREMENT,
    idpregunta 			BIGINT 					NOT NULL,
    texto 				VARCHAR(255) 			NOT NULL,
    escorrecta 			BOOLEAN 				NOT NULL,
    CONSTRAINT fk_idpregunta_pre FOREIGN KEY (idpregunta) REFERENCES preguntas(idpregunta)
)ENGINE = INNODB;

INSERT INTO alternativas (idpregunta, texto, escorrecta) VALUES
(1, '8', TRUE),
(1, 'conejo', FALSE),
(2, 'caliente', TRUE),
(3, '12', TRUE),
(4, ' José de San Martín', TRUE);

SELECT * FROM alternativas;

CREATE TABLE asignaciones (
    idasignacion		BIGINT PRIMARY KEY AUTO_INCREMENT,
    idpersona 			BIGINT 					NOT NULL,
    idevaluacion 		BIGINT 					NOT NULL,
    fechainicio 		DATETIME 				NOT NULL,
    fechafin 			DATETIME 				NOT NULL,
    CONSTRAINT fk_idpersona_asig FOREIGN KEY (idpersona) REFERENCES personas(idpersona),
    CONSTRAINT fk_idevaluacion_asig FOREIGN KEY (idevaluacion) REFERENCES evaluaciones(idevaluacion)
)ENGINE = INNODB;

INSERT INTO asignaciones (idpersona, idevaluacion, fechainicio, fechafin) VALUES
(1, 1, '2025-06-03', '2025-06-03'),
(2, 2, '2025-06-03', '2025-06-03'),
(3, 3, '2025-06-03', '2025-06-03'),
(4, 4, '2025-06-03', '2025-06-03'),
(5, 5, '2025-06-03', '2025-06-03');

SELECT * FROM asignaciones;

CREATE TABLE respuestas (
    idrespuesta			BIGINT PRIMARY KEY AUTO_INCREMENT,
    idasignacion 		BIGINT 					NOT NULL,
    idpregunta 			BIGINT 					NOT NULL,
    idalternativa 		BIGINT 					NOT NULL,
    escorrecta 			BOOLEAN 				NOT NULL,
    CONSTRAINT fk_idasignacion_rsp FOREIGN KEY (idasignacion) REFERENCES asignaciones(idasignacion),
    CONSTRAINT fk_idpregunta_rsp FOREIGN KEY (idpregunta) REFERENCES preguntas(idpregunta),
    CONSTRAINT fk_idalternativa_rsp FOREIGN KEY (idalternativa) REFERENCES alternativas(idalternativa)
)ENGINE = INNODB;

INSERT INTO respuestas (idasignacion, idpregunta, idalternativa, escorrecta) VALUES
(1, 1, 1, TRUE),
(2, 2, 3, TRUE),
(3, 3, 4, TRUE),
(4, 4, 5, TRUE),
(5, 5, 1, FALSE); 

SELECT * FROM respuestas;



