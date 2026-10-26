# NEXO — Decisiones pendientes antes del modelado

## 1. Contradicciones o diferencias documentales

| Tema | Evidencia 1 | Evidencia 2 | Consecuencia | Decisión requerida |
|---|---|---|---|---|
| Fuentes de análisis | `docs/03_analisis/` y `docs/03_analysis/` contienen versiones relacionadas pero no idénticas | Ambas se presentan como análisis de necesidades | Puede cambiar qué necesidades se consideran justificadas | Designar fuente canónica o consolidar versiones |
| Estado de requisitos | `requerimientos.md` contiene un bloque general y otro ampliado dentro del mismo archivo | `requisitos_funcionales.md` es un documento separado y también está en borrador | Hay riesgo de usar versiones distintas de RG/RF | Aprobar una versión y eliminar la ambigüedad documental |
| Grupo, espacio y equipo | Los requisitos hablan de grupos; `NEXO_02_extensiones.sql` crea `espacio` y `equipo` | No existe modelado de sistema | Puede duplicarse el concepto de comunidad | Confirmar si son sinónimos, jerarquía o entidades distintas |
| Clasificación académica | El análisis menciona temas, categorías y materias; el alcance excluye búsqueda académica avanzada | SQL crea `materia`, `tema`, etiquetas y búsqueda | Riesgo de ampliar el MVP | Definir el mínimo académico persistente de V1 |
| Moderación | Los requisitos asignan detección a IA y revisión final a una persona autorizada | SQL crea `verificacion_contenido` para docentes/moderadores y `asistencia_ia` opcional | Verificación docente no equivale a moderación IA | Separar evaluación IA, política, acción y seguimiento; descartar responsabilidades no aprobadas |

## 2. Clasificación por impacto

### Bloquean el modelo conceptual

- Significado de grupo y relación entre grupo, contenido y membresía.
- Estructura de conversaciones privadas y sus participantes.
- Destinos autorizados para archivos.
- Alcance de la moderación: evaluación IA, política, acciones, caso y revisión humana.
- Roles y permisos necesarios para representar acceso privado y revisión humana.
- Alcance de comentarios o reacciones si se consideran parte del modelo de publicaciones.

### Bloquean el esquema físico

- Identificador y mecanismo de autenticación.
- Estados de grupos, membresías, conversaciones, archivos y casos de moderación.
- Reglas de integridad, borrado y conservación.
- Formatos, tamaños, validación y almacenamiento de archivos.
- Datos que deben conservarse de la evaluación IA, política, acciones y revisiones.
- Retención y acceso a mensajes privados, archivos y casos.

### Bloquean únicamente la implementación

- Proveedor concreto de autenticación o IA, si el modelo conserva una referencia abstracta.
- Formato de API, nombres de endpoints y contratos de transporte.
- Estrategia física de almacenamiento de archivos, una vez definidos sus metadatos y reglas.
- Umbrales de rendimiento e índices concretos, después de conocer las consultas aprobadas.
- Detalles de interfaz para revisión, grupos, mensajes y archivos.

## 3. Decisiones funcionales no aprobadas

1. **Autenticación:** registro propio, cuenta institucional o proveedor externo.
2. **Identificador de usuario:** correo, identificador institucional u otra opción.
3. **Campos de perfil:** nombre, carrera, semestre, área, intereses y demás datos.
4. **Visibilidad:** quién puede consultar perfiles, publicaciones y membresías.
5. **Roles y permisos:** catálogo, asignación, alcance y cambios.
6. **Grupos:** quién crea, invita, acepta, retira o administra integrantes.
7. **Contenido grupal:** mensajes, publicaciones reutilizadas o ambos.
8. **Interacciones:** comentarios, reacciones, votos o ninguna en la V1.
9. **Conversaciones:** solo uno a uno o también conversaciones con varios participantes.
10. **Mensajería:** edición, borrado, lectura, entrega y retención.
11. **Archivos:** destinos permitidos; el requisito funcional confirma conversaciones y grupos, mientras que publicaciones siguen pendientes.
12. **Archivos:** extensiones, MIME, tamaño, antivirus, almacenamiento, conservación y eliminación.
13. **Moderación IA:** contenido analizado, versión del mecanismo, datos retenidos y resultado persistido.
14. **Política de moderación:** criterios que interpretan la evaluación IA y acciones automáticas permitidas.
15. **Acción ejecutada:** acciones automáticas permitidas y acciones humanas posteriores, con su registro.
16. **Caso de moderación:** estados, seguimiento y relación con evaluaciones y acciones.
17. **Revisión humana:** quién puede revisar, qué decisión registra y qué acciones puede ejecutar.
18. **Auditoría:** eventos que deben conservarse y durante cuánto tiempo.

