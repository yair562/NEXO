(function () {
    'use strict';

    var salir = document.getElementById('cerrar-sesion');
    if (!salir) return;

    var mensaje = document.getElementById('app-mensaje');
    var csrf = document.querySelector('meta[name="csrf-token"]').content;

    salir.addEventListener('click', function () {
        salir.disabled = true;
        mensaje.hidden = true;
        fetch('/api/auth/logout', {
            method: 'POST',
            headers: {'X-CSRF-Token': csrf}
        }).then(function (response) {
            if (!response.ok) throw new Error('No fue posible cerrar la sesión. Recarga la página e intenta de nuevo.');
            window.location.href = '/';
        }).catch(function (error) {
            mensaje.textContent = error.message;
            mensaje.hidden = false;
            salir.disabled = false;
        });
    });
})();
