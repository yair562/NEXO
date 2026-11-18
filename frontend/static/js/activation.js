(function () {
    'use strict';

    var form = document.getElementById('formulario-activacion');
    var matricula = document.getElementById('activacion-matricula');
    var codigo = document.getElementById('activacion-codigo');
    var contrasena = document.getElementById('activacion-contrasena');
    var mensaje = document.getElementById('activacion-mensaje');
    var csrf = form.querySelector('[name="csrf_token"]').value;
    var fase = 'request';

    function mostrar(texto, error) {
        mensaje.textContent = texto;
        mensaje.classList.toggle('d-none', !texto);
        mensaje.classList.toggle('is-invalid', Boolean(error));
    }

    function enviar(url, payload) {
        return fetch(url, {
            method: 'POST',
            headers: {'Content-Type': 'application/json', 'X-CSRF-Token': csrf},
            body: JSON.stringify(payload)
        }).then(function (response) {
            return response.json().then(function (data) {
                if (!response.ok) throw new Error(data.message || 'No fue posible completar la operación.');
                return data;
            });
        });
    }

    form.addEventListener('submit', function (event) {
        event.preventDefault();
        mostrar('');
        var base = {matricula: matricula.value.trim()};
        if (fase === 'request') {
            enviar('/api/auth/activation/request', base).then(function (data) {
                fase = 'password';
                mostrar(data.development_code
                    ? 'Código de desarrollo: ' + data.development_code
                    : 'Revisa tu correo institucional e introduce el código recibido.');
                codigo.required = true;
                contrasena.required = true;
                form.querySelector('button').textContent = 'Activar cuenta';
            }).catch(function (error) { mostrar(error.message, true); });
            return;
        }
        enviar('/api/auth/activation/password', {
            matricula: base.matricula,
            codigo: codigo.value.trim(),
            contrasena: contrasena.value
        }).then(function () {
            window.location.href = '/';
        }).catch(function (error) { mostrar(error.message, true); });
    });
})();
