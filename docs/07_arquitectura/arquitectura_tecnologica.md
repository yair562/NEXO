# NEXO — Definición de arquitectura tecnológica y preparación de migración

**Fecha:** 14 de noviembre de 2026  
**Estado:** preparación inicial completada; no implementa autenticación, registro ni migraciones de base de datos.

## 1. Decisión tecnológica

La arquitectura objetivo queda documentada así:

- **Frontend:** HTML5, CSS3 y JavaScript vanilla.
- **Backend:** Python 3 con Flask.
- **Base de datos:** PostgreSQL.
- **API:** REST con respuestas JSON.
- **Comunicación:** el navegador consume endpoints del backend mediante `fetch`.
- **Configuración:** variables de entorno; no se guardan credenciales en el repositorio.
- **Archivo local de desarrollo:** `.env` se carga con `python-dotenv`; las variables del sistema tienen prioridad.
- **Acceso a datos:** SQL parametrizado con Psycopg; no se introduce ORM en esta fase.

La arquitectura es deliberadamente pequeña. Flask debe encargarse del enrutamiento y ciclo HTTP; las reglas de negocio deben permanecer en servicios del backend y el acceso SQL debe mantenerse separado sin crear capas que todavía no tengan una responsabilidad real.

## 2. Diagnóstico del entorno

| Componente | Resultado | Consecuencia |
|---|---|---|
| Python | 3.14.6 | Disponible; se debe comprobar compatibilidad de dependencias antes de fijar versiones |
| `venv` | Disponible mediante `python -m venv` | Se recomienda un entorno local por proyecto |
| `pip` | 26.1.2 | Disponible |
| Flask | 3.1.3 instalado en `.venv` | Disponible para el servidor mínimo |
| Psycopg/Psycopg 2 | Psycopg 3.3.9 y `psycopg-binary` 3.3.9 instalados en `.venv` | Disponible para preparar conexiones; todavía no se conecta a una BD |
| Cliente PostgreSQL | `psql` 18.1 disponible | Permite administrar o validar una instancia local |
| Servicio PostgreSQL | `postgresql-x64-18` en ejecución | La disponibilidad del servicio no implica que exista una BD NEXO configurada |
| Node.js/npm | Disponibles, pero no necesarios | No se usarán para la arquitectura objetivo |
| Git | Repositorio activo, rama `master` adelantada un commit | Hay trabajo local no seguido; no se descarta ni se modifica |

Las dependencias se instalaron únicamente en `.venv`; no se instalaron paquetes globales ni se modificaron configuraciones del sistema.

## 3. Inventario de la base de datos

### 3.1 Fuentes revisadas

`BD/analisis/` contiene cinco documentos Markdown de análisis y no contiene archivos SQL. Los SQL heredados están en:

- `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_01_nucleo.sql`
- `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_02_extensiones.sql`
- `docs/NEXO_Entregables/NEXO_Entregables/3_Base_de_datos/NEXO_03_datos_prueba.sql`

Los tres archivos declaran PostgreSQL 14 o superior como destino; el encabezado indica que el núcleo fue probado en PostgreSQL 16. No se ejecutaron.

### 3.2 Tablas definidas por el SQL heredado

**Núcleo (`NEXO_01_nucleo.sql`):**

`rol`, `carrera`, `materia`, `plan_estudios`, `tema`, `etiqueta`, `tipo_contenido`, `habilidad`, `interes`, `usuario`, `perfil`, `usuario_materia`, `usuario_habilidad`, `usuario_interes`, `publicacion`, `publicacion_etiqueta`, `respuesta`, `comentario`, `adjunto`, `voto_publicacion`, `voto_respuesta`, `guardado`, `historial_consulta`, `seguimiento_publicacion`, `notificacion`, `consulta_busqueda`, `bitacora_auditoria`.

**Extensiones (`NEXO_02_extensiones.sql`):**

`verificacion_contenido`, `reporte`, `accion_moderacion`, `espacio`, `espacio_miembro`, `equipo`, `equipo_miembro`, `compartido`, `asistencia_ia`, `encuesta_seguimiento`.

El segundo archivo también añade `publicacion.espacio_id`, por lo que depende del núcleo y modifica su tabla `publicacion`.

### 3.3 Relaciones principales

