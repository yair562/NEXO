-- Verifica que el esquema creado por las migraciones V000 a V006 es el esperado.
-- Se ejecuta como superusuario en la base de prueba. Solo lee: no deja cambios.
DO $$
DECLARE
    faltantes text;
    n integer;
BEGIN
    -- 10 tablas de V001 (traducidas del esquema MySQL original) y 2 de V005 (identidad)
    SELECT string_agg(t, ', ') INTO faltantes
    FROM unnest(ARRAY['usuarios', 'recuperaciones', 'perfiles', 'materias', 'usuario_materias', 'publicaciones',
                      'adjuntos', 'comentarios', 'votos', 'guardados', 'padron_estudiantes', 'activaciones']) AS t
    WHERE to_regclass('nexo.' || t) IS NULL;
    IF faltantes IS NOT NULL THEN RAISE EXCEPTION 'Faltan tablas: %', faltantes; END IF;

    SELECT count(*) INTO n FROM information_schema.tables WHERE table_schema = 'nexo' AND table_type = 'BASE TABLE';
    IF n <> 12 THEN RAISE EXCEPTION 'Se esperaban 12 tablas en nexo, hay %', n; END IF;

    -- 14 llaves foráneas: 13 del MySQL de origen y activaciones.usuario_id (V005)
    SELECT count(*) INTO n FROM pg_constraint c JOIN pg_namespace s ON s.oid = c.connamespace
    WHERE s.nspname = 'nexo' AND c.contype = 'f';
    IF n <> 14 THEN RAISE EXCEPTION 'Se esperaban 14 llaves foráneas, hay %', n; END IF;

    -- Toda llave foránea tiene un índice que empieza por su columna (InnoDB los crea solo)
    SELECT string_agg(c.conrelid::regclass || '.' || a.attname, ', ') INTO faltantes
    FROM pg_constraint c
    JOIN pg_namespace s ON s.oid = c.connamespace
    JOIN pg_attribute a ON a.attrelid = c.conrelid AND a.attnum = c.conkey[1]
    WHERE s.nspname = 'nexo' AND c.contype = 'f'
      AND NOT EXISTS (SELECT 1 FROM pg_index i WHERE i.indrelid = c.conrelid AND i.indkey[0] = c.conkey[1]);
    IF faltantes IS NOT NULL THEN RAISE EXCEPTION 'Llaves foráneas sin índice: %', faltantes; END IF;

    -- Identidades en lugar de AUTO_INCREMENT (6 de V001 y activaciones.id de V005)
    SELECT count(*) INTO n FROM information_schema.columns
    WHERE table_schema = 'nexo' AND column_name = 'id' AND is_identity = 'YES';
    IF n <> 7 THEN RAISE EXCEPTION 'Se esperaban 7 columnas id de identidad, hay %', n; END IF;

    -- Columnas booleanas: 5 de V001 (antes TINYINT(1)) más padron_estudiantes.autorizado y activaciones.usado
    SELECT count(*) INTO n FROM information_schema.columns
    WHERE table_schema = 'nexo' AND data_type = 'boolean';
    IF n <> 7 THEN RAISE EXCEPTION 'Se esperaban 7 columnas boolean, hay %', n; END IF;

    -- Columnas de identidad agregadas a usuarios (V005); la contraseña puede faltar hasta activar la cuenta
    SELECT string_agg(col, ', ') INTO faltantes
    FROM unnest(ARRAY['matricula', 'estado', 'correo_verificado_en', 'activado_en']) AS col
    WHERE NOT EXISTS (SELECT 1 FROM information_schema.columns
                      WHERE table_schema = 'nexo' AND table_name = 'usuarios' AND column_name = col);
    IF faltantes IS NOT NULL THEN RAISE EXCEPTION 'Faltan columnas en usuarios: %', faltantes; END IF;
    PERFORM 1 FROM information_schema.columns
    WHERE table_schema = 'nexo' AND table_name = 'usuarios' AND column_name = 'contrasena_hash' AND is_nullable = 'YES';
    IF NOT FOUND THEN RAISE EXCEPTION 'usuarios.contrasena_hash debería admitir NULL (V005)'; END IF;

    -- Restricciones con nombre de V005 y V006
    SELECT string_agg(r, ', ') INTO faltantes
    FROM unnest(ARRAY['usuarios_rol_valido', 'usuarios_matricula_unica', 'usuarios_matricula_formato',
                      'usuarios_estado_valido', 'padron_matricula_formato', 'padron_correo_formato',
                      'activaciones_intentos_validos']) AS r
    WHERE NOT EXISTS (SELECT 1 FROM pg_constraint c JOIN pg_namespace s ON s.oid = c.connamespace
                      WHERE s.nspname = 'nexo' AND c.conname = r);
    IF faltantes IS NOT NULL THEN RAISE EXCEPTION 'Faltan restricciones: %', faltantes; END IF;

    -- Índice de texto completo (antes FULLTEXT)
    IF to_regclass('nexo.publicaciones_busqueda_idx') IS NULL THEN
        RAISE EXCEPTION 'Falta el índice GIN de búsqueda';
    END IF;

    -- Triggers de actualizado_en
    SELECT count(*) INTO n FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
    WHERE NOT t.tgisinternal AND c.relname IN ('perfiles', 'publicaciones');
    IF n <> 2 THEN RAISE EXCEPTION 'Se esperaban 2 triggers, hay %', n; END IF;

    -- Catálogo de materias
    SELECT count(*) INTO n FROM nexo.materias;
    IF n <> 38 THEN RAISE EXCEPTION 'Se esperaban 38 materias, hay %', n; END IF;

    -- Vistas de la API
    SELECT count(*) INTO n FROM information_schema.views WHERE table_schema = 'api';
    IF n <> 3 THEN RAISE EXCEPTION 'Se esperaban 3 vistas en api, hay %', n; END IF;

    -- Historial
    SELECT count(*) INTO n FROM nexo_meta.schema_migrations;
    IF n <> 7 THEN RAISE EXCEPTION 'Se esperaban 7 migraciones registradas, hay %', n; END IF;

    RAISE NOTICE 'esquema: OK';
END;
$$;
