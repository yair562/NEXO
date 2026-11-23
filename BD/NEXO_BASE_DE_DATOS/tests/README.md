# Pruebas

## `run_tests.ps1` — base de datos y API

```powershell
powershell -ExecutionPolicy Bypass -File .\tests\run_tests.ps1
powershell -ExecutionPolicy Bypass -File .\tests\run_tests.ps1 -IncluirReinicio   # también prueba persistencia
```

Requisitos: `.env`, `docker compose up -d` y las migraciones aplicadas a la base `nexo`.

**No toca la base `nexo`:** las pruebas de esquema crean una base temporal `nexo_prueba_XXXX` y la borran al final.

| Conjunto | Qué valida |
|---|---|
| Migraciones | Aplica en orden todas las migraciones de `migrations/` (hoy V000–V006) desde una base vacía; una segunda ejecución no aplica nada; la semilla no duplica materias |
| Errores del script | Una migración con error se revierte entera, no se marca y se anota en `migration_failures` (exit 1); detecta una migración aplicada modificada (exit 3); rechaza nombres inválidos y `BEGIN/COMMIT` propios (exit 3); base inexistente (exit 2) |
| `sql/01_esquema.sql` | 12 tablas (10 de V001 y `padron_estudiantes` y `activaciones` de V005), 14 llaves foráneas con índice, identidades, booleanos, columnas y restricciones de identidad de V005 y V006, índice GIN, 2 triggers, 38 materias, 3 vistas, 7 migraciones |
| `sql/02_restricciones.sql` | Correo único y en minúsculas, roles de V006 (`docente` ya no se acepta), tipo válido, matrícula única y numérica, estados de cuenta, padrón institucional (correo `l…@huixquilucan.tecnm.mx`), máximo 5 intentos de activación, semestre 1..12, materia única sin mayúsculas, FK, `CASCADE`, `SET NULL`, voto único, trigger `actualizado_en` |
| `sql/03_permisos.sql` | `nexo_app` solo hace lo que el backend necesita, incluido leer el padrón y crear y actualizar activaciones (sin DDL, sin borrar usuarios, padrón ni activaciones, sin escribir el catálogo); `web_anon` solo ve materias; `nexo_lector` solo ve vistas; `authenticator` no hereda permisos; la vista oculta al autor resguardado |
| PostgREST (solo lectura sobre `nexo`) | Anónimo: `/materias` 200 con 38 filas, `/publicaciones` 401, `POST` denegado; `/usuarios` no existe (404); con JWT `nexo_lector`: `/publicaciones` 200, `POST` denegado; firma falsa 401 |
| `-IncluirReinicio` | `docker compose restart` (no borra volúmenes) y comprueba que datos, historial y API siguen |

Los archivos SQL de `sql/` revierten todo lo que hacen (`BEGIN ... ROLLBACK`).