## 4. Alternativas y consecuencias

### 3.1 Modelo de contenido grupal

- **Alternativa A: reutilizar publicaciones.** Menos entidades, pero puede mezclar contenido comunitario y grupal.
- **Alternativa B: mensajes grupales separados.** Expresa mejor la comunicación, pero aumenta el modelo.
- **Alternativa C: entidad de contenido común.** Reduce duplicación conceptual, pero exige reglas de acceso más complejas.

### 3.2 Archivos

- **Alternativa A: asociarlos solo a mensajes.** Se alinea con mensajería privada, pero no cubre archivos compartidos en grupos si no hay mensaje.
- **Alternativa B: asociarlos a mensajes y publicaciones/grupos.** Cubre el alcance descrito, pero requiere reglas de destino y autorización.
- **Alternativa C: repositorio independiente.** Flexible, pero podría ampliar el alcance y exige más controles.

### 3.3 Moderación

- **Alternativa A: persistir solo el caso señalado y la decisión humana.** Modelo mínimo, pierde evidencia del resultado IA.
- **Alternativa B: persistir evaluación IA, caso, política aplicada y acción.** Trazabilidad completa, requiere definir retención y datos sensibles.
- **Alternativa C: no persistir evaluación, solo aplicar señal en memoria.** No satisface bien seguimiento y auditoría; necesita justificación explícita.

## 5. Preguntas concretas para resolver

1. ¿Cuál es la fuente canónica entre `03_analisis` y `03_analysis`?
2. ¿El archivo `requerimientos.md` debe conservar ambos bloques o uno reemplaza al otro?
3. ¿Qué significa exactamente “grupo” en la V1?
4. ¿Qué roles existen y qué operaciones puede realizar cada uno?
5. ¿Qué criterios de política interpretan los resultados de la IA?
6. ¿Qué acciones automáticas permite la política y cuáles requieren revisión humana?
7. ¿Quién revisa un señalamiento: un moderador, un administrador u otra persona autorizada?
8. ¿Qué acciones humanas están permitidas: mantener visible, ocultar, eliminar, advertir o suspender?
9. ¿La revisión humana puede acceder a mensajes privados y sus archivos, y bajo qué autorización?
10. ¿Qué datos de la evaluación IA, política, acción, caso y revisión deben conservarse?
11. ¿Cuánto tiempo se conservan mensajes, archivos, reportes y decisiones?
12. ¿Se requiere anonimato? Si se requiere, ¿quién puede conocer la identidad real?
13. ¿Se incorporan comentarios o reacciones en la primera versión?
14. ¿Se necesita materia/tema para crear una publicación o son campos opcionales?
15. ¿Los archivos en publicaciones quedan fuera definitivamente?
16. ¿Se requiere historial de lectura, guardados, notificaciones o búsqueda avanzada?

## 6. Bloqueo para la siguiente fase

No debe construirse todavía el modelo entidad-relación definitivo ni generar SQL. La ausencia de reglas de negocio, actores, casos de uso y arquitectura técnica impide cerrar correctamente permisos, cardinalidades, estados, políticas de borrado y conservación.
