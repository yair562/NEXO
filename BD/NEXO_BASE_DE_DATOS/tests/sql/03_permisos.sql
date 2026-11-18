-- Verifica el modelo de mínimo privilegio cambiando de rol con SET ROLE. Se ejecuta como superusuario.
-- Todo se revierte al final.
BEGIN;

-- En public (no en pg_temp) para que los demás roles puedan ejecutarla; desaparece con el ROLLBACK.
CREATE FUNCTION public.debe_fallar(sentencia text, descripcion text) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
    EXECUTE sentencia;
    RAISE EXCEPTION 'Se permitió: % (%)', descripcion, sentencia;
EXCEPTION WHEN insufficient_privilege THEN NULL;
END;
$$;

-- nexo_app: lo que la app necesita, nada más
SET LOCAL ROLE nexo_app;
SELECT count(*) FROM nexo.usuarios;
INSERT INTO nexo.usuarios (nombre, correo, contrasena_hash) VALUES ('Permiso', 'permiso@prueba.test', 'x');
SELECT lastval();
SELECT public.debe_fallar('INSERT INTO nexo.materias (nombre, carrera, semestre) VALUES (''x'', ''y'', 1)', 'app escribe el catálogo');
SELECT public.debe_fallar('DELETE FROM nexo.usuarios', 'app borra usuarios');
SELECT public.debe_fallar('SELECT * FROM nexo_meta.schema_migrations', 'app lee el historial');
SELECT public.debe_fallar('CREATE TABLE nexo.intrusa (id int)', 'app crea tablas');
SELECT public.debe_fallar('DROP TABLE nexo.votos', 'app borra tablas');
-- Identidad (V005): el backend Flask lee el padrón, crea cuentas pendientes y activaciones y las actualiza
INSERT INTO nexo.padron_estudiantes (matricula, nombre, correo) VALUES ('20259999', 'Permiso', 'l20259999@huixquilucan.tecnm.mx');
SELECT nombre FROM nexo.padron_estudiantes WHERE matricula = '20259999';
UPDATE nexo.padron_estudiantes SET autorizado = FALSE WHERE matricula = '20259999';
INSERT INTO nexo.usuarios (nombre, correo, matricula, estado) VALUES ('Pendiente', 'l20259999@prueba.test', '20259999', 'PENDING');
INSERT INTO nexo.activaciones (usuario_id, codigo_hash, expira_en)
SELECT id, repeat('b', 64), now() + interval '15 minutes' FROM nexo.usuarios WHERE matricula = '20259999';
SELECT id FROM nexo.activaciones WHERE codigo_hash = repeat('b', 64) FOR UPDATE;
UPDATE nexo.activaciones SET intentos = intentos + 1 WHERE codigo_hash = repeat('b', 64);
SELECT public.debe_fallar('DELETE FROM nexo.padron_estudiantes', 'app borra el padrón');
SELECT public.debe_fallar('DELETE FROM nexo.activaciones', 'app borra activaciones');
RESET ROLE;

-- web_anon: solo el catálogo
SET LOCAL ROLE web_anon;
SELECT count(*) FROM api.materias;
SELECT public.debe_fallar('SELECT * FROM api.publicaciones', 'anónimo lee publicaciones');
SELECT public.debe_fallar('SELECT * FROM nexo.usuarios', 'anónimo lee usuarios');
SELECT public.debe_fallar('INSERT INTO api.materias (nombre, carrera, semestre) VALUES (''x'', ''y'', 1)', 'anónimo escribe');
RESET ROLE;

-- nexo_lector: vistas de la API, nunca las tablas
SET LOCAL ROLE nexo_lector;
SELECT count(*) FROM api.publicaciones;
SELECT count(*) FROM api.comentarios;
SELECT public.debe_fallar('SELECT correo FROM nexo.usuarios', 'lector lee correos');
SELECT public.debe_fallar('DELETE FROM api.materias', 'lector borra');
RESET ROLE;

-- authenticator: no hereda permisos de los roles a los que puede cambiar
SET LOCAL ROLE authenticator;
SELECT public.debe_fallar('SELECT * FROM api.materias', 'authenticator lee sin cambiar de rol');
RESET ROLE;

-- La vista no revela al autor de lo resguardado
INSERT INTO nexo.publicaciones (usuario_id, titulo, contenido, resguardada)
SELECT id, 'Secreta', 'Contenido resguardado', TRUE FROM nexo.usuarios WHERE correo = 'permiso@prueba.test';
DO $$
BEGIN
    PERFORM 1 FROM api.publicaciones WHERE titulo = 'Secreta' AND autor = 'Estudiante resguardado' AND autor_id IS NULL;
    IF NOT FOUND THEN RAISE EXCEPTION 'api.publicaciones revela al autor resguardado'; END IF;
    RAISE NOTICE 'permisos: OK';
END;
$$;

ROLLBACK;
