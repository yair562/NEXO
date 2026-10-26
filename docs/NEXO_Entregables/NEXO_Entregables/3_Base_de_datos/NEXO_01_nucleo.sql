-- =====================================================================
-- NEXO: Comunidad estudiantil digital
-- Base de datos relacional para PostgreSQL 14 o superior (probado en 16)
-- Archivo 1 de 3: módulo NÚCLEO (acceso, perfiles, contenido, búsqueda y participación)
-- Convenciones: nombres en minúsculas y sin acentos (snake_case), claves
-- primarias BIGINT autogeneradas, fechas en TIMESTAMPTZ, textos en TEXT.
-- =====================================================================

BEGIN;

CREATE TABLE rol (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE,
  descripcion TEXT
);
COMMENT ON TABLE rol IS 'Catálogo de roles de usuario.';
COMMENT ON COLUMN rol.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN rol.nombre IS 'Nombre del rol: estudiante, docente, administrativo, moderador o administrador.';
COMMENT ON COLUMN rol.descripcion IS 'Descripción de los permisos del rol.';

CREATE TABLE carrera (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE,
  activa BOOLEAN NOT NULL DEFAULT true
);
COMMENT ON TABLE carrera IS 'Carreras o áreas del TESH.';
COMMENT ON COLUMN carrera.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN carrera.nombre IS 'Nombre de la carrera o área.';
COMMENT ON COLUMN carrera.activa IS 'Indica si la carrera está vigente.';

CREATE TABLE materia (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  clave TEXT UNIQUE,
  nombre TEXT NOT NULL,
  activa BOOLEAN NOT NULL DEFAULT true
);
COMMENT ON TABLE materia IS 'Materias del plan de estudios.';
COMMENT ON COLUMN materia.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN materia.clave IS 'Clave de la materia en el plan de estudios.';
COMMENT ON COLUMN materia.nombre IS 'Nombre de la materia.';
COMMENT ON COLUMN materia.activa IS 'Indica si la materia está vigente.';

CREATE TABLE plan_estudios (
  carrera_id BIGINT NOT NULL REFERENCES carrera(id) ON DELETE CASCADE,
  materia_id BIGINT NOT NULL REFERENCES materia(id) ON DELETE CASCADE,
  semestre SMALLINT NOT NULL CHECK (semestre BETWEEN 1 AND 12),
  PRIMARY KEY (carrera_id, materia_id)
);
COMMENT ON TABLE plan_estudios IS 'Relaciona carreras con materias y su semestre.';
COMMENT ON COLUMN plan_estudios.carrera_id IS 'Carrera.';
COMMENT ON COLUMN plan_estudios.materia_id IS 'Materia.';
COMMENT ON COLUMN plan_estudios.semestre IS 'Semestre en que se cursa la materia (1 a 12).';

