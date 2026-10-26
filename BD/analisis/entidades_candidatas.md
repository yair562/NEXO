# NEXO — Entidades candidatas

Este catálogo es conceptual. Los nombres no representan tablas aprobadas.

## 1. Entidades confirmadas conceptualmente

| Entidad candidata | Propósito | Datos que necesitaría | Relaciones preliminares | Evidencia | Estado |
|---|---|---|---|---|---|
| Usuario | Identificar a quien utiliza NEXO | Identificador, datos de acceso o identidad externa, estado | Tiene perfil; crea contenido; participa en grupos y conversaciones | `docs/02_requerimientos/requisitos_funcionales.md`, RF-01 a RF-03 | Confirmado |
| Perfil | Representar información visible del usuario | Información básica, campos académicos si se confirman, visibilidad | Pertenece a un usuario | `docs/01_proyecto/alcance.md`, 5.1; RF-02/RF-03 | Confirmado |
| Publicación | Compartir contenido textual con la comunidad | Autor, contenido, fechas, visibilidad y estado | Pertenece a usuario; puede estar en grupo; puede ser moderada | RF-04/RF-05; `docs/01_proyecto/alcance.md`, 5.2 | Confirmado |
| Grupo | Organizar comunicación y colaboración | Nombre, propósito, creador, visibilidad y estado | Tiene integrantes y contenido | RF-07 a RF-10; `docs/01_proyecto/alcance.md`, 5.3 | Confirmado conceptualmente |
| Membresía de grupo | Registrar pertenencia y permisos internos | Usuario, grupo, estado, fechas y eventual función | Une usuario y grupo | RF-08/RF-09 | Inferido necesario |
| Conversación privada | Delimitar un espacio de mensajería | Identificador, estado y fechas | Tiene participantes y mensajes | RF-11 a RF-13 | Confirmado |
| Participante de conversación | Autorizar acceso a una conversación | Usuario, conversación, estado y fechas | Une usuario y conversación | RF-11/RF-13; RNF-02 | Inferido necesario |
| Mensaje | Persistir comunicación privada | Conversación, remitente, texto, fecha y estado | Pertenece a conversación; puede tener archivo; puede ser evaluado | RF-12/RF-13, RF-16 | Confirmado |
| Archivo compartido | Registrar un archivo sin asumir su almacenamiento físico | Nombre, tipo, tamaño, cargador, destino, validación y referencia | Puede pertenecer a mensaje o grupo; publicación solo si se confirma | RF-14/RF-15; `docs/01_proyecto/alcance.md`, 5.5 | Confirmado; destino pendiente |
| Evaluación de contenido por IA | Registrar la moderación automatizada realizada por la IA | Contenido o referencia, resultado, versión del mecanismo y fecha | Se relaciona con publicación o mensaje y puede originar un caso | RF-16; RNF-10 | Confirmado conceptualmente |
| Política de moderación | Representar la regla que interpreta el resultado IA y define acciones automáticas permitidas | Criterio, versión, vigencia y relación con el resultado | Interpreta evaluaciones IA y condiciona acciones | RF-16/RF-17; política concreta pendiente | Pendiente de validar |
| Acción ejecutada | Registrar una acción automática permitida por política o una acción aplicada por una persona autorizada | Tipo, origen, resultado, fecha y responsable cuando corresponda | Se relaciona con evaluación, caso o revisión | RF-17/RF-18 | Inferido necesario |
| Señalamiento o caso de moderación | Dar seguimiento al contenido señalado y a su ciclo de atención | Motivo, estado, origen, fechas y referencias | Se origina en evaluación o política; puede tener acciones y revisión | RF-17/RF-18 | Inferido necesario |
| Revisión humana | Registrar la evaluación final de una persona autorizada | Revisor, caso, decisión, motivo y fecha | Resuelve o actualiza un caso; puede originar una acción | RF-18; RNF-10 | Confirmado conceptualmente |

## 2. Entidades condicionadas a decisiones

| Entidad candidata | Motivo | Evidencia | Estado |
|---|---|---|---|
| Rol o permiso | RF-01 y RF-18 exigen autorización, pero no hay catálogo aprobado | RF-01, RF-18, RNF-01 | Pendiente de validar |
| Comentario | RF-06 permite comentarios, pero también permite solo reacciones | RF-06 | Pendiente |
| Reacción | RF-06 permite reacciones, pero no obliga a implementarlas | RF-06 | Pendiente |
| Carrera, semestre o área | El alcance los menciona de forma condicional | `docs/01_proyecto/alcance.md`, 5.1 | Pendiente |
| Materia | Aparece en necesidades y SQL, pero no está cerrada como catálogo V1 | `docs/03_analysis/analysis.md`; SQL heredado | Propuesta |
| Tema o categoría | El análisis evidencia preferencia, pero el alcance excluye búsqueda académica avanzada | `docs/03_analysis/hallazgos_necesidades.md`; `alcance.md`, 8.2 | Propuesta |
| Etiqueta | Está en SQL, no en requisitos aprobados | `NEXO_01_nucleo.sql` | Propuesta |
| Notificación | Puede derivarse de eventos, pero no existe RF específico | SQL heredado | Propuesta |
| Auditoría | Es una consecuencia de seguridad y moderación, pero no se define su alcance | RNF-01/RNF-05; SQL heredado | Inferida |
| Equipo | SQL lo separa de espacio; los requisitos solo hablan de grupos | `NEXO_02_extensiones.sql`; RF-07 a RF-10 | Pendiente |
| Asistencia IA | El SQL la marca opcional y no equivale a moderación | `NEXO_02_extensiones.sql` | No confirmada |

## 3. Relaciones preliminares

- Usuario — Perfil: una identidad puede tener un perfil; obligatoriedad de creación pendiente.
- Usuario — Publicación: un usuario autorizado crea publicaciones.
- Usuario — Grupo: relación de muchos a muchos mediante membresía.
- Grupo — Mensaje o publicación: contenido dentro del grupo; el tipo exacto está pendiente.
- Usuario — Conversación: relación de muchos a muchos mediante participantes.
- Conversación — Mensaje: una conversación contiene mensajes.
- Usuario — Mensaje: cada mensaje tiene remitente.
- Mensaje — Archivo: asociación probable para archivos enviados en conversaciones.
- Grupo — Archivo: asociación probable para archivos compartidos en grupos.
- Publicación — Archivo: explícitamente pendiente en el alcance.
- Contenido — Evaluación IA — Política — Acción ejecutada — Caso de moderación — Revisión humana: cadena conceptual que distingue moderación automatizada, decisión de política, efecto aplicado, seguimiento y supervisión humana.

## 4. Límites del catálogo

No se convierten en entidades V1 las funcionalidades declaradas fuera de alcance: calificaciones, inscripción, horarios institucionales, certificados, analítica académica, videollamadas, transmisiones y red social generalista.
