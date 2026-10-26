-- =====================================================================
-- NEXO: Comunidad estudiantil digital
-- Base de datos relacional para PostgreSQL 14 o superior (probado en 16)
-- Archivo 2 de 3: módulos de EXTENSIÓN (verificación y moderación, espacios, equipos, IA y seguimiento). Requiere el archivo 1.
-- Convenciones: nombres en minúsculas y sin acentos (snake_case), claves
-- primarias BIGINT autogeneradas, fechas en TIMESTAMPTZ, textos en TEXT.
-- =====================================================================

BEGIN;

CREATE TABLE verificacion_contenido (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE CASCADE,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE CASCADE,
  verificador_id BIGINT NOT NULL REFERENCES usuario(id),
  tipo TEXT NOT NULL CHECK (tipo IN ('docente','moderador')),
  comentario TEXT,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((publicacion_id IS NOT NULL)::int + (respuesta_id IS NOT NULL)::int = 1)
);
CREATE UNIQUE INDEX uq_verif_publicacion ON verificacion_contenido (publicacion_id, verificador_id) WHERE publicacion_id IS NOT NULL;
CREATE UNIQUE INDEX uq_verif_respuesta ON verificacion_contenido (respuesta_id, verificador_id) WHERE respuesta_id IS NOT NULL;
COMMENT ON TABLE verificacion_contenido IS 'Verificación de publicaciones o respuestas por docentes o moderadores.';
COMMENT ON COLUMN verificacion_contenido.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN verificacion_contenido.publicacion_id IS 'Publicación verificada.';
COMMENT ON COLUMN verificacion_contenido.respuesta_id IS 'Respuesta verificada.';
COMMENT ON COLUMN verificacion_contenido.verificador_id IS 'Docente o moderador que verifica.';
COMMENT ON COLUMN verificacion_contenido.tipo IS 'Tipo de verificador.';
COMMENT ON COLUMN verificacion_contenido.comentario IS 'Observación del verificador.';
COMMENT ON COLUMN verificacion_contenido.creado_en IS 'Fecha de la verificación.';

CREATE TABLE reporte (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  reportante_id BIGINT NOT NULL REFERENCES usuario(id),
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE CASCADE,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE CASCADE,
  comentario_id BIGINT REFERENCES comentario(id) ON DELETE CASCADE,
  motivo TEXT NOT NULL CHECK (motivo IN ('inexacto','ofensivo','spam','derechos_de_autor','otro')),
  detalle TEXT,
  estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente','revisado','desestimado')),
  resuelto_por BIGINT REFERENCES usuario(id),
  resuelto_en TIMESTAMPTZ,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((publicacion_id IS NOT NULL)::int + (respuesta_id IS NOT NULL)::int + (comentario_id IS NOT NULL)::int = 1)
);
CREATE INDEX ix_reporte_estado ON reporte (estado, creado_en);
COMMENT ON TABLE reporte IS 'Reportes de contenido hechos por los usuarios.';
COMMENT ON COLUMN reporte.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN reporte.reportante_id IS 'Usuario que reporta.';
COMMENT ON COLUMN reporte.publicacion_id IS 'Publicación reportada.';
COMMENT ON COLUMN reporte.respuesta_id IS 'Respuesta reportada.';
COMMENT ON COLUMN reporte.comentario_id IS 'Comentario reportado.';
COMMENT ON COLUMN reporte.motivo IS 'Motivo del reporte.';
COMMENT ON COLUMN reporte.detalle IS 'Explicación del reportante.';
COMMENT ON COLUMN reporte.estado IS 'Estado del reporte.';
COMMENT ON COLUMN reporte.resuelto_por IS 'Moderador que lo resolvió.';
COMMENT ON COLUMN reporte.resuelto_en IS 'Fecha de resolución.';
COMMENT ON COLUMN reporte.creado_en IS 'Fecha del reporte.';

