(function () {
    'use strict';

    var formulario = document.getElementById('formulario-login');
    if (!formulario) return;

    var matricula = document.getElementById('matricula');
    var contrasena = document.getElementById('contrasena');
    var boton = document.getElementById('boton-entrar');
    var alternar = document.getElementById('alternar-contrasena');
    var csrf = formulario.querySelector('[name="csrf_token"]').value;

    function error(mensaje) {
        var destino = document.getElementById('matricula-error');
        destino.textContent = mensaje;
        matricula.classList.add('is-invalid');
    }

    alternar.addEventListener('click', function () {
        var visible = contrasena.type === 'text';
        contrasena.type = visible ? 'password' : 'text';
        alternar.textContent = visible ? 'Mostrar' : 'Ocultar';
        alternar.setAttribute('aria-pressed', visible ? 'false' : 'true');
    });

    formulario.addEventListener('submit', function (event) {
        event.preventDefault();
        matricula.classList.remove('is-invalid');
        if (!matricula.value.trim() || !/^[0-9]{1,20}$/.test(matricula.value.trim())) {
            error('Escribe una matrícula válida.');
            matricula.focus();
            return;
        }
        boton.disabled = true;
        fetch('/api/auth/login', {
            method: 'POST',
            headers: {'Content-Type': 'application/json', 'X-CSRF-Token': csrf},
            body: JSON.stringify({matricula: matricula.value, contrasena: contrasena.value})
        }).then(function (response) {
            return response.json().then(function (data) {
                if (!response.ok) throw new Error(data.message || 'No fue posible iniciar sesión.');
                window.location.href = '/app';
            });
        }).catch(function (caught) {
            error(caught.message);
            boton.disabled = false;
        });
    });
})();
