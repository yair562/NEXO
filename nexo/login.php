<?php
// PBI-01: inicio de sesión. Este archivo solo procesa el acceso;
// el formulario se dibuja en views/auth/login.view.php.
require __DIR__ . '/includes/inicio.php';

if (usuario_actual()) {
    redirigir('index.php');
}

$errores = [];
$correo = '';

if (es_post()) {
    verificar_csrf();
    $correo = mb_strtolower(valor('correo'));
    $contrasena = (string) ($_POST['contrasena'] ?? '');

    if ($correo === '' || $contrasena === '') {
        $errores[] = 'Escribe tu correo y tu contraseña.';
    } elseif (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
        $errores[] = 'Escribe un correo válido, por ejemplo nombre@' . DOMINIO_CORREO . '.';
    } else {
        $consulta = db()->prepare('SELECT id, contrasena_hash, activo FROM usuarios WHERE correo = ?');
        $consulta->execute([$correo]);
        $usuario = $consulta->fetch();

        if (!$usuario) {
            // Gasta el mismo tiempo que una verificación real para no revelar qué correos existen.
            password_hash($contrasena, PASSWORD_DEFAULT);
            $credencialesValidas = false;
        } else {
            $credencialesValidas = password_verify($contrasena, $usuario['contrasena_hash']);
        }

        if (!$credencialesValidas) {
            $errores[] = 'Correo o contraseña incorrectos.';
        } elseif (!$usuario['activo']) {
            $errores[] = 'Tu cuenta está desactivada. Contacta a un moderador.';
        } else {
            if (password_needs_rehash($usuario['contrasena_hash'], PASSWORD_DEFAULT)) {
                db()->prepare('UPDATE usuarios SET contrasena_hash = ? WHERE id = ?')
                    ->execute([password_hash($contrasena, PASSWORD_DEFAULT), $usuario['id']]);
            }
            abrir_sesion((int) $usuario['id']);
            redirigir('index.php');
        }
    }
}

// La introducción se muestra una vez por sesión (o con ?intro) y nunca tras un intento fallido.
$mostrarIntro = isset($_GET['intro']) || (empty($_SESSION['intro_vista']) && !$errores);
$_SESSION['intro_vista'] = true;

$titulo = 'Iniciar sesión';
$estilosPagina = ['assets/css/login.css'];
$scriptsPagina = ['assets/js/login.js'];

require __DIR__ . '/includes/encabezado.php';
require __DIR__ . '/views/auth/login.view.php';
require __DIR__ . '/includes/pie.php';
