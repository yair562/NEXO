# Frontend PHP de NEXO

Este directorio contiene la implementación PHP disponible actualmente para la pantalla de inicio de sesión.

## Organización

- `login.php`: punto de entrada y procesamiento de la solicitud de inicio de sesión.
- `views/auth/`: vistas PHP de autenticación.
- `assets/css/`: estilos de la pantalla.
- `assets/js/`: interacciones del navegador.
- `assets/img/`: recursos gráficos.
- `_parches/`: instrucciones heredadas para una instalación externa; no son includes ejecutables.

La aplicación mantiene esta estructura porque ya separa presentación, recursos estáticos y punto de entrada sin introducir capas innecesarias.

## Estado actual

El frontend no es ejecutable de forma autónoma dentro de este repositorio: `login.php` depende de `includes/inicio.php`, `includes/encabezado.php`, `includes/pie.php` e `includes/errores.php`, que aún no están presentes. También existen enlaces a pantallas futuras (`index.php`, `registro.php` y `recuperar.php`).

No se deben crear implementaciones ficticias de esos archivos para esta fase. La autenticación, el registro y la conexión a la base de datos requieren primero una decisión de arquitectura y reglas de negocio.

## Verificación local

Desde la raíz del repositorio:

```text
php -l nexo\login.php
```

El archivo de entrada pasa la comprobación sintáctica de PHP 8.2. No hay un gestor de paquetes ni un proceso de compilación frontend configurado.