CREATE TABLE tema (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  materia_id BIGINT NOT NULL REFERENCES materia(id) ON DELETE CASCADE,
  tema_padre_id BIGINT REFERENCES tema(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  UNIQUE (id, materia_id)
);
CREATE UNIQUE INDEX uq_tema_nombre ON tema (materia_id, COALESCE(tema_padre_id, 0), nombre);
CREATE INDEX ix_tema_materia ON tema (materia_id);
COMMENT ON TABLE tema IS 'Árbol temático de cada materia (temas y subtemas).';
COMMENT ON COLUMN tema.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN tema.materia_id IS 'Materia a la que pertenece el tema.';
COMMENT ON COLUMN tema.tema_padre_id IS 'Tema superior; nulo si es un tema raíz.';
COMMENT ON COLUMN tema.nombre IS 'Nombre del tema.';

CREATE TABLE etiqueta (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE CHECK (nombre = lower(nombre))
);
COMMENT ON TABLE etiqueta IS 'Etiquetas libres para clasificar publicaciones.';
COMMENT ON COLUMN etiqueta.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN etiqueta.nombre IS 'Texto de la etiqueta, siempre en minúsculas.';

CREATE TABLE tipo_contenido (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE,
  descripcion TEXT
);
COMMENT ON TABLE tipo_contenido IS 'Tipos de contenido que se pueden publicar.';
COMMENT ON COLUMN tipo_contenido.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN tipo_contenido.nombre IS 'Tipo: pregunta, apunte, tutorial, ejercicio, proyecto_ejemplo o recurso.';
COMMENT ON COLUMN tipo_contenido.descripcion IS 'Descripción del tipo.';

CREATE TABLE habilidad (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE
);
COMMENT ON TABLE habilidad IS 'Catálogo de habilidades para los perfiles.';
COMMENT ON COLUMN habilidad.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN habilidad.nombre IS 'Nombre de la habilidad.';

CREATE TABLE interes (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE
);
COMMENT ON TABLE interes IS 'Catálogo de intereses académicos o personales.';
COMMENT ON COLUMN interes.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN interes.nombre IS 'Nombre del interés.';

CREATE TABLE usuario (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  correo_institucional TEXT NOT NULL UNIQUE CHECK (correo_institucional ~ '^[^@[:space:]]+@[^@[:space:]]+$'),
  hash_contrasena TEXT,
  nombre TEXT NOT NULL,
  apellidos TEXT NOT NULL,
  numero_control TEXT UNIQUE,
  rol_id BIGINT NOT NULL REFERENCES rol(id),
  carrera_id BIGINT REFERENCES carrera(id),
  nivel_participacion SMALLINT NOT NULL DEFAULT 1 CHECK (nivel_participacion BETWEEN 1 AND 4),
  estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo','suspendido','inactivo')),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  ultimo_acceso_en TIMESTAMPTZ
);
CREATE INDEX ix_usuario_rol ON usuario (rol_id);
CREATE INDEX ix_usuario_carrera ON usuario (carrera_id);
COMMENT ON TABLE usuario IS 'Personas que usan la plataforma.';
COMMENT ON COLUMN usuario.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN usuario.correo_institucional IS 'Correo institucional; sirve como identificador de acceso.';
COMMENT ON COLUMN usuario.hash_contrasena IS 'Hash de la contraseña (nunca en texto plano). Nulo si la autenticación la hace un servicio externo.';
COMMENT ON COLUMN usuario.nombre IS 'Nombre(s).';
COMMENT ON COLUMN usuario.apellidos IS 'Apellidos.';
COMMENT ON COLUMN usuario.numero_control IS 'Número de control del estudiante (solo estudiantes).';
COMMENT ON COLUMN usuario.rol_id IS 'Rol del usuario.';
COMMENT ON COLUMN usuario.carrera_id IS 'Carrera del usuario; nulo si no aplica.';
COMMENT ON COLUMN usuario.nivel_participacion IS 'Participación escalonada: 1 lectura, 2 guardado y voto, 3 comentarios, 4 preguntas.';
COMMENT ON COLUMN usuario.estado IS 'Estado de la cuenta: activo, suspendido o inactivo.';
COMMENT ON COLUMN usuario.creado_en IS 'Fecha de alta.';
COMMENT ON COLUMN usuario.ultimo_acceso_en IS 'Fecha del último acceso.';

CREATE TABLE perfil (
  usuario_id BIGINT PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE,
  descripcion TEXT,
  semestre SMALLINT CHECK (semestre BETWEEN 1 AND 12),
  foto_url TEXT,
  perfil_publico BOOLEAN NOT NULL DEFAULT true,
  actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE perfil IS 'Perfil académico de cada usuario (1 a 1 con usuario).';
COMMENT ON COLUMN perfil.usuario_id IS 'Usuario dueño del perfil.';
COMMENT ON COLUMN perfil.descripcion IS 'Presentación breve del usuario.';
COMMENT ON COLUMN perfil.semestre IS 'Semestre actual.';
COMMENT ON COLUMN perfil.foto_url IS 'Ubicación de la foto de perfil.';
COMMENT ON COLUMN perfil.perfil_publico IS 'Si es falso, el perfil solo lo ven los moderadores.';
COMMENT ON COLUMN perfil.actualizado_en IS 'Última modificación.';

CREATE TABLE usuario_materia (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  materia_id BIGINT NOT NULL REFERENCES materia(id) ON DELETE CASCADE,
  estado TEXT NOT NULL CHECK (estado IN ('cursando','cursada')),
  PRIMARY KEY (usuario_id, materia_id)
);
COMMENT ON TABLE usuario_materia IS 'Materias que el usuario cursa o ya cursó.';
COMMENT ON COLUMN usuario_materia.usuario_id IS 'Usuario.';
COMMENT ON COLUMN usuario_materia.materia_id IS 'Materia.';
COMMENT ON COLUMN usuario_materia.estado IS 'Cursando o cursada.';

CREATE TABLE usuario_habilidad (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  habilidad_id BIGINT NOT NULL REFERENCES habilidad(id) ON DELETE CASCADE,
  nivel TEXT CHECK (nivel IN ('basico','intermedio','avanzado')),
  PRIMARY KEY (usuario_id, habilidad_id)
);
CREATE INDEX ix_usuario_habilidad_hab ON usuario_habilidad (habilidad_id);
COMMENT ON TABLE usuario_habilidad IS 'Habilidades declaradas por el usuario.';
COMMENT ON COLUMN usuario_habilidad.usuario_id IS 'Usuario.';
COMMENT ON COLUMN usuario_habilidad.habilidad_id IS 'Habilidad.';
COMMENT ON COLUMN usuario_habilidad.nivel IS 'Nivel declarado; opcional.';

CREATE TABLE usuario_interes (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  interes_id BIGINT NOT NULL REFERENCES interes(id) ON DELETE CASCADE,
  PRIMARY KEY (usuario_id, interes_id)
);
CREATE INDEX ix_usuario_interes_int ON usuario_interes (interes_id);
COMMENT ON TABLE usuario_interes IS 'Intereses declarados por el usuario.';
COMMENT ON COLUMN usuario_interes.usuario_id IS 'Usuario.';
COMMENT ON COLUMN usuario_interes.interes_id IS 'Interés.';

CREATE TABLE publicacion (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  autor_id BIGINT NOT NULL REFERENCES usuario(id),
  tipo_contenido_id BIGINT NOT NULL REFERENCES tipo_contenido(id),
  materia_id BIGINT NOT NULL REFERENCES materia(id),
  tema_id BIGINT REFERENCES tema(id),
  titulo TEXT NOT NULL CHECK (char_length(titulo) BETWEEN 5 AND 200),
  descripcion TEXT NOT NULL,
  estado TEXT NOT NULL DEFAULT 'abierta' CHECK (estado IN ('abierta','resuelta','cerrada','oculta')),
  es_anonima BOOLEAN NOT NULL DEFAULT false,
  vistas INTEGER NOT NULL DEFAULT 0 CHECK (vistas >= 0),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  search_vector TSVECTOR GENERATED ALWAYS AS (setweight(to_tsvector('spanish', coalesce(titulo,'')),'A') || setweight(to_tsvector('spanish', coalesce(descripcion,'')),'B')) STORED,
  FOREIGN KEY (tema_id, materia_id) REFERENCES tema (id, materia_id)
);
CREATE INDEX ix_publicacion_materia_tema ON publicacion (materia_id, tema_id);
CREATE INDEX ix_publicacion_tipo ON publicacion (tipo_contenido_id);
CREATE INDEX ix_publicacion_autor ON publicacion (autor_id);
CREATE INDEX ix_publicacion_estado_fecha ON publicacion (estado, creado_en DESC);
CREATE INDEX ix_publicacion_busqueda ON publicacion USING GIN (search_vector);
COMMENT ON TABLE publicacion IS 'Preguntas y recursos (apuntes, tutoriales, ejercicios, etc.).';
COMMENT ON COLUMN publicacion.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN publicacion.autor_id IS 'Autor de la publicación.';
COMMENT ON COLUMN publicacion.tipo_contenido_id IS 'Tipo de contenido.';
COMMENT ON COLUMN publicacion.materia_id IS 'Materia a la que pertenece.';
COMMENT ON COLUMN publicacion.tema_id IS 'Tema dentro de la materia (debe pertenecer a la misma materia).';
COMMENT ON COLUMN publicacion.titulo IS 'Título (5 a 200 caracteres).';
COMMENT ON COLUMN publicacion.descripcion IS 'Contenido en formato Markdown; admite bloques de código.';
COMMENT ON COLUMN publicacion.estado IS 'Estado: abierta, resuelta, cerrada u oculta (por moderación).';
COMMENT ON COLUMN publicacion.es_anonima IS 'Publicación resguardada: oculta la identidad del autor al público.';
COMMENT ON COLUMN publicacion.vistas IS 'Número de consultas.';
COMMENT ON COLUMN publicacion.creado_en IS 'Fecha de creación.';
COMMENT ON COLUMN publicacion.actualizado_en IS 'Última modificación.';
COMMENT ON COLUMN publicacion.search_vector IS 'Índice de búsqueda de texto completo (título y descripción), calculado automáticamente.';

CREATE TABLE publicacion_etiqueta (
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  etiqueta_id BIGINT NOT NULL REFERENCES etiqueta(id) ON DELETE CASCADE,
  PRIMARY KEY (publicacion_id, etiqueta_id)
);
CREATE INDEX ix_pub_etiqueta_etiqueta ON publicacion_etiqueta (etiqueta_id);
COMMENT ON TABLE publicacion_etiqueta IS 'Etiquetas asignadas a cada publicación.';
COMMENT ON COLUMN publicacion_etiqueta.publicacion_id IS 'Publicación.';
COMMENT ON COLUMN publicacion_etiqueta.etiqueta_id IS 'Etiqueta.';

CREATE TABLE respuesta (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  autor_id BIGINT NOT NULL REFERENCES usuario(id),
  contenido TEXT NOT NULL,
  es_anonima BOOLEAN NOT NULL DEFAULT false,
  es_aceptada BOOLEAN NOT NULL DEFAULT false,
  estado TEXT NOT NULL DEFAULT 'visible' CHECK (estado IN ('visible','oculta')),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  search_vector TSVECTOR GENERATED ALWAYS AS (to_tsvector('spanish', coalesce(contenido,''))) STORED
);
CREATE INDEX ix_respuesta_publicacion ON respuesta (publicacion_id);
CREATE INDEX ix_respuesta_autor ON respuesta (autor_id);
CREATE UNIQUE INDEX uq_respuesta_aceptada ON respuesta (publicacion_id) WHERE es_aceptada;
CREATE INDEX ix_respuesta_busqueda ON respuesta USING GIN (search_vector);
COMMENT ON TABLE respuesta IS 'Respuestas a una pregunta o publicación.';
COMMENT ON COLUMN respuesta.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN respuesta.publicacion_id IS 'Publicación que se responde.';
COMMENT ON COLUMN respuesta.autor_id IS 'Autor de la respuesta.';
COMMENT ON COLUMN respuesta.contenido IS 'Contenido en formato Markdown.';
COMMENT ON COLUMN respuesta.es_anonima IS 'Respuesta resguardada: oculta la identidad del autor.';
COMMENT ON COLUMN respuesta.es_aceptada IS 'Marca la respuesta que resolvió la duda (solo una por publicación).';
COMMENT ON COLUMN respuesta.estado IS 'Visible u oculta (por moderación).';
COMMENT ON COLUMN respuesta.creado_en IS 'Fecha de creación.';
COMMENT ON COLUMN respuesta.actualizado_en IS 'Última modificación.';
COMMENT ON COLUMN respuesta.search_vector IS 'Índice de búsqueda de texto completo, calculado automáticamente.';

CREATE TABLE comentario (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE CASCADE,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE CASCADE,
  autor_id BIGINT NOT NULL REFERENCES usuario(id),
  contenido TEXT NOT NULL,
  es_anonima BOOLEAN NOT NULL DEFAULT false,
  estado TEXT NOT NULL DEFAULT 'visible' CHECK (estado IN ('visible','oculta')),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((publicacion_id IS NOT NULL)::int + (respuesta_id IS NOT NULL)::int = 1)
);
CREATE INDEX ix_comentario_publicacion ON comentario (publicacion_id);
CREATE INDEX ix_comentario_respuesta ON comentario (respuesta_id);
COMMENT ON TABLE comentario IS 'Comentarios sobre una publicación o una respuesta.';
COMMENT ON COLUMN comentario.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN comentario.publicacion_id IS 'Publicación comentada (si el comentario es sobre la publicación).';
COMMENT ON COLUMN comentario.respuesta_id IS 'Respuesta comentada (si el comentario es sobre una respuesta).';
COMMENT ON COLUMN comentario.autor_id IS 'Autor del comentario.';
COMMENT ON COLUMN comentario.contenido IS 'Texto del comentario.';
COMMENT ON COLUMN comentario.es_anonima IS 'Comentario resguardado.';
COMMENT ON COLUMN comentario.estado IS 'Visible u oculto.';
COMMENT ON COLUMN comentario.creado_en IS 'Fecha de creación.';

CREATE TABLE adjunto (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE CASCADE,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE CASCADE,
  subido_por BIGINT NOT NULL REFERENCES usuario(id),
  tipo TEXT NOT NULL CHECK (tipo IN ('imagen','archivo')),
  nombre_original TEXT NOT NULL,
  tipo_mime TEXT NOT NULL,
  tamano_bytes BIGINT NOT NULL CHECK (tamano_bytes > 0),
  clave_almacenamiento TEXT NOT NULL UNIQUE,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((publicacion_id IS NOT NULL)::int + (respuesta_id IS NOT NULL)::int = 1)
);
CREATE INDEX ix_adjunto_publicacion ON adjunto (publicacion_id);
CREATE INDEX ix_adjunto_respuesta ON adjunto (respuesta_id);
COMMENT ON TABLE adjunto IS 'Imágenes y archivos adjuntos a publicaciones o respuestas.';
COMMENT ON COLUMN adjunto.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN adjunto.publicacion_id IS 'Publicación a la que se adjunta.';
COMMENT ON COLUMN adjunto.respuesta_id IS 'Respuesta a la que se adjunta.';
COMMENT ON COLUMN adjunto.subido_por IS 'Usuario que subió el archivo.';
COMMENT ON COLUMN adjunto.tipo IS 'Imagen o archivo.';
COMMENT ON COLUMN adjunto.nombre_original IS 'Nombre original del archivo.';
COMMENT ON COLUMN adjunto.tipo_mime IS 'Tipo MIME (por ejemplo, image/png).';
COMMENT ON COLUMN adjunto.tamano_bytes IS 'Tamaño en bytes.';
COMMENT ON COLUMN adjunto.clave_almacenamiento IS 'Ruta o clave del archivo en el almacenamiento externo (el archivo no se guarda en la base).';
COMMENT ON COLUMN adjunto.creado_en IS 'Fecha de subida.';

CREATE TABLE voto_publicacion (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  valor SMALLINT NOT NULL CHECK (valor IN (-1, 1)),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (usuario_id, publicacion_id)
);
CREATE INDEX ix_voto_pub_publicacion ON voto_publicacion (publicacion_id);
COMMENT ON TABLE voto_publicacion IS 'Votos de los usuarios sobre publicaciones.';
COMMENT ON COLUMN voto_publicacion.usuario_id IS 'Usuario que vota.';
COMMENT ON COLUMN voto_publicacion.publicacion_id IS 'Publicación votada.';
COMMENT ON COLUMN voto_publicacion.valor IS '+1 (útil) o -1 (no útil).';
COMMENT ON COLUMN voto_publicacion.creado_en IS 'Fecha del voto.';

CREATE TABLE voto_respuesta (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  respuesta_id BIGINT NOT NULL REFERENCES respuesta(id) ON DELETE CASCADE,
  valor SMALLINT NOT NULL CHECK (valor IN (-1, 1)),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (usuario_id, respuesta_id)
);
CREATE INDEX ix_voto_resp_respuesta ON voto_respuesta (respuesta_id);
COMMENT ON TABLE voto_respuesta IS 'Votos de los usuarios sobre respuestas.';
COMMENT ON COLUMN voto_respuesta.usuario_id IS 'Usuario que vota.';
COMMENT ON COLUMN voto_respuesta.respuesta_id IS 'Respuesta votada.';
COMMENT ON COLUMN voto_respuesta.valor IS '+1 (útil) o -1 (no útil).';
COMMENT ON COLUMN voto_respuesta.creado_en IS 'Fecha del voto.';

CREATE TABLE guardado (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (usuario_id, publicacion_id)
);
CREATE INDEX ix_guardado_usuario_fecha ON guardado (usuario_id, creado_en DESC);
COMMENT ON TABLE guardado IS 'Publicaciones guardadas como marcadores.';
COMMENT ON COLUMN guardado.usuario_id IS 'Usuario que guarda.';
COMMENT ON COLUMN guardado.publicacion_id IS 'Publicación guardada.';
COMMENT ON COLUMN guardado.creado_en IS 'Fecha en que se guardó.';

CREATE TABLE historial_consulta (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  consultada_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ix_historial_usuario_fecha ON historial_consulta (usuario_id, consultada_en DESC);
COMMENT ON TABLE historial_consulta IS 'Historial de publicaciones consultadas por cada usuario.';
COMMENT ON COLUMN historial_consulta.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN historial_consulta.usuario_id IS 'Usuario que consulta.';
COMMENT ON COLUMN historial_consulta.publicacion_id IS 'Publicación consultada.';
COMMENT ON COLUMN historial_consulta.consultada_en IS 'Fecha y hora de la consulta.';

CREATE TABLE seguimiento_publicacion (
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (usuario_id, publicacion_id)
);
CREATE INDEX ix_seguimiento_publicacion ON seguimiento_publicacion (publicacion_id);
COMMENT ON TABLE seguimiento_publicacion IS 'Usuarios que siguen una publicación para recibir avisos.';
COMMENT ON COLUMN seguimiento_publicacion.usuario_id IS 'Usuario que sigue.';
COMMENT ON COLUMN seguimiento_publicacion.publicacion_id IS 'Publicación seguida.';
COMMENT ON COLUMN seguimiento_publicacion.creado_en IS 'Fecha en que empezó a seguirla.';

CREATE TABLE notificacion (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL CHECK (tipo IN ('duda_resuelta','respuesta_nueva','comentario_nuevo','verificacion','moderacion')),
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE CASCADE,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE CASCADE,
  mensaje TEXT NOT NULL,
  leida BOOLEAN NOT NULL DEFAULT false,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  leida_en TIMESTAMPTZ
);
CREATE INDEX ix_notificacion_usuario ON notificacion (usuario_id, leida, creado_en DESC);
COMMENT ON TABLE notificacion IS 'Avisos para los usuarios (por ejemplo, duda resuelta).';
COMMENT ON COLUMN notificacion.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN notificacion.usuario_id IS 'Usuario destinatario.';
COMMENT ON COLUMN notificacion.tipo IS 'Tipo de aviso.';
COMMENT ON COLUMN notificacion.publicacion_id IS 'Publicación relacionada.';
COMMENT ON COLUMN notificacion.respuesta_id IS 'Respuesta relacionada.';
COMMENT ON COLUMN notificacion.mensaje IS 'Texto del aviso.';
COMMENT ON COLUMN notificacion.leida IS 'Indica si el usuario ya lo leyó.';
COMMENT ON COLUMN notificacion.creado_en IS 'Fecha del aviso.';
COMMENT ON COLUMN notificacion.leida_en IS 'Fecha de lectura.';

CREATE TABLE consulta_busqueda (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT REFERENCES usuario(id) ON DELETE SET NULL,
  termino TEXT NOT NULL,
  filtros JSONB,
  num_resultados INTEGER CHECK (num_resultados >= 0),
  duracion_ms INTEGER CHECK (duracion_ms >= 0),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ix_consulta_busqueda_fecha ON consulta_busqueda (creado_en);
COMMENT ON TABLE consulta_busqueda IS 'Registro de búsquedas, para medir el tiempo de consulta.';
COMMENT ON COLUMN consulta_busqueda.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN consulta_busqueda.usuario_id IS 'Usuario que busca; nulo si se anonimizó.';
COMMENT ON COLUMN consulta_busqueda.termino IS 'Texto buscado.';
COMMENT ON COLUMN consulta_busqueda.filtros IS 'Filtros aplicados (materia, tipo, etiqueta).';
COMMENT ON COLUMN consulta_busqueda.num_resultados IS 'Cantidad de resultados devueltos.';
COMMENT ON COLUMN consulta_busqueda.duracion_ms IS 'Tiempo de respuesta en milisegundos.';
COMMENT ON COLUMN consulta_busqueda.creado_en IS 'Fecha y hora de la búsqueda.';

CREATE TABLE bitacora_auditoria (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT REFERENCES usuario(id) ON DELETE SET NULL,
  accion TEXT NOT NULL,
  entidad TEXT,
  entidad_id BIGINT,
  detalle JSONB,
  direccion_ip INET,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ix_bitacora_fecha ON bitacora_auditoria (creado_en);
CREATE INDEX ix_bitacora_usuario ON bitacora_auditoria (usuario_id);
COMMENT ON TABLE bitacora_auditoria IS 'Bitácora de acciones sensibles (seguridad y trazabilidad).';
COMMENT ON COLUMN bitacora_auditoria.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN bitacora_auditoria.usuario_id IS 'Usuario que realizó la acción.';
COMMENT ON COLUMN bitacora_auditoria.accion IS 'Acción realizada (por ejemplo, inicio_sesion, cambio_rol).';
COMMENT ON COLUMN bitacora_auditoria.entidad IS 'Tabla o entidad afectada.';
COMMENT ON COLUMN bitacora_auditoria.entidad_id IS 'Identificador del registro afectado.';
COMMENT ON COLUMN bitacora_auditoria.detalle IS 'Datos adicionales de la acción.';
COMMENT ON COLUMN bitacora_auditoria.direccion_ip IS 'Dirección IP de origen.';
COMMENT ON COLUMN bitacora_auditoria.creado_en IS 'Fecha y hora de la acción.';

-- ---------------------------------------------------------------------
-- Funciones y disparadores
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_actualizado_en() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  NEW.actualizado_en := now();
  RETURN NEW;
END $$;
CREATE TRIGGER tg_publicacion_actualizado BEFORE UPDATE ON publicacion FOR EACH ROW EXECUTE FUNCTION fn_actualizado_en();
CREATE TRIGGER tg_respuesta_actualizado   BEFORE UPDATE ON respuesta   FOR EACH ROW EXECUTE FUNCTION fn_actualizado_en();
CREATE TRIGGER tg_perfil_actualizado      BEFORE UPDATE ON perfil      FOR EACH ROW EXECUTE FUNCTION fn_actualizado_en();

-- RC-13: avisar al autor cuando alguien responde su publicación
CREATE FUNCTION fn_respuesta_nueva() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO notificacion (usuario_id, tipo, publicacion_id, respuesta_id, mensaje)
  SELECT p.autor_id, 'respuesta_nueva', p.id, NEW.id, 'Tu publicación recibió una respuesta nueva.'
  FROM publicacion p
  WHERE p.id = NEW.publicacion_id AND p.autor_id <> NEW.autor_id;
  RETURN NEW;
END $$;
CREATE TRIGGER tg_respuesta_nueva AFTER INSERT ON respuesta FOR EACH ROW EXECUTE FUNCTION fn_respuesta_nueva();

-- RC-13: al aceptar una respuesta, marcar la duda como resuelta y notificar
CREATE FUNCTION fn_respuesta_aceptada() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  UPDATE publicacion SET estado = 'resuelta'
  WHERE id = NEW.publicacion_id AND estado = 'abierta';
  INSERT INTO notificacion (usuario_id, tipo, publicacion_id, respuesta_id, mensaje)
  SELECT DISTINCT x.usuario_id, 'duda_resuelta', NEW.publicacion_id, NEW.id, 'Una duda que sigues fue marcada como resuelta.'
  FROM (SELECT autor_id AS usuario_id FROM publicacion WHERE id = NEW.publicacion_id
        UNION
        SELECT usuario_id FROM seguimiento_publicacion WHERE publicacion_id = NEW.publicacion_id) x;
  RETURN NEW;
END $$;
CREATE TRIGGER tg_respuesta_aceptada AFTER UPDATE OF es_aceptada ON respuesta
  FOR EACH ROW WHEN (NEW.es_aceptada AND NOT OLD.es_aceptada) EXECUTE FUNCTION fn_respuesta_aceptada();

-- ---------------------------------------------------------------------
-- Vistas
-- ---------------------------------------------------------------------
-- Publicaciones visibles al público: oculta la identidad si es anónima (RC-08)
CREATE VIEW v_publicacion_publica AS
SELECT p.id,
       CASE WHEN p.es_anonima THEN NULL ELSE p.autor_id END AS autor_id,
       p.tipo_contenido_id, tc.nombre AS tipo,
       p.materia_id, m.nombre AS materia, p.tema_id,
       p.titulo, p.descripcion, p.estado, p.vistas, p.creado_en,
       COALESCE((SELECT SUM(v.valor) FROM voto_publicacion v WHERE v.publicacion_id = p.id), 0) AS puntuacion,
       (SELECT COUNT(*) FROM respuesta r WHERE r.publicacion_id = p.id AND r.estado = 'visible') AS num_respuestas
FROM publicacion p
JOIN tipo_contenido tc ON tc.id = p.tipo_contenido_id
JOIN materia m ON m.id = p.materia_id
WHERE p.estado <> 'oculta';

-- Catálogo de recursos de estudio con filtros por materia y tipo (RC-09)
CREATE VIEW v_catalogo_recursos AS
SELECT * FROM v_publicacion_publica WHERE tipo <> 'pregunta';

-- Panel de recursos guardados recientemente (RC-04)
CREATE VIEW v_guardados_recientes AS
SELECT g.usuario_id, p.id AS publicacion_id, p.titulo, p.materia_id, g.creado_en AS guardado_en
FROM guardado g JOIN publicacion p ON p.id = g.publicacion_id
WHERE p.estado <> 'oculta';

-- ---------------------------------------------------------------------
-- Datos iniciales de los catálogos
-- ---------------------------------------------------------------------
INSERT INTO rol (nombre, descripcion) VALUES
 ('estudiante','Usuario principal: consulta, pregunta, responde y comparte recursos.'),
 ('docente','Responde dudas y verifica contenidos.'),
 ('administrativo','Personal administrativo de la institución.'),
 ('moderador','Revisa reportes y modera el contenido.'),
 ('administrador','Administra la plataforma y los catálogos.');
INSERT INTO tipo_contenido (nombre, descripcion) VALUES
 ('pregunta','Duda académica abierta a respuestas.'),
 ('apunte','Apuntes de clase.'),
 ('tutorial','Guía paso a paso.'),
 ('ejercicio','Ejercicio o problema resuelto.'),
 ('proyecto_ejemplo','Proyecto o ejemplo de referencia.'),
 ('recurso','Otro recurso de estudio.');

COMMIT;
