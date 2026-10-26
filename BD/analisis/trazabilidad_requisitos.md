# NEXO — Trazabilidad de requisitos hacia datos

## 1. Requisitos funcionales

| ID | Descripción | Fuente | Datos requeridos | Entidades candidatas | Evidencia y duda |
|---|---|---|---|---|---|
| RF-01 | Identificar usuarios y permitir acceso autorizado | `docs/02_requerimientos/requisitos_funcionales.md`, sección 4.1 | Identidad, estado de acceso, credencial o proveedor externo | Usuario; rol/permiso pendiente | El mecanismo de autenticación no está decidido |
| RF-02 | Gestionar el propio perfil | RF-02 | Campos de perfil, cambios y visibilidad | Usuario; Perfil | Campos obligatorios pendientes |
| RF-03 | Consultar perfiles visibles | RF-03 | Datos visibles, usuario consultante y reglas de privacidad | Usuario; Perfil; permiso pendiente | No existe matriz de privacidad |
| RF-04 | Crear publicaciones | RF-04 | Autor, contenido, fecha, estado | Usuario; Publicación | El texto está confirmado; metadatos académicos no |
| RF-05 | Consultar publicaciones | RF-05 | Publicación, autor visible, contenido y visibilidad | Publicación; Usuario | Filtros y búsqueda no están cerrados |
| RF-06 | Reaccionar o comentar | RF-06 | Usuario, publicación, tipo y fecha de interacción | Reacción; Comentario | Se debe escoger qué interacción entra en V1 |
| RF-07 | Crear grupos | RF-07 | Grupo, creador, datos obligatorios y fechas | Grupo; Usuario | Permisos y campos obligatorios pendientes |
| RF-08 | Gestionar integrantes | RF-08 | Usuario, grupo, estado de membresía y quien ejecuta la acción | Grupo; Membresía; Usuario | Invitación, aprobación y retiro no definidos |
| RF-09 | Consultar integrantes | RF-09 | Membresías activas y reglas de acceso | Grupo; Membresía; Usuario | La visibilidad de integrantes está pendiente |
| RF-10 | Comunicar dentro de grupos | RF-10 | Autor, grupo, contenido, fecha y permisos | Grupo; Usuario; Mensaje o Publicación | No se define si se reutiliza publicación o se crea mensaje grupal |
| RF-11 | Iniciar conversación privada | RF-11 | Conversación, participantes, estado y fechas | Conversación; Participante | No se define si solo será uno a uno |
| RF-12 | Enviar y recibir mensajes | RF-12 | Remitente, conversación, texto, fecha, estado | Mensaje; Usuario; Conversación | Estados de entrega/lectura no requeridos explícitamente |
| RF-13 | Consultar historial | RF-13 | Mensajes ordenables por conversación y fecha | Mensaje; Conversación; Participante | Retención y borrado pendientes |
| RF-14 | Compartir archivos | RF-14 | Archivo, cargador, destino autorizado, asociación con mensaje o grupo y referencia de almacenamiento | Archivo; Mensaje; Grupo; Participante/Membresía | Publicaciones quedan fuera hasta confirmación; acceso debe comprobarse por pertenencia |
| RF-15 | Validar archivos | RF-15 | Tipo, tamaño, resultado de validación, fecha y eventual motivo de rechazo | Archivo; resultado de validación | Formatos, límites, antivirus, almacenamiento y conservación pendientes |
| RF-16 | Detectar contenido problemático mediante IA | RF-16 | Contenido evaluado, resultado IA, versión del mecanismo y fecha | Evaluación IA; Publicación/Mensaje | La IA realiza la moderación automatizada y no debe modelarse como usuario |
| RF-17 | Marcar contenido para revisión | RF-17 | Resultado IA, política aplicada, acción automática permitida, caso, estado, motivo y fechas | Evaluación IA; Política; Acción ejecutada; Caso de moderación | La política determina acciones automáticas permitidas; no se confirma bloqueo o eliminación automática |
| RF-18 | Revisar humanamente contenido señalado | RF-18 | Caso, contenido, revisor autorizado, decisión, motivo, acción posterior y fecha | Caso de moderación; Revisión humana; Acción ejecutada | La revisión humana se conserva; roles y acciones disponibles pendientes |

## 2. Requisitos no funcionales con impacto de datos

| ID | Descripción | Fuente | Impacto | Entidades relacionadas | Duda |
|---|---|---|---|---|---|
| RNF-01 | Seguridad de acceso | `docs/02_requerimientos/requisitos_no_funcionales.md` | Identidad, autorización, estado de acceso y trazabilidad de operaciones sensibles | Usuario; permiso; auditoría | No hay matriz de permisos ni catálogo de roles |
| RNF-02 | Privacidad de perfiles, conversaciones y archivos | RNF-02 | Control de pertenencia, visibilidad y acceso a archivos del destino autorizado | Perfil; Conversación; Participante; Grupo; Membresía; Archivo | No se define retención ni alcance de moderadores |
| RNF-03 | Operación en red local | RNF-03 | No exige una entidad de negocio específica | Configuración técnica futura | Arquitectura vacía |
| RNF-04 | Rendimiento | RNF-04 | Consultas por conversación, grupo y contenido podrían requerir índices | Mensaje; Publicación; Archivo | Umbrales no aprobados |
| RNF-05 | Integridad y persistencia | RNF-05 | PK, FK, estados y asociaciones coherentes | Todas las entidades confirmadas | Reglas de borrado pendientes |
| RNF-08 | Verificabilidad | RNF-08 | Conservación de evidencia de pruebas o acciones, si se requiere | Auditoría/caso | No se define qué evidencia persistir |
| RNF-09 | Mantener alcance MVP | RNF-09 | Excluir entidades no aprobadas | Todas | El SQL heredado excede el alcance |
| RNF-10 | Supervisión humana de IA | RNF-10 | Separar evaluación IA, política, acción ejecutada, caso y revisión humana; conservar revisión para casos señalados | Evaluación; Política; Acción; Caso; Revisión | No hay política aprobada ni catálogo de acciones |

## 3. Requisitos generales y necesidades

Los RG-01 a RG-09 de `docs/02_requerimientos/requerimientos.md` trazan al mismo núcleo:

- RG-01: Usuario y Perfil.
- RG-02/RG-03: Publicación y eventual interacción.
- RG-04: búsqueda o clasificación, aún no confirmada como módulo avanzado.
- RG-05: Archivo y destino autorizado.
- RG-06: Grupo y Membresía.
- RG-07: Conversación, Participante y Mensaje.
- RG-08: Evaluación IA, Caso y Revisión.
- RG-09: condición de despliegue, sin entidad funcional confirmada.

Las necesidades N-01 a N-06 y los hallazgos de `docs/03_analisis/` y `docs/03_analysis/` justifican el problema y las oportunidades, pero no agregan por sí mismos entidades obligatorias.

## 4. Cobertura pendiente

No existe matriz aprobada porque `docs/02_requerimientos/matriz_trazabilidad.md` está vacío. Esta tabla es un insumo de análisis y debe validarse junto con los requisitos.