- `rol` 1:N `usuario`.
- `carrera` 1:N `usuario` y N:M `materia` mediante `plan_estudios`.
- `materia` 1:N `tema`; `tema` permite jerarquía mediante `tema_padre_id`.
- `usuario` 1:1 `perfil`.
- `usuario` N:M `materia`, `habilidad` e `interes` mediante tablas puente.
- `usuario` 1:N `publicacion` y `respuesta`.
- `publicacion` 1:N `respuesta`, `comentario` y `adjunto`.
- `publicacion` N:M `etiqueta` mediante `publicacion_etiqueta`.
- `usuario` N:M `publicacion` mediante votos, guardados y seguimiento.
- `usuario` 1:N `notificacion`, `consulta_busqueda`, `historial_consulta` y `bitacora_auditoria`.
- `espacio` N:M `usuario` mediante `espacio_miembro`; `equipo` puede pertenecer a un `espacio`.
- `reporte` puede referir exactamente a una publicación, respuesta o comentario.
- `accion_moderacion` puede relacionarse con reporte, contenido o usuario afectado.

### 3.4 Padrón, matrícula y carrera

El SQL no define una tabla separada para el padrón institucional. La aproximación heredada es:

- `usuario.numero_control`: matrícula o número de control opcional y único.
- `usuario.carrera_id`: referencia opcional a `carrera`.
- `usuario.correo_institucional`: identificador institucional único.
- `perfil.semestre`: semestre del perfil, no evidencia de validación institucional.

Por tanto, el modelo heredado **no permite afirmar que exista validación contra un padrón oficial**. Antes de implementar matrículas debe decidirse si:

1. el padrón será una fuente externa de solo lectura;
2. se incorporará una tabla de importación o sincronización;
3. `usuario` será suficiente después de una validación externa;
4. `numero_control` es realmente la matrícula institucional y qué formato debe cumplir.

No debe añadirse una tabla por anticipación: la decisión corresponde al análisis funcional y a la autoridad que administra el padrón.

### 3.5 Usuario, restricciones y compatibilidad

La tabla heredada `usuario` incluye:

- `correo_institucional TEXT NOT NULL UNIQUE`;
- `hash_contrasena TEXT`, nullable para permitir autenticación externa;
- `numero_control TEXT UNIQUE`;
- `rol_id` obligatorio;
- `carrera_id` opcional;
- estados `activo`, `suspendido` e `inactivo`;
- fechas con `TIMESTAMPTZ`.

Se observan restricciones `PRIMARY KEY`, `UNIQUE`, `CHECK`, claves foráneas con `ON DELETE`, índices B-tree y GIN, `JSONB`, `TSVECTOR` generado y búsqueda en español. Son características de PostgreSQL, no una confirmación de que el modelo esté aprobado.

## 4. Estructura objetivo

No se crearán directorios vacíos durante esta fase. La estructura se materializará progresivamente cuando cada archivo tenga una responsabilidad concreta:

```text
NEXO/
├── frontend/
│   ├── templates/
│   │   └── login.html
│   └── static/
│       ├── css/
│       ├── js/
│       └── img/
├── backend/
│   ├── app.py
│   ├── config.py
│   ├── database.py
│   ├── routes/
│   └── services/
├── BD/
├── docs/
├── tests/
├── requirements.txt
├── .env.example
└── .gitignore
```

### Responsabilidades iniciales

- `backend/app.py`: crea la aplicación Flask y registra rutas.
- `backend/config.py`: lee y valida configuración no sensible desde variables de entorno.
- `backend/database.py`: abre conexiones y ejecuta consultas parametrizadas; no contiene reglas de negocio.
- `backend/routes/`: valida la entrada HTTP básica y transforma respuestas a JSON.
- `backend/services/`: concentra casos de uso cuando exista lógica implementada.
- `frontend/templates/`: HTML servido por Flask, sin lógica de persistencia.
- `frontend/static/`: CSS, JavaScript e imágenes reutilizadas.

No se propone una carpeta `models/`, `repositories/` o `utils/` hasta que exista código que justifique esas responsabilidades.

## 5. Plan de migración del login PHP

El directorio [`nexo/`](../../nexo/) se conserva como respaldo y no se sobrescribe.

### Reutilizable

- [`nexo/assets/css/login.css`](../../nexo/assets/css/login.css): estilos visuales del login.
- [`nexo/assets/js/login.js`](../../nexo/assets/js/login.js): interacción de formulario, mostrar/ocultar contraseña, progreso y animación de introducción.
- [`nexo/assets/img/`](../../nexo/assets/img/): logotipo, mascota y fotografía.
- Estructura visual de [`nexo/views/auth/login.view.php`](../../nexo/views/auth/login.view.php), convertida a HTML y adaptada a rutas estáticas de Flask.

