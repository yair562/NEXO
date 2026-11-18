<?php
// Vista del login. Variables que recibe de login.php: $errores (array) y $correo (string).
?>
<svg class="login-simbolos" width="0" height="0" aria-hidden="true" focusable="false">
    <symbol id="hexagono" viewBox="0 0 100 115">
        <polygon points="50,5 95,30 95,85 50,110 5,85 5,30" />
    </symbol>
</svg>

<div class="login" id="escena">
<?php if ($mostrarIntro): ?>
<div class="login-intro" id="login-intro" aria-hidden="true">
    <div class="login-intro-escena">
        <span class="login-intro-onda"></span>
        <div class="login-intro-capa">
            <img class="login-intro-mascota" src="<?= e(url('assets/img/mascota-tesh.png')) ?>" width="229" height="402" alt="">
        </div>
        <p class="login-intro-frase"><span>Conecta</span> <span>con</span> <span>tu</span> <span>comunidad</span></p>
        <p class="login-intro-sub">Pregunta, responde y encuentra a estudiantes del TESH con tus mismos intereses.</p>
    </div>
    <p class="login-intro-saltar">Toca para saltar</p>
</div>
<?php endif; ?>

    <div class="login-fondo" aria-hidden="true">
        <div class="login-foto"></div>
        <span class="hex-capa hex-capa--1"><svg class="hex"><use href="#hexagono" /></svg></span>
        <span class="hex-capa hex-capa--2"><svg class="hex"><use href="#hexagono" /></svg></span>
        <span class="hex-capa hex-capa--3"><svg class="hex"><use href="#hexagono" /></svg></span>
        <span class="hex-capa hex-capa--4"><svg class="hex"><use href="#hexagono" /></svg></span>
        <span class="hex-capa hex-capa--5"><svg class="hex"><use href="#hexagono" /></svg></span>
        <span class="hex-capa hex-capa--6"><svg class="hex"><use href="#hexagono" /></svg></span>
    </div>

    <div class="login-contenido">
        <section class="login-hero" aria-labelledby="login-lema">
            <img class="login-logo" src="<?= e(url('assets/img/logo-nexo.png')) ?>" width="320" height="332"
                 alt="NEXO, TESH Huixquilucan">
            <h1 class="login-lema" id="login-lema">Conecta con tu comunidad</h1>
            <p class="login-descripcion">Pregunta, responde y encuentra a estudiantes del TESH con tus mismos intereses.</p>
            <p class="login-institucion"><i class="bi bi-buildings" aria-hidden="true"></i> Tecnológico de Estudios Superiores de Huixquilucan</p>
        </section>

        <section class="login-tarjeta" aria-labelledby="login-titulo">
            <h2 class="login-titulo" id="login-titulo">Iniciar sesión</h2>
            <p class="login-subtitulo">Usa tu correo institucional.</p>

            <div aria-live="polite">
                <?php require __DIR__ . '/../../includes/errores.php'; ?>
            </div>

            <form method="post" id="formulario-login" novalidate>
                <?= campo_csrf() ?>

                <div class="mb-3">
                    <label class="form-label" for="correo">Correo institucional</label>
                    <input class="form-control" id="correo" name="correo" type="email" required autofocus
                           autocomplete="username" autocapitalize="none" spellcheck="false" inputmode="email"
                           placeholder="nombre@<?= e(DOMINIO_CORREO) ?>"
                           aria-describedby="correo-error" value="<?= e($correo) ?>">
                    <div class="invalid-feedback" id="correo-error"></div>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="contrasena">Contraseña</label>
                    <div class="input-group has-validation">
                        <input class="form-control" id="contrasena" name="contrasena" type="password" required
                               autocomplete="current-password" aria-describedby="contrasena-error">
                        <button class="btn login-ojo" type="button" id="alternar-contrasena"
                                aria-label="Mostrar contraseña" aria-pressed="false" aria-controls="contrasena">
                            <i class="bi bi-eye" aria-hidden="true"></i>
                        </button>
                        <div class="invalid-feedback" id="contrasena-error"></div>
                    </div>
                </div>

                <ol class="login-progreso" aria-hidden="true">
                    <li class="login-pip" data-pip="correo"><svg class="hex"><use href="#hexagono" /></svg>Correo</li>
                    <li class="login-pip" data-pip="contrasena"><svg class="hex"><use href="#hexagono" /></svg>Contraseña</li>
                    <li class="login-pip" data-pip="listo"><svg class="hex"><use href="#hexagono" /></svg>Listo</li>
                </ol>

                <button class="login-enviar" type="submit" id="boton-entrar">
                    <span class="spinner-border spinner-border-sm d-none" aria-hidden="true"></span>
                    <span class="login-enviar-texto">Entrar</span>
                </button>
            </form>

            <div class="login-enlaces">
                <a href="<?= e(url('recuperar.php')) ?>">¿Olvidaste tu contraseña?</a>
                <a href="<?= e(url('registro.php')) ?>">Crear cuenta</a>
            </div>
        </section>
    </div>
</div>
