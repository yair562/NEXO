# NEXO — Inventario documental para el análisis de datos

**Fase:** 1 — análisis documental  
**Fecha de revisión:** 26 de octubre de 2026  
**Alcance de la revisión:** archivos de `docs/` relacionados con proyecto, requisitos, análisis, modelado, arquitectura y diseño técnico, además de los SQL heredados localizados en los entregables.

## 1. Resultado de la inspección inicial

- **Raíz confirmada:** `C:\GEST.PROY.TI\NEXO`
- **Estado inicial de Git:** ya existían cambios no atribuibles a este análisis:
  - `M docs/04_modelado_sistema/actores.md`
  - `M docs/Gest_Proy_TI/001_Propuesta_Proy/Acta_Inicio_RIV (1).docx`
  - `?? docs/Gest_Proy_TI/001_Propuesta_Proy/~WRL1325.tmp`
  - `?? docs/NEXO_Entregables.zip`
  - `?? docs/NEXO_Entregables/`
- `BD/` no existía antes de este análisis.
- No se ejecutó SQL ni se modificaron scripts.

## 2. Inventario por carpeta

### `docs/01_proyecto/`

| Ruta | Estado | Relevancia para la BD | Limitación |
|---|---|---|---|
| `alcance.md` | Completo | Define la V1: perfiles, publicaciones, grupos, mensajería privada, archivos y moderación asistida por IA | Deja autenticación, permisos y detalles de archivos pendientes |
| `descripcion_proyecto.md` | Parcial | Contexto, propósito y población objetivo | No define datos ni reglas |
| `objetivos.md` | Parcial | Objetivos generales del producto | No contiene modelo de persistencia |
| `proyecto.md` | Vacío | Ninguna | No aporta evidencia |
| `restricciones_supuestos.md` | Vacío | Ninguna | No aporta evidencia |
| `stakeholders.md` | Vacío | Ninguna | No permite confirmar actores ni permisos |

### `docs/02_requerimientos/`

| Ruta | Estado | Relevancia para la BD | Limitación |
|---|---|---|---|
| `requerimientos.md` | Completo, con dos bloques de especificación dentro del mismo archivo | Necesidades N-01 a N-06, objetivos O-01 a O-07 y RG-01 a RG-09 | Tiene duplicación interna y requiere determinar qué sección es canónica |
| `requisitos_funcionales.md` | Completo, borrador | RF-01 a RF-18, incluyendo mensajería, archivos y moderación | Permisos, autenticación, archivos y moderación siguen pendientes |
| `requisitos_no_funcionales.md` | Completo, borrador | Seguridad, privacidad, integridad, persistencia y revisión humana de IA | No define controles técnicos concretos |
| `reglas_negocio.md` | Vacío | Ninguna regla formal verificable | Bloquea restricciones de dominio y estados aprobados |
| `historias_usuario.md` | Vacío | Ninguna | No permite completar flujos ni datos por caso de uso |
| `criterios_aceptacion.md` | Vacío | Ninguno | No permite confirmar escenarios límite |
| `matriz_trazabilidad.md` | Vacío | Ninguna matriz formal | No permite comprobar cobertura requisito-entidad |

### `docs/03_analisis/`

| Ruta | Estado | Relevancia para la BD | Limitación |
|---|---|---|---|
| `analisis.md` | Parcial | Solo remite al análisis completo | No contiene evidencia propia |
| `analysis.md` | Completo | Hallazgos, necesidades y oportunidades; distingue dato, hallazgo, necesidad, oportunidad y requisito | Mantiene oportunidades que no son requisitos aprobados |
| `encuesta_necesidades_estudiantiles.md` | Completo | Evidencia exploratoria de necesidades de consulta, colaboración y contenido | Muestra no probabilística; no convierte necesidades en funcionalidades |

### `docs/03_analysis/`

| Ruta | Estado | Relevancia para la BD | Limitación |
|---|---|---|---|
| `analysis.md` | Completo | Segunda versión del análisis, con ocho hallazgos y oportunidades | No es idéntico a `03_analisis/analysis.md` |
| `encuesta_necesidades_estudiantiles.md` | Completo | Segunda versión relacionada del instrumento | Debe definirse una fuente canónica |
| `hallazgos_necesidades.md` | Completo | Resumen de hallazgos y prioridades preliminares | Las prioridades son del equipo, no aprobación funcional |

Las carpetas `03_analisis/` y `03_analysis/` son potencialmente duplicadas, pero presentan diferencias de redacción y nivel de detalle. Se requiere decisión documental antes de usarlas como autoridad única.

### `docs/04_modelado_sistema/`

| Ruta | Estado | Relevancia para la BD | Limitación |
|---|---|---|---|
| `actores.md` | Vacío; además figuraba modificado al inicio | Ninguna confirmación formal de actores | No debe inferirse un catálogo de roles desde el SQL |
| `casos_uso.md` | Vacío | Ninguna | No hay flujos persistentes formalizados |
| `modelado_sistema.md` | Vacío | Ninguna | No hay relaciones ni cardinalidades aprobadas |

### `docs/07_arquitectura/`

Los cinco archivos están vacíos:

- `arquitectura.md`
- `arquitectura_aplicacion.md`
- `arquitectura_datos.md`
- `arquitectura_despliegue.md`
- `arquitectura_sistema.md`

No existe una arquitectura de datos aprobada ni una decisión sobre el almacenamiento de archivos o servicios externos.

### `docs/08_diseño_tecnico/`

Los siete archivos están vacíos:

- `api.md`
- `backend.md`
- `base_datos.md`
- `frontend.md`
- `integraciones.md`
- `seguridad.md`
- `stack_tecnologico.md`

No se pudieron confirmar contratos API, proveedor de autenticación, almacenamiento de archivos, integración con IA ni política técnica de seguridad.

## 3. SQL heredado localizado

| Ruta | Estado | Contenido observado | Tratamiento en este análisis |
|---|---|---|---|
| `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_01_nucleo.sql` | Propuesta técnica | Usuarios, perfiles, catálogos académicos, publicaciones, respuestas, comentarios, adjuntos, votos, guardados, búsquedas, notificaciones y auditoría | No es autoridad; se contrasta con requisitos |
| `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_02_extensiones.sql` | Propuesta técnica | Reportes, acciones de moderación, espacios, equipos, asistencia IA y seguimiento | No es autoridad; contiene funciones no confirmadas |
| `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_03_datos_prueba.sql` | Datos ficticios | Supone roles, materias, publicaciones, adjuntos y verificación | No se ejecutó ni se toma como especificación |

Los SQL no contienen un modelo explícito de conversación privada, participantes de conversación ni mensajes, aunque esos elementos sí aparecen en los requisitos funcionales.

## 4. Cobertura y limitaciones

Se revisaron los archivos no vacíos de las carpetas solicitadas y se verificó el estado de todos los archivos Markdown de esas carpetas. Los documentos vacíos se registran como vacíos, no como evidencia ausente del sistema.

Los archivos DOCX, imágenes y el ZIP de entregables no se utilizaron como fuente normativa para este entregable porque la documentación Markdown del repositorio es la fuente indicada para el alcance. Su existencia se registra como material adicional no normalizado.

Conclusión: la evidencia permite identificar persistencia necesaria para la V1, pero no permite cerrar actores, permisos, cardinalidades, estados, políticas de conservación ni el modelo definitivo.
