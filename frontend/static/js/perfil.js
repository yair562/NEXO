(function () {
    'use strict';

    var formulario = document.getElementById('formulario-perfil');
    if (!formulario) return;

    var boton = document.getElementById('guardar-perfil');
    var estado = document.getElementById('perfil-estado');
    var csrf = document.querySelector('meta[name="csrf-token"]').content;

    function limpiarErrores() {
        formulario.querySelectorAll('[data-error]').forEach(function (nodo) {
            nodo.textContent = '';
            nodo.hidden = true;
        });
        formulario.querySelectorAll('[aria-invalid]').forEach(function (campo) {
            campo.removeAttribute('aria-invalid');
        });
    }

    function mostrarError(campo, mensaje) {
        var destino = formulario.querySelector('[data-error="' + campo + '"]');
        if (destino) {
            destino.textContent = mensaje;
            destino.hidden = false;
        }
        var control = formulario.elements[campo];
        if (control && control.setAttribute) {
            control.setAttribute('aria-invalid', 'true');
            control.focus();
        }
    }

    function datos() {
        var materias = [];
        formulario.querySelectorAll('input[name="materias"]:checked').forEach(function (casilla) {
            materias.push(parseInt(casilla.value, 10));
        });
        return {
            carrera: formulario.elements.carrera.value,
            semestre: formulario.elements.semestre.value,
            biografia: formulario.elements.biografia.value,
            habilidades: formulario.elements.habilidades.value,
            intereses: formulario.elements.intereses.value,
            materias: materias
        };
    }

    formulario.addEventListener('submit', function (event) {
        event.preventDefault();
        limpiarErrores();
        estado.textContent = '';
        estado.classList.remove('perfil-estado--error');
        boton.disabled = true;
        fetch('/api/perfil', {
            method: 'PUT',
            headers: {'Content-Type': 'application/json', 'X-CSRF-Token': csrf},
            body: JSON.stringify(datos())
        }).then(function (response) {
            if (response.status === 401) {
                window.location.href = '/';
                return null;
            }
            return response.json().then(function (data) {
                if (!response.ok) {
                    if (data.field) mostrarError(data.field, data.message);
                    throw new Error(data.message || 'No fue posible guardar el perfil.');
                }
                // Refleja las etiquetas como quedaron guardadas (sin repetidos ni espacios de más).
                formulario.elements.habilidades.value = data.perfil.habilidades || '';
                formulario.elements.intereses.value = data.perfil.intereses || '';
                estado.textContent = 'Perfil guardado.';
            });
        }).catch(function (error) {
            estado.textContent = error.message;
            estado.classList.add('perfil-estado--error');
        }).then(function () {
            boton.disabled = false;
        });
    });
})();
