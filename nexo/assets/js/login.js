// Interacciones del login. No guarda ni envía datos por su cuenta: el envío lo hace el formulario al backend PHP.
(function () {
    'use strict';

    var formulario = document.getElementById('formulario-login');
    if (!formulario) {
        return;
    }

    var escena = document.getElementById('escena');
    var tarjeta = formulario.closest('.login-tarjeta');
    var correo = document.getElementById('correo');
    var contrasena = document.getElementById('contrasena');
    var alternar = document.getElementById('alternar-contrasena');
    var boton = document.getElementById('boton-entrar');
    var spinner = boton.querySelector('.spinner-border');
    var textoBoton = boton.querySelector('.login-enviar-texto');
    var textoOriginal = textoBoton.textContent;
    var pips = {
        correo: formulario.querySelector('[data-pip="correo"]'),
        contrasena: formulario.querySelector('[data-pip="contrasena"]'),
        listo: formulario.querySelector('[data-pip="listo"]')
    };

    function marcarError(campo, mensaje) {
        campo.classList.add('is-invalid');
        campo.setAttribute('aria-invalid', 'true');
        document.getElementById(campo.id + '-error').textContent = mensaje;
    }

    function limpiarError(campo) {
        campo.classList.remove('is-invalid');
        campo.removeAttribute('aria-invalid');
    }

    function validar() {
        var primerError = null;

        limpiarError(correo);
        limpiarError(contrasena);

        if (correo.value.trim() === '') {
            marcarError(correo, 'Escribe tu correo institucional.');
            primerError = correo;
        } else if (!correo.validity.valid) {
            marcarError(correo, 'Escribe un correo válido.');
            primerError = correo;
        }

        if (contrasena.value === '') {
            marcarError(contrasena, 'Escribe tu contraseña.');
            primerError = primerError || contrasena;
        }

        return primerError;
    }

    function cambiarEstadoCarga(cargando) {
        boton.disabled = cargando;
        spinner.classList.toggle('d-none', !cargando);
        textoBoton.textContent = cargando ? 'Entrando…' : textoOriginal;
        formulario.setAttribute('aria-busy', cargando ? 'true' : 'false');
    }

    function sacudirTarjeta() {
        tarjeta.classList.remove('login-sacudida');
        void tarjeta.offsetWidth; // reinicia la animación
        tarjeta.classList.add('login-sacudida');
    }

    // Indicador de avance: se enciende un hexágono por cada paso completado.
    function actualizarProgreso() {
        var correoListo = correo.value.trim() !== '' && correo.validity.valid;
        var contrasenaLista = contrasena.value !== '';
        var todoListo = correoListo && contrasenaLista;

        pips.correo.classList.toggle('activo', correoListo);
        pips.contrasena.classList.toggle('activo', contrasenaLista);

        var estabaListo = pips.listo.classList.contains('activo');
        pips.listo.classList.toggle('activo', todoListo);
        if (todoListo && !estabaListo) {
            boton.classList.remove('listo');
            void boton.offsetWidth;
            boton.classList.add('listo');
        }
    }

    alternar.addEventListener('click', function () {
        var visible = contrasena.type === 'text';
        contrasena.type = visible ? 'password' : 'text';
        alternar.setAttribute('aria-pressed', visible ? 'false' : 'true');
        alternar.setAttribute('aria-label', visible ? 'Mostrar contraseña' : 'Ocultar contraseña');
        alternar.firstElementChild.className = visible ? 'bi bi-eye' : 'bi bi-eye-slash';
        contrasena.focus();
    });

    [correo, contrasena].forEach(function (campo) {
        campo.addEventListener('input', function () {
            limpiarError(campo);
            actualizarProgreso();
        });
    });

    formulario.addEventListener('submit', function (evento) {
        var primerError = validar();
        if (primerError) {
            evento.preventDefault();
            sacudirTarjeta();
            primerError.focus();
            return;
        }
        cambiarEstadoCarga(true);
    });

    // Si el navegador restaura la página con "atrás", el botón no debe quedar bloqueado.
    window.addEventListener('pageshow', function (evento) {
        if (evento.persisted) {
            cambiarEstadoCarga(false);
        }
        actualizarProgreso();
    });

    // Parallax suave de los hexágonos con el puntero (solo ratón y sin "reducir movimiento").
    var permiteMovimiento = window.matchMedia('(prefers-reduced-motion: no-preference)').matches
        && window.matchMedia('(pointer: fine)').matches;

    if (permiteMovimiento && escena) {
        var pendiente = false;
        var ultimoX = 0;
        var ultimoY = 0;

        window.addEventListener('pointermove', function (evento) {
            ultimoX = (evento.clientX / window.innerWidth - 0.5) * 2;
            ultimoY = (evento.clientY / window.innerHeight - 0.5) * 2;
            if (!pendiente) {
                pendiente = true;
                window.requestAnimationFrame(function () {
                    escena.style.setProperty('--mx', ultimoX.toFixed(3));
                    escena.style.setProperty('--my', ultimoY.toFixed(3));
                    pendiente = false;
                });
            }
        });
    }

    // Introducción animada: se puede saltar con clic, toque o cualquier tecla.
    var intro = document.getElementById('login-intro');
    if (intro) {
        var cerrarIntro = function () {
            intro.classList.add('login-intro--fin');
            document.removeEventListener('keydown', cerrarIntro);
            correo.focus();
        };
        intro.addEventListener('click', cerrarIntro);
        intro.addEventListener('animationend', function (evento) {
            if (evento.target === intro) {
                cerrarIntro();
            }
        });
        document.addEventListener('keydown', cerrarIntro);
    }

    actualizarProgreso();
})();
