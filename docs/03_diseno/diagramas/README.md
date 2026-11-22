# NEXO — Fase 1: Diagramas Funcionales

Este directorio contiene los tres diagramas funcionales base de **NEXO V1**, alineados con las decisiones documentadas en el proyecto (arquitectura Flask + PostgreSQL, identidad institucional, alcance del MVP y análisis de requerimientos).

> **Formato de entrega:** Los diagramas se entregan en formato editable **Mermaid** (`.mmd`), compatible con control de versiones, GitHub y editores como VS Code. No se generó exportación visual automática (`.svg`/`.png`) porque el entorno local no cuenta con herramientas CLI de renderizado instaladas (`mmdc`, `dot` o `plantuml`).

---

## 1. Propósito de cada diagrama

| Archivo | Diagrama | Propósito |
|---|---|---|
| [`01_flujo_general.mmd`](./01_flujo_general.mmd) | **Diagrama 01 — Flujo general de NEXO** | Representa el recorrido completo del usuario desde el acceso en red local, activación por padrón institucional, inicio de sesión, identificación de rol global, navegación entre módulos principales y cierre de sesión. |
| [`02_flujo_colaboracion.mmd`](./02_flujo_colaboracion.mmd) | **Diagrama 02 — Flujo de colaboración** | Modela la interacción funcional entre **Comunidad**, **Grupos** y **Equipos** como entidades diferenciadas, incluyendo su relación con la **moderación asistida por IA** y la **revisión humana**. |
| [`03_flujo_archivos.mmd`](./03_flujo_archivos.mmd) | **Diagrama 03 — Flujo de archivos compartidos** | Describe el ciclo completo de selección, verificación de contexto y permisos, validación, carga, almacenamiento, consulta, descarga y eliminación de archivos, así como los caminos de error y rechazo. |

---

## 2. Actores involucrados

- **Estudiante (`estudiante`):** Rol funcional inicial tras activar la cuenta. Puede gestionar su perfil, participar en Comunidad, Grupos, Equipos, mensajería privada y compartición de archivos según permisos.
- **Moderador (`moderador`):** Rol global V1 autorizado para consultar el contenido señalado por IA o reportado por usuarios y ejecutar acciones de revisión humana.
- **Administrador (`administrador`):** Rol global V1 con privilegios administrativos en la plataforma. *(Nota: el rol `docente` fue explícitamente excluido de V1 según [`bloque_1_identidad_autenticacion.md`](../../06_identidad/bloque_1_identidad_autenticacion.md)).*
- **Coordinador de Grupo / Coordinador de Equipo:** Rol contextual dentro de un grupo o equipo específico (referenciado en el modelo extendido `espacio_miembro` y `equipo_miembro`) para administrar integrantes, aprobar solicitudes y asignar responsables.
- **Sistema NEXO (Flask + PostgreSQL + Servicio SMTP + Asistencia IA):** Autoridad de autenticación, control de acceso, persistencia, envío de códigos institucionales y detección preliminar de contenido problemático.

---

## 3. Decisiones funcionales representadas

1. **Identidad y acceso cerrado (`bloque_1_identidad_autenticacion.md`):**
   - No existe registro público abierto; el acceso parte de un padrón institucional precargado (`padron_estudiantes`).
   - La `matrícula` es el identificador único e inmutable desde la aplicación; el correo institucional sigue el formato `L{MATRICULA}@huixquilucan.tecnm.mx`.
   - La activación requiere matrícula autorizada, código de un solo uso (6 dígitos, expiración de 15 minutos, máximo 5 intentos) y creación de contraseña (mínimo 10 caracteres). Las respuestas de activación no confirman si una matrícula pertenece al padrón.
   - Solo las cuentas en estado `ACTIVE` pueden iniciar sesión; los estados `PENDING`, `SUSPENDED` e `INACTIVE` son rechazados.
   - El inicio de sesión usa únicamente matrícula y contraseña (no repite código por correo).
2. **Separación conceptual entre Comunidad, Grupos y Equipos:**
   - **Comunidad:** espacio abierto de publicaciones generales para la comunidad estudiantil.
   - **Grupos:** espacios temáticos o de proyecto con membresía (`miembro` / `coordinador`) y visibilidad (`público` / `privado`).
   - **Equipos:** agrupaciones operativas de trabajo o estudio (`integrante` / `coordinador`), con estado (`abierto` / `cerrado`), cupo máximo opcional y vínculo opcional a un Grupo.
