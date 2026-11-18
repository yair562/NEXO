# Archivo de esquemas

Aquí van los scripts de esquema que ya no se aplican con `apply_migrations.ps1`. Esta carpeta no se lee al migrar.

## Esquema MySQL de origen (retirado)

El esquema MySQL original (`nexo/database/nexo.sql`) se usaba con el prototipo PHP de los Sprints 1 y 2 para publicar
en InfinityFree. El 18/11/2026 el equipo retiró el prototipo PHP porque el producto se construye con Flask y PostgreSQL,
y el esquema MySQL se eliminó junto con él.

- Sigue disponible en el historial de Git: commit `09433e7`, archivo `BD/NEXO_BASE_DE_DATOS/nexo/database/nexo.sql`.
- Para verlo: `git show 09433e7:BD/NEXO_BASE_DE_DATOS/nexo/database/nexo.sql`
- Equivalencia de tipos MySQL → PostgreSQL: [`docs/auditoria_mysql_postgresql.md`](../../docs/auditoria_mysql_postgresql.md)