### Sustituible

- [`nexo/login.php`](../../nexo/login.php): se reemplazará por una plantilla HTML y un endpoint Flask separado.
- `require`, variables PHP, helpers `e`, `url`, `campo_csrf` y lectura directa de `$_POST`: no pasan al frontend.
- Las consultas de usuario y la verificación de contraseña pertenecerán al backend, pero la autenticación no se implementa en esta etapa.

### Secuencia segura

1. Copiar recursos visuales a `frontend/static/` sin borrar `nexo/`.
2. Convertir la vista a `frontend/templates/login.html`, eliminando PHP y conservando el marcado visual.
3. Ajustar referencias de imágenes, hojas de estilo y scripts a rutas estáticas de Flask.
4. Mantener el formulario como presentación hasta definir el contrato REST.
5. Crear después un endpoint de salud y pruebas de renderizado.
6. Diseñar el endpoint de acceso solo cuando se aprueben autenticación, sesión, errores y protección CSRF.
7. Retirar el respaldo PHP únicamente después de validar la nueva pantalla y recibir autorización explícita.

## 6. Dependencias mínimas

Para la primera implementación del backend se utilizan:

```text
Flask
psycopg[binary]
python-dotenv
```

`python-dotenv` se limita a cargar el archivo `.env` local durante el desarrollo y no sustituye la protección de secretos. `.env` permanece excluido por Git y `.env.example` no contiene credenciales reales.

Para pruebas de backend se recomienda añadir `pytest` como dependencia de desarrollo cuando exista código que probar. No se instalará nada en esta fase ni se fijan versiones sin comprobar compatibilidad con Python 3.14.

## 7. Riesgos y bloqueos

1. **Padrón institucional no definido:** no existe tabla ni contrato de fuente oficial.
2. **SQL heredado no aprobado:** contiene funcionalidades más amplias que el alcance mínimo y mezcla núcleo con extensiones.
3. **Reglas de autenticación pendientes:** proveedor, identificador, recuperación, sesiones y roles no están cerrados.
4. **No existe backend Flask:** no hay puntos de entrada, configuración ni contratos REST implementados.
5. **Frontend PHP incompleto:** faltan sus includes base y páginas enlazadas; debe mantenerse como respaldo, no como base de una migración automática.
6. **Compatibilidad Python 3.14:** Flask y Psycopg deben validarse en un entorno virtual antes de fijar versiones.
7. **PostgreSQL local sin BD NEXO confirmada:** el servicio está activo, pero no se verificó una base, usuario o esquema del proyecto.
8. **Moderación y privacidad pendientes:** reportes, mensajes privados, archivos y revisión humana necesitan reglas de acceso y retención.
9. **Riesgo de copiar demasiado alcance:** materias, etiquetas, notificaciones, IA, equipos y búsqueda avanzada aparecen en SQL, pero no todos están aprobados para la V1.

## 8. Cambios recomendados para la siguiente etapa

1. Crear un entorno virtual local, sin instalación global.
2. Añadir `requirements.txt` con Flask y Psycopg después de verificar compatibilidad.
3. Añadir `.env.example` sin secretos, con nombres de variables documentados.
4. Crear el esqueleto mínimo de Flask solo con `app.py`, `config.py` y un endpoint de salud.
5. Añadir una prueba automatizada del endpoint de salud.
6. Migrar únicamente la vista y recursos del login, sin activar autenticación.
7. Definir el contrato REST del login antes de conectar formularios a PostgreSQL.
8. Resolver en [`BD/analisis/decisiones_pendientes.md`](../../BD/analisis/decisiones_pendientes.md) la fuente del padrón, la identidad institucional y el alcance de V1.
9. Separar, si se aprueba, el concepto de padrón institucional del registro de usuarios mediante una decisión de datos explícita.
10. Validar los SQL heredados en una base de pruebas aislada únicamente después de aprobar su alcance; nunca contra una base productiva.

## 9. Estado de esta fase

Se creó el servidor mínimo Flask y el endpoint `GET /api/health`. Se creó `.venv` y se instalaron Flask, Psycopg 3 binary y `python-dotenv`. La carga de `.env` se validó sin revelar valores sensibles y se confirmó que las variables del sistema tienen prioridad. No se crearon carpetas vacías, no se modificó ningún SQL, no se ejecutaron migraciones y no se alteró el frontend PHP existente.