3. **Moderación asistida por IA sin bloqueo automático (`RF-16`..`RF-18`, `RNF-10`):**
   - La IA únicamente detecta y señala contenido potencialmente problemático; nunca bloquea ni elimina automáticamente. La decisión final corresponde siempre a revisión humana.
4. **Contextos autorizados para archivos (`RF-14`, `alcance.md` 5.5):**
   - Confirmados en V1: **conversaciones privadas** y **grupos**.
   - Publicaciones en Comunidad: marcado explícitamente como pendiente de confirmar en el alcance.

---

## 4. Reglas importantes

- **Privacidad y control de acceso (`RNF-01`, `RNF-02`):** Ningún usuario puede consultar conversaciones privadas, actividad interna de grupos privados ni archivos de contextos a los que no pertenezca.
- **Anti-enumeración en activación:** El sistema devuelve un mensaje neutro sin revelar si la matrícula ingresada existe en el padrón.
- **Integridad en fallos de archivos:** Un archivo que no supera validaciones no se almacena; si la carga o persistencia falla, no deben quedar metadatos huérfanos.
- **Coherencia con arquitectura Flask:** Flask actúa como autoridad de autenticación y control de sesión (`HttpOnly`, `SameSite`, CSRF), con PostgreSQL como persistencia.

---

## 5. Pendientes de definición encontrados

Durante la revisión documental (contrastando `docs/02_requerimientos/requisitos_funcionales.md`, `docs/06_identidad/bloque_1_identidad_autenticacion.md`, `docs/07_arquitectura/arquitectura_tecnologica.md` y `BD/analisis/decisiones_pendientes.md`) se identificaron los siguientes puntos **no definidos o con contradicciones** que bloquean o condicionan la implementación:

1. **Recuperación de acceso / contraseña (`bloque_1_identidad_autenticacion.md`):** Queda pendiente definir el flujo funcional completo y configurar el canal SMTP institucional (aunque existe una tabla `recuperaciones` en el esquema SQL heredado `V001`).
2. **Campos obligatorios, opcionales y visibilidad del perfil (`DP-02`):** No están cerrados los datos exactos del perfil (carrera, semestre, área, intereses) ni quién puede consultarlos.
3. **Interacciones en publicaciones (`DP-03`, `RF-06`):** Falta aprobar si la V1 implementará comentarios, reacciones/votos, ambos o ninguno.
4. **Relación canónica Grupo vs. Espacio vs. Equipo (`BD/analisis/decisiones_pendientes.md`):** Los requisitos hablan de *grupos*, mientras que el SQL heredado (`NEXO_02_extensiones.sql`) separa `espacio` y `equipo`. Falta confirmar formalmente si en V1 coexistirán ambas entidades o se consolidan.
5. **Permisos de creación y administración de grupos y equipos (`DP-04`, `RF-07`, `RF-08`):** Falta definir quién puede crear grupos, si el ingreso a grupos públicos es automático o por solicitud, y las reglas exactas para invitar, aceptar o retirar integrantes.
6. **Criterios de moderación, roles exactos y catálogo de acciones (`DP-06`, `DP-07`, `RF-18`):** Falta aprobar qué criterios interpreta la política de moderación, si `moderador` y `administrador` comparten exactamente los mismos permisos de revisión, qué acciones humanas quedan habilitadas (ocultar, restaurar, advertir, suspender) y si la revisión humana puede inspeccionar mensajes privados o sus archivos.
7. **Contradicción documental sobre `docente` y verificación de contenido:** El SQL heredado (`NEXO_02_extensiones.sql`) incluye `verificacion_contenido` para `docente`/`moderador`, pero `bloque_1_identidad_autenticacion.md` y `V006__roles_funcionales_v1.sql` excluyen explícitamente el rol `docente` en V1.
8. **Reglas técnicas de archivos (`DP-05`, `RF-14`, `RF-15`):** Faltan por definir los formatos/extensiones permitidos, tipos MIME, tamaño máximo, estrategia física de almacenamiento, política de retención, reglas de eliminación (quién y cuándo puede borrar un archivo) y si se habilitan archivos en publicaciones generales.