CREATE TABLE accion_moderacion (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  moderador_id BIGINT NOT NULL REFERENCES usuario(id),
  reporte_id BIGINT REFERENCES reporte(id) ON DELETE SET NULL,
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE SET NULL,
  respuesta_id BIGINT REFERENCES respuesta(id) ON DELETE SET NULL,
  usuario_afectado_id BIGINT REFERENCES usuario(id) ON DELETE SET NULL,
  accion TEXT NOT NULL CHECK (accion IN ('ocultar','restaurar','advertir','suspender_usuario','reactivar_usuario')),
  motivo TEXT NOT NULL,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE accion_moderacion IS 'Acciones de moderación aplicadas.';
COMMENT ON COLUMN accion_moderacion.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN accion_moderacion.moderador_id IS 'Moderador que actúa.';
COMMENT ON COLUMN accion_moderacion.reporte_id IS 'Reporte que originó la acción, si existe.';
COMMENT ON COLUMN accion_moderacion.publicacion_id IS 'Publicación afectada.';
COMMENT ON COLUMN accion_moderacion.respuesta_id IS 'Respuesta afectada.';
COMMENT ON COLUMN accion_moderacion.usuario_afectado_id IS 'Usuario afectado.';
COMMENT ON COLUMN accion_moderacion.accion IS 'Acción aplicada.';
COMMENT ON COLUMN accion_moderacion.motivo IS 'Justificación de la acción.';
COMMENT ON COLUMN accion_moderacion.creado_en IS 'Fecha de la acción.';

CREATE TABLE espacio (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  tipo TEXT NOT NULL CHECK (tipo IN ('tematico','proyecto')),
  materia_id BIGINT REFERENCES materia(id),
  visibilidad TEXT NOT NULL DEFAULT 'publico' CHECK (visibilidad IN ('publico','privado')),
  creado_por BIGINT NOT NULL REFERENCES usuario(id),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE espacio IS 'Espacios temáticos o de proyecto para colaborar.';
COMMENT ON COLUMN espacio.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN espacio.nombre IS 'Nombre del espacio.';
COMMENT ON COLUMN espacio.descripcion IS 'Descripción del espacio.';
COMMENT ON COLUMN espacio.tipo IS 'Temático o ligado a un proyecto.';
COMMENT ON COLUMN espacio.materia_id IS 'Materia relacionada, si aplica.';
COMMENT ON COLUMN espacio.visibilidad IS 'Público o privado.';
COMMENT ON COLUMN espacio.creado_por IS 'Usuario que lo creó.';
COMMENT ON COLUMN espacio.creado_en IS 'Fecha de creación.';

-- Publicaciones dentro de un espacio (RC-06)
ALTER TABLE publicacion ADD COLUMN espacio_id BIGINT REFERENCES espacio(id) ON DELETE SET NULL;
COMMENT ON COLUMN publicacion.espacio_id IS 'Espacio en el que se publicó; nulo si es una publicación general.';
CREATE INDEX ix_publicacion_espacio ON publicacion (espacio_id);

CREATE TABLE espacio_miembro (
  espacio_id BIGINT NOT NULL REFERENCES espacio(id) ON DELETE CASCADE,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  rol TEXT NOT NULL DEFAULT 'miembro' CHECK (rol IN ('miembro','coordinador')),
  unido_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (espacio_id, usuario_id)
);
COMMENT ON TABLE espacio_miembro IS 'Miembros de cada espacio.';
COMMENT ON COLUMN espacio_miembro.espacio_id IS 'Espacio.';
COMMENT ON COLUMN espacio_miembro.usuario_id IS 'Usuario miembro.';
COMMENT ON COLUMN espacio_miembro.rol IS 'Rol dentro del espacio.';
COMMENT ON COLUMN espacio_miembro.unido_en IS 'Fecha en que se unió.';

CREATE TABLE equipo (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  tipo TEXT NOT NULL CHECK (tipo IN ('trabajo','estudio')),
  materia_id BIGINT REFERENCES materia(id),
  espacio_id BIGINT REFERENCES espacio(id) ON DELETE SET NULL,
  cupo_maximo SMALLINT CHECK (cupo_maximo >= 2),
  estado TEXT NOT NULL DEFAULT 'abierto' CHECK (estado IN ('abierto','cerrado')),
  creado_por BIGINT NOT NULL REFERENCES usuario(id),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE equipo IS 'Equipos de trabajo o de estudio.';
COMMENT ON COLUMN equipo.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN equipo.nombre IS 'Nombre del equipo.';
COMMENT ON COLUMN equipo.descripcion IS 'Objetivo del equipo.';
COMMENT ON COLUMN equipo.tipo IS 'Equipo de trabajo o de estudio.';
COMMENT ON COLUMN equipo.materia_id IS 'Materia relacionada, si aplica.';
COMMENT ON COLUMN equipo.espacio_id IS 'Espacio en el que se formó, si aplica.';
COMMENT ON COLUMN equipo.cupo_maximo IS 'Número máximo de integrantes; nulo si no hay límite.';
COMMENT ON COLUMN equipo.estado IS 'Abierto o cerrado a nuevas solicitudes.';
COMMENT ON COLUMN equipo.creado_por IS 'Usuario que lo creó.';
COMMENT ON COLUMN equipo.creado_en IS 'Fecha de creación.';

CREATE TABLE equipo_miembro (
  equipo_id BIGINT NOT NULL REFERENCES equipo(id) ON DELETE CASCADE,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  rol TEXT NOT NULL DEFAULT 'integrante' CHECK (rol IN ('integrante','coordinador')),
  estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente','aceptado','rechazado')),
  solicitado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (equipo_id, usuario_id)
);
COMMENT ON TABLE equipo_miembro IS 'Integrantes y solicitudes de unión a cada equipo.';
COMMENT ON COLUMN equipo_miembro.equipo_id IS 'Equipo.';
COMMENT ON COLUMN equipo_miembro.usuario_id IS 'Usuario solicitante o integrante.';
COMMENT ON COLUMN equipo_miembro.rol IS 'Rol dentro del equipo.';
COMMENT ON COLUMN equipo_miembro.estado IS 'Estado de la solicitud.';
COMMENT ON COLUMN equipo_miembro.solicitado_en IS 'Fecha de la solicitud.';

CREATE TABLE compartido (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT NOT NULL REFERENCES publicacion(id) ON DELETE CASCADE,
  medio TEXT NOT NULL DEFAULT 'enlace',
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE compartido IS 'Registro de publicaciones compartidas.';
COMMENT ON COLUMN compartido.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN compartido.usuario_id IS 'Usuario que comparte.';
COMMENT ON COLUMN compartido.publicacion_id IS 'Publicación compartida.';
COMMENT ON COLUMN compartido.medio IS 'Medio usado para compartir (por ejemplo, enlace).';
COMMENT ON COLUMN compartido.creado_en IS 'Fecha en que se compartió.';

CREATE TABLE asistencia_ia (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  publicacion_id BIGINT REFERENCES publicacion(id) ON DELETE SET NULL,
  consulta TEXT NOT NULL,
  respuesta TEXT,
  modelo TEXT,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
COMMENT ON TABLE asistencia_ia IS 'Consultas a la asistencia con IA (opcional, solo si RC-01 entra al MVP).';
COMMENT ON COLUMN asistencia_ia.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN asistencia_ia.usuario_id IS 'Usuario que consulta.';
COMMENT ON COLUMN asistencia_ia.publicacion_id IS 'Publicación relacionada, si existe.';
COMMENT ON COLUMN asistencia_ia.consulta IS 'Pregunta enviada a la asistencia.';
COMMENT ON COLUMN asistencia_ia.respuesta IS 'Respuesta generada.';
COMMENT ON COLUMN asistencia_ia.modelo IS 'Nombre del servicio o modelo utilizado.';
COMMENT ON COLUMN asistencia_ia.creado_en IS 'Fecha de la consulta.';

CREATE TABLE encuesta_seguimiento (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  usuario_id BIGINT REFERENCES usuario(id) ON DELETE SET NULL,
  ronda TEXT NOT NULL,
  pregunta_codigo TEXT NOT NULL,
  valor_texto TEXT,
  valor_numerico SMALLINT,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ix_encuesta_ronda ON encuesta_seguimiento (ronda, pregunta_codigo);
COMMENT ON TABLE encuesta_seguimiento IS 'Respuestas de encuestas de seguimiento, para reevaluar los indicadores.';
COMMENT ON COLUMN encuesta_seguimiento.id IS 'Identificador único (autogenerado).';
COMMENT ON COLUMN encuesta_seguimiento.usuario_id IS 'Usuario que responde; nulo si es anónima.';
COMMENT ON COLUMN encuesta_seguimiento.ronda IS 'Ronda de medición (por ejemplo, base o seguimiento_1).';
COMMENT ON COLUMN encuesta_seguimiento.pregunta_codigo IS 'Código de la pregunta (por ejemplo, P04, P05, P08).';
COMMENT ON COLUMN encuesta_seguimiento.valor_texto IS 'Respuesta en texto.';
COMMENT ON COLUMN encuesta_seguimiento.valor_numerico IS 'Respuesta numérica, si aplica.';
COMMENT ON COLUMN encuesta_seguimiento.creado_en IS 'Fecha de la respuesta.';

-- Publicaciones con al menos una verificación docente o de moderador (RC-03)
CREATE VIEW v_publicacion_verificada AS
SELECT p.*, (SELECT COUNT(*) FROM verificacion_contenido v WHERE v.publicacion_id = p.id) AS num_verificaciones
FROM v_publicacion_publica p
WHERE EXISTS (SELECT 1 FROM verificacion_contenido v WHERE v.publicacion_id = p.id);

COMMIT;
