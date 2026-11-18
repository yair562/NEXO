SET LOCAL search_path TO nexo, public;

ALTER TABLE usuarios
    DROP CONSTRAINT usuarios_rol_valido;

ALTER TABLE usuarios
    ADD CONSTRAINT usuarios_rol_valido CHECK (
        rol IN ('estudiante', 'moderador', 'administrador')
    );
