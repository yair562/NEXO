# NEXO — Auditoría técnica y reorganización

**Fecha:** 14 de noviembre de 2026  
**Alcance:** estructura del repositorio, frontend disponible, backend, código compartido, configuración, pruebas y base de datos.

## Diagnóstico

### Tecnologías detectadas

- Frontend PHP con HTML, CSS y JavaScript sin framework ni gestor de paquetes.
- Punto de entrada disponible: `nexo/login.php`.
- Persistencia referenciada desde PHP mediante PDO y una tabla `usuarios`.
- El intérprete local es PHP 8.2 con PDO para MySQL y SQLite. No está disponible el controlador PDO de PostgreSQL.
- `src/frontend/`, `src/backend/` y `src/shared/` son directorios de preparación y solo contienen `.gitkeep`.
- No hay `package.json`, configuración de bundler, backend ejecutable ni pruebas automatizadas de aplicación.

### Estructura funcional encontrada

```text
nexo/
├── login.php
├── views/auth/login.view.php
├── assets/
│   ├── css/login.css
│   ├── js/login.js
│   └── img/
├── _parches/
└── LEEME_LOGIN.txt
```

La separación existente entre punto de entrada, vista y recursos estáticos es adecuada para el tamaño actual del frontend y se conserva.

### Problemas que impiden una ejecución completa

`login.php` requiere `includes/inicio.php`, `includes/encabezado.php` y `includes/pie.php`, y la vista requiere `includes/errores.php`. Ninguno de esos archivos existe en el repositorio. También se enlazan `index.php`, `registro.php` y `recuperar.php`, que todavía no están implementados.

Los archivos de `_parches/` contienen instrucciones para una instalación externa de NEXO; no son reemplazos funcionales de los includes ausentes. No se implementaron autenticación, registro, conexión a PostgreSQL ni nuevas pantallas porque están fuera del alcance de esta reorganización.

## Cambios realizados

- Se documentó esta auditoría en este archivo.
- Se añadió una guía local para el frontend PHP en [`nexo/README.md`](../../nexo/README.md).
- No se movieron ni eliminaron archivos del frontend existente.
- No se modificaron SQL, esquemas, documentos de análisis ni variables de entorno.
- No se modificaron las carpetas `src/` porque todavía no contienen módulos ejecutables que reorganizar.

La ausencia de movimientos de código es intencional: mover el frontend a `src/frontend/` rompería la instalación documentada y no resolvería los includes faltantes.

## Estructura recomendada para la siguiente fase

Cuando exista el backend real, la organización mínima recomendada es:

```text
src/
├── backend/
│   ├── config/
│   ├── modules/
│   ├── routes/
│   ├── middlewares/
│   ├── app.php
│   └── server.php
├── frontend/
│   ├── components/
│   ├── pages/
│   ├── services/
│   ├── styles/
│   └── assets/
└── shared/
    ├── contracts/
    └── constants/
```

Esta estructura debe aplicarse solo cuando existan archivos que justifiquen cada responsabilidad. El frontend PHP actual puede permanecer como aplicación heredada durante la transición.

## Validación

- `php -l nexo/login.php`: correcto.
- Se inspeccionaron todas las referencias PHP del frontend: los includes y páginas indicados arriba siguen pendientes.
- No se ejecutó una compilación frontend porque no existe `package.json` ni script de build.
- No se ejecutaron pruebas backend porque no hay backend implementado ni suite de pruebas de aplicación.
- No se ejecutó SQL ni se modificó PostgreSQL/MySQL.

## Pendientes y preparación

1. Recuperar o implementar los includes base de `nexo/` antes de considerar funcional el login.
2. Decidir oficialmente entre MySQL y PostgreSQL y documentar el controlador y la configuración.
3. Definir el contrato de acceso a datos antes de conectar PostgreSQL.
4. Validar matrículas contra el padrón institucional mediante un módulo de dominio y una fuente autorizada.
5. Implementar registro, inicio de sesión y soporte administrativo únicamente después de cerrar reglas, permisos y modelo de datos.
6. Añadir pruebas unitarias e integración cuando exista código backend.

