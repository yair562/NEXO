-- =====================================================================
-- NEXO: datos de PRUEBA (ficticios). No usar en producción.
-- Archivo 3 de 3. Requiere los archivos 1 y 2.
-- =====================================================================
BEGIN;
INSERT INTO carrera (nombre) VALUES ('Carrera ficticia A'), ('Carrera ficticia B');
INSERT INTO materia (clave, nombre) VALUES ('MAT-001','Materia ficticia 1'), ('MAT-002','Materia ficticia 2');
INSERT INTO plan_estudios (carrera_id, materia_id, semestre)
SELECT c.id, m.id, 1 FROM carrera c CROSS JOIN materia m;
INSERT INTO tema (materia_id, tema_padre_id, nombre)
SELECT id, NULL, 'Tema general' FROM materia;
INSERT INTO etiqueta (nombre) VALUES ('derivadas'), ('ejemplo'), ('examen');
INSERT INTO habilidad (nombre) VALUES ('Programación'), ('Diseño');
INSERT INTO interes (nombre) VALUES ('Proyectos de software'), ('Estudio en equipo'), ('Robótica');

INSERT INTO usuario (correo_institucional, hash_contrasena, nombre, apellidos, numero_control, rol_id, carrera_id, nivel_participacion)
SELECT 'estudiante1@ejemplo.test','hash_ficticio','Estudiante','Uno','20260001',(SELECT id FROM rol WHERE nombre='estudiante'),(SELECT id FROM carrera WHERE nombre='Carrera ficticia A'),4
UNION ALL SELECT 'estudiante2@ejemplo.test','hash_ficticio','Estudiante','Dos','20260002',(SELECT id FROM rol WHERE nombre='estudiante'),(SELECT id FROM carrera WHERE nombre='Carrera ficticia A'),2
UNION ALL SELECT 'estudiante3@ejemplo.test','hash_ficticio','Estudiante','Tres','20260003',(SELECT id FROM rol WHERE nombre='estudiante'),(SELECT id FROM carrera WHERE nombre='Carrera ficticia B'),1
UNION ALL SELECT 'docente1@ejemplo.test','hash_ficticio','Docente','Uno',NULL,(SELECT id FROM rol WHERE nombre='docente'),NULL,4
UNION ALL SELECT 'moderador1@ejemplo.test','hash_ficticio','Moderador','Uno',NULL,(SELECT id FROM rol WHERE nombre='moderador'),NULL,4;
INSERT INTO perfil (usuario_id, descripcion, semestre) SELECT id,'Perfil ficticio',2 FROM usuario WHERE numero_control IS NOT NULL;

INSERT INTO usuario_interes (usuario_id, interes_id)
SELECT u.id, i.id FROM usuario u JOIN interes i ON
 (u.correo_institucional='estudiante1@ejemplo.test' AND i.nombre IN ('Proyectos de software','Estudio en equipo'))
 OR (u.correo_institucional='estudiante2@ejemplo.test' AND i.nombre IN ('Proyectos de software','Robótica'))
 OR (u.correo_institucional='estudiante3@ejemplo.test' AND i.nombre IN ('Robótica'));
INSERT INTO usuario_materia (usuario_id, materia_id, estado)
SELECT u.id, m.id, 'cursando' FROM usuario u CROSS JOIN materia m WHERE u.numero_control IS NOT NULL;

-- Publicaciones: dos preguntas (una anónima), un apunte y un ejercicio
INSERT INTO publicacion (autor_id, tipo_contenido_id, materia_id, tema_id, titulo, descripcion, es_anonima)
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante1@ejemplo.test'),
       (SELECT id FROM tipo_contenido WHERE nombre='pregunta'), m.id, t.id,
       '¿Cómo se calcula una derivada simple?','Tengo duda con las reglas de **derivación**.
```
f(x) = x^2
```', false
FROM materia m JOIN tema t ON t.materia_id=m.id WHERE m.clave='MAT-001'
UNION ALL
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante3@ejemplo.test'),
       (SELECT id FROM tipo_contenido WHERE nombre='pregunta'), m.id, NULL,
       'No entiendo el tema de límites','Me da pena preguntar en clase, ¿alguien me explica?', true
FROM materia m WHERE m.clave='MAT-001'
UNION ALL
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante2@ejemplo.test'),
       (SELECT id FROM tipo_contenido WHERE nombre='apunte'), m.id, t.id,
       'Apuntes de la unidad 1','Resumen de la primera unidad con ejemplos.', false
FROM materia m JOIN tema t ON t.materia_id=m.id WHERE m.clave='MAT-002'
UNION ALL
SELECT (SELECT id FROM usuario WHERE correo_institucional='docente1@ejemplo.test'),
       (SELECT id FROM tipo_contenido WHERE nombre='ejercicio'), m.id, NULL,
       'Ejercicios resueltos paso a paso','Tres ejercicios de práctica con solución.', false
FROM materia m WHERE m.clave='MAT-001';

INSERT INTO publicacion_etiqueta (publicacion_id, etiqueta_id)
SELECT p.id, e.id FROM publicacion p JOIN etiqueta e ON e.nombre='derivadas' WHERE p.titulo LIKE '¿Cómo se calcula%';
INSERT INTO adjunto (publicacion_id, subido_por, tipo, nombre_original, tipo_mime, tamano_bytes, clave_almacenamiento)
SELECT p.id, p.autor_id, 'imagen','captura.png','image/png',20480,'adjuntos/ejemplo/captura.png' FROM publicacion p WHERE p.titulo LIKE '¿Cómo se calcula%';

INSERT INTO seguimiento_publicacion (usuario_id, publicacion_id)
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante2@ejemplo.test'), id FROM publicacion WHERE titulo LIKE '¿Cómo se calcula%';
INSERT INTO guardado (usuario_id, publicacion_id)
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante1@ejemplo.test'), id FROM publicacion WHERE tipo_contenido_id=(SELECT id FROM tipo_contenido WHERE nombre='apunte');
INSERT INTO voto_publicacion (usuario_id, publicacion_id, valor)
SELECT u.id, p.id, 1 FROM usuario u CROSS JOIN publicacion p WHERE u.correo_institucional IN ('estudiante2@ejemplo.test','estudiante1@ejemplo.test') AND p.titulo='Apuntes de la unidad 1';
INSERT INTO historial_consulta (usuario_id, publicacion_id)
SELECT (SELECT id FROM usuario WHERE correo_institucional='estudiante1@ejemplo.test'), id FROM publicacion WHERE titulo='Apuntes de la unidad 1';
INSERT INTO consulta_busqueda (usuario_id, termino, num_resultados, duracion_ms)
SELECT id,'derivadas',1,38 FROM usuario WHERE correo_institucional='estudiante1@ejemplo.test';

-- Una respuesta (dispara aviso al autor) y su aceptación (marca la duda como resuelta y notifica)
INSERT INTO respuesta (publicacion_id, autor_id, contenido)
SELECT p.id,(SELECT id FROM usuario WHERE correo_institucional='docente1@ejemplo.test'),'Aplica la regla de la potencia: la derivada de x^2 es 2x.'
FROM publicacion p WHERE p.titulo LIKE '¿Cómo se calcula%';
UPDATE respuesta SET es_aceptada = true WHERE contenido LIKE 'Aplica la regla%';

-- Extensiones
INSERT INTO verificacion_contenido (respuesta_id, verificador_id, tipo, comentario)
SELECT r.id,(SELECT id FROM usuario WHERE correo_institucional='docente1@ejemplo.test'),'docente','Respuesta correcta.' FROM respuesta r;
COMMIT;
