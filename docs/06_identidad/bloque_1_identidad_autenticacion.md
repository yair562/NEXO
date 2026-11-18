# NEXO — Incremento 1: identidad y autenticación

## Decisiones aprobadas

NEXO utiliza un padrón precargado de estudiantes autorizados. No existe registro público abierto. La matrícula es el identificador único de la cuenta y no puede modificarse desde la aplicación. El correo institucional se genera como `L{MATRICULA}@huixquilucan.tecnm.mx`.

La activación requiere matrícula existente en el padrón, código enviado al correo institucional y creación posterior de contraseña. El código es de un solo uso, expira y solo se solicita durante la activación inicial. El inicio de sesión usa matrícula y contraseña, sin código de correo en cada acceso.

Los estados de cuenta son:

- `PENDING`: estudiante precargado que aún no activa su cuenta.
- `ACTIVE`: cuenta activada y autorizada.
- `SUSPENDED`: cuenta temporalmente bloqueada.
- `INACTIVE`: cuenta deshabilitada por pérdida de autorización institucional.

El padrón institucional y las cuentas activadas son entidades conceptualmente separadas.

## Reglas de seguridad

- Las contraseñas se almacenan únicamente como hashes.
- Los códigos de activación se almacenan como hashes, son de un solo uso, expiran y tienen límite de intentos.
- No se activan matrículas inexistentes ni se permite más de una cuenta por matrícula.
- Las respuestas de activación no confirman si una matrícula pertenece al padrón.
- Las cuentas `PENDING`, `SUSPENDED` e `INACTIVE` no pueden iniciar sesión.
- La verificación de correo no se repite durante el inicio de sesión.
- Flask es la autoridad de autenticación; PostgreSQL conserva el padrón, cuentas y estado.

## Implementación del incremento

- La migración `V005__identidad_y_activacion.sql` añade `padron_estudiantes`, estados de cuenta y `activaciones` sin modificar migraciones históricas.
- `scripts/import_roster.py` importa un CSV controlado con `matricula,nombre`, valida matrículas, detecta duplicados y devuelve un reporte.
- SMTP se configura mediante variables de entorno. Sin SMTP configurado no se simula un envío exitoso.
- Para desarrollo local aislado puede habilitarse `AUTH_DEV_CODE_OUTPUT=true` únicamente con `FLASK_ENV=development`; la respuesta muestra el código solo en ese modo. Debe permanecer deshabilitado en producción.
- La recuperación de contraseña queda pendiente de definir y configurar el canal institucional de correo.

## Roles

La cuenta comienza con el rol funcional `estudiante`. Se conservan como roles globales de V1 `estudiante`, `moderador` y `administrador`; no se agrega `docente`. Los roles técnicos de PostgreSQL no representan permisos funcionales.
