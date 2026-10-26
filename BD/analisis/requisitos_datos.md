# NEXO — Requisitos de datos de la V1

## 1. Criterio de clasificación

- **Confirmado:** aparece como capacidad de la V1 o requisito funcional/no funcional explícito.
- **Inferido:** consecuencia técnica necesaria para cumplir un requisito confirmado, sin ser una decisión de negocio cerrada.
- **Propuesto:** aparece en análisis exploratorio o SQL heredado, pero requiere aprobación.
- **Pendiente:** la evidencia no permite decidirlo.

## 2. Requisitos de persistencia confirmados

| Área | Datos que deben conservarse | Fuente |
|---|---|---|
| Identificación y acceso | Identificador de usuario y datos necesarios para autenticar o vincular una cuenta institucional | `docs/02_requerimientos/requisitos_funcionales.md`, RF-01 |
| Perfil | Información básica visible y editable del usuario | RF-02 y RF-03; `docs/01_proyecto/alcance.md`, sección 5.1 |
| Publicaciones | Autor, contenido textual, fecha y estado de visibilidad requerido por el flujo | RF-04 y RF-05 |
| Interacciones | Usuario, publicación y datos de la interacción habilitada | RF-06; el tipo exacto está pendiente |
| Grupos | Grupo, creador o responsable, integrantes y estado de pertenencia | RF-07 a RF-09 |
| Comunicación grupal | Mensajes o publicaciones vinculados al grupo y su autor | RF-10 |
| Mensajería privada | Conversación, participantes, mensajes, remitente, fechas e historial | RF-11 a RF-13 |
| Archivos | Metadatos, cargador, destino, validación y referencia de almacenamiento | RF-14 y RF-15 |
| Moderación automatizada | Contenido evaluado por la IA, resultado, versión del mecanismo y fecha | RF-16 y RNF-10 |
| Política de moderación | Regla que interpreta el resultado de la IA y define las acciones automáticas permitidas | RF-16/RF-17; la política concreta está pendiente |
| Acción ejecutada | Acción automática permitida por la política o acción aplicada por una persona autorizada, con resultado y fecha | RF-17/RF-18; acciones concretas pendientes |
| Caso de moderación | Seguimiento del contenido señalado, su estado y sus relaciones con evaluaciones y acciones | RF-17/RF-18 |
| Revisión humana | Persona autorizada, caso revisado, decisión, motivo y fecha | RF-18 y RNF-10 |
| Integridad | Relaciones entre usuarios, publicaciones, grupos, mensajes y archivos | RNF-05 |

## 3. Reglas que afectan a los datos

### Confirmadas

1. Solo usuarios identificados y autorizados pueden acceder a funciones protegidas.
2. Las conversaciones privadas y sus archivos solo deben estar disponibles para usuarios autorizados.
3. La pertenencia a grupos determina el acceso a su contenido.
4. El contenido debe conservar sus asociaciones correctas con usuarios, grupos, mensajes y archivos.
5. La IA realiza la evaluación automatizada del contenido y genera un resultado.
6. La política del sistema determina qué acciones automáticas están permitidas para cada resultado; la política concreta sigue pendiente.
7. Toda acción ejecutada debe distinguirse del resultado de la IA y del caso que le da seguimiento.
8. La revisión humana se conserva para los casos señalados conforme a RF-18 y RNF-10; no se sustituye por la evaluación automatizada.
9. La V1 debe operar dentro del alcance del MVP y red local definida.

### Inferidas, no aprobadas como reglas de negocio

- Una conversación debe tener uno o más participantes.
- Un mensaje debe tener un remitente y una conversación.
- Una membresía de grupo debe identificar usuario, grupo y estado.
- Un archivo debe tener un destino válido y no solo una ruta libre.
- La evaluación IA debería conservar su resultado y versión para trazabilidad.
- La política aplicada y la acción ejecutada deberían conservarse separadamente.
- La revisión humana debería conservar persona autorizada, decisión, motivo y fecha.

## 4. Privacidad, seguridad y conservación

### Confirmado

- Debe protegerse la información privada de usuarios, conversaciones y archivos restringidos (`RNF-02`).
- Debe limitarse el acceso según permisos (`RNF-01`).
- Debe mantenerse integridad y persistencia de relaciones (`RNF-05`).
- La evaluación IA, la política aplicada, la acción ejecutada, el caso y la revisión humana deben distinguirse (`RNF-10`).

### Pendiente

- Mecanismo de autenticación y recuperación.
- Roles y permisos concretos.
- Visibilidad de perfiles y publicaciones.
- Conservación o eliminación de mensajes y archivos.
- Borrado lógico o físico.
- Acceso de moderadores al contenido privado.
- Retención de evaluaciones IA, políticas, acciones, casos y revisiones.
- Si una acción automática puede ocultar, bloquear o modificar la disponibilidad del contenido.
- Formatos, tamaño máximo, antivirus o validación de archivos.

## 5. Propuestas no confirmadas

El análisis y los SQL heredados sugieren, pero no confirman para la V1:

- Materias, temas, etiquetas y tipos de contenido.
- Comentarios, votos, reacciones y respuestas aceptadas.
- Guardados, historial de consultas, seguimiento y notificaciones.
- Habilidades e intereses en el perfil.
- Verificación docente.
- Equipos de trabajo separados de grupos.
- Asistencia conversacional con IA.
- Búsqueda académica avanzada.

Estas propuestas no deben convertirse en persistencia obligatoria hasta aprobar su alcance.

## 6. Datos fuera de alcance o sin justificación actual

No hay evidencia para persistir en la V1:

- Calificaciones.
- Inscripciones.
- Horarios institucionales automatizados.
- Evaluación docente.
- Certificados.
- Analítica de desempeño.
- Publicidad, monetización o comercio.
- Llamadas, videollamadas o historias efímeras.

## 7. Bloqueos para el modelado

No puede cerrarse el modelo conceptual sin resolver autenticación, catálogo de permisos, significado de grupo, destino de archivos, alcance de interacciones y flujo completo de moderación IA-política-acción-caso-revisión humana.
