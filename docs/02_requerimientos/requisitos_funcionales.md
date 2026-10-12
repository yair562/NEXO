# NEXO — Plataforma Comunitaria Estudiantil

**Documento:** Requerimientos funcionales  
**Código:** NEXO-RF-01  
**Estado:** Borrador  
**Versión:** 1.0  
**Fecha de creación:** 11 de octubre de 2026  
**Última actualización:** 11 de octubre de 2026  
**Elaboró:** Equipo de desarrollo NEXO  
**Responsable:** Product Owner  

---

## 1. Propósito del documento

Este documento especifica los requerimientos funcionales de NEXO V1, una plataforma comunitaria dirigida a los estudiantes del Tecnológico de Estudios Superiores de Huixquilucan (TESH).

Los requerimientos funcionales describen las operaciones y capacidades que el sistema deberá proporcionar a sus usuarios. Su definición se basa en el alcance del proyecto, las necesidades identificadas y las restricciones establecidas para la primera versión.

Este documento servirá como referencia para el diseño, desarrollo, implementación, pruebas y validación del MVP de NEXO.

## 2. Alcance

Los requerimientos aquí definidos corresponden a las funciones previstas para NEXO V1:

- Gestión de perfiles de usuario.
- Creación y consulta de publicaciones.
- Interacciones básicas con publicaciones.
- Creación y participación en grupos.
- Comunicación mediante mensajes privados.
- Compartición de archivos en conversaciones privadas y grupos.
- Detección asistida por inteligencia artificial de contenido potencialmente problemático.
- Revisión humana del contenido señalado por el sistema de moderación.

El mecanismo de acceso, los permisos específicos y algunos detalles de implementación deberán definirse antes de cerrar la especificación.

## 3. Convenciones y prioridades

Cada requerimiento tiene un identificador único con el prefijo RF.

Las prioridades se interpretan de la siguiente manera:

- **Alta:** capacidad esencial para cumplir el propósito de NEXO V1.
- **Media:** capacidad complementaria que aporta valor y puede ajustarse según el tiempo de desarrollo.
- **Pendiente:** requiere una decisión antes de establecer su alcance definitivo.

Los criterios de verificación incluidos en este documento son condiciones iniciales para comprobar el comportamiento esperado. Los casos de prueba y criterios de aceptación detallados se documentarán por separado.

## 4. Requerimientos funcionales

### 4.1. Módulo de perfiles de usuario

#### RF-01. Acceso e identificación de usuarios

**Descripción:** El sistema deberá proporcionar un mecanismo para identificar a los usuarios y permitirles acceder a las funciones autorizadas de la plataforma.

**Prioridad:** Pendiente de definición.

**Criterio de verificación:** Una vez definido el mecanismo de acceso, deberá comprobarse que los usuarios autorizados puedan acceder y que las solicitudes no autorizadas sean rechazadas.

**Observaciones:** Quedan pendientes la elección entre registro propio o cuentas institucionales, el procedimiento de autenticación y las reglas de recuperación de acceso.

#### RF-02. Gestión del perfil

**Descripción:** El sistema deberá permitir al usuario consultar y gestionar la información de su propio perfil, de acuerdo con los campos y permisos que se definan.

**Prioridad:** Alta.

**Criterio de verificación:** El usuario deberá poder consultar su perfil y, cuando la edición esté habilitada, actualizar los campos permitidos y visualizar los cambios guardados.

**Observaciones:** Los datos obligatorios y opcionales del perfil deberán definirse durante el diseño.

#### RF-03. Consulta de perfiles

**Descripción:** El sistema deberá permitir consultar la información visible de otros usuarios, respetando las reglas de privacidad y los permisos establecidos.

**Prioridad:** Media.

**Criterio de verificación:** Al consultar el perfil de otro usuario, solo deberán mostrarse los datos autorizados para su visualización.

### 4.2. Módulo de publicaciones

#### RF-04. Creación de publicaciones

**Descripción:** El sistema deberá permitir a los usuarios autorizados crear publicaciones con contenido textual para compartir información con la comunidad estudiantil.

**Prioridad:** Alta.

**Criterio de verificación:** Una publicación válida deberá guardarse y quedar disponible para su consulta según las reglas de visibilidad establecidas.

#### RF-05. Consulta de publicaciones

**Descripción:** El sistema deberá permitir consultar las publicaciones disponibles y visualizar, como mínimo, su contenido y autor.

**Prioridad:** Alta.

**Criterio de verificación:** Al seleccionar una publicación, el sistema deberá mostrar su contenido y la información del autor que esté autorizada para mostrarse.

#### RF-06. Interacciones básicas con publicaciones

**Descripción:** El sistema deberá permitir interacciones básicas con las publicaciones mediante reacciones o comentarios, según las funcionalidades que se implementen y validen para la V1.

**Prioridad:** Media.

**Criterio de verificación:** El usuario deberá poder realizar las interacciones habilitadas y consultar el resultado correspondiente. El sistema deberá asociar cada interacción con la publicación y el usuario que la realiza.

**Observaciones:** Se deberá definir si se implementarán reacciones, comentarios o ambos. No se consideran obligatorias otras funciones sociales avanzadas.

### 4.3. Módulo de grupos

#### RF-07. Creación de grupos

**Descripción:** El sistema deberá permitir a los usuarios autorizados crear grupos para facilitar la comunicación y colaboración entre estudiantes.

**Prioridad:** Alta.

**Criterio de verificación:** Al proporcionar los datos obligatorios de un grupo, el sistema deberá crearlo y permitir su consulta conforme a los permisos definidos.

#### RF-08. Gestión de integrantes

**Descripción:** El sistema deberá permitir administrar la incorporación y participación de usuarios en los grupos, de acuerdo con las reglas de permisos establecidas.

**Prioridad:** Alta.

**Criterio de verificación:** Los usuarios autorizados deberán poder realizar las operaciones de gestión habilitadas. El sistema deberá impedir operaciones que excedan sus permisos.

**Observaciones:** Deberán definirse las reglas para invitar, agregar o retirar integrantes y determinar quién puede ejecutar cada acción.

#### RF-09. Consulta de integrantes

**Descripción:** El sistema deberá permitir consultar la lista de integrantes de un grupo cuando el usuario tenga autorización para hacerlo.

**Prioridad:** Media.

**Criterio de verificación:** El sistema deberá mostrar los integrantes correspondientes al grupo seleccionado, de acuerdo con las reglas de acceso.

#### RF-10. Comunicación en grupos

**Descripción:** El sistema deberá permitir que los integrantes autorizados compartan mensajes o publicaciones dentro de los grupos.

**Prioridad:** Alta.

**Criterio de verificación:** Un integrante autorizado deberá poder compartir contenido en el grupo y los demás integrantes con acceso deberán poder consultarlo.

### 4.4. Módulo de mensajería privada

#### RF-11. Inicio de conversaciones privadas

**Descripción:** El sistema deberá permitir iniciar una conversación privada entre usuarios identificados y autorizados para utilizar la mensajería.

**Prioridad:** Alta.

**Criterio de verificación:** Al iniciar una conversación válida, el sistema deberá crear o recuperar el espacio de conversación correspondiente y permitir el intercambio de mensajes.

#### RF-12. Envío y recepción de mensajes

**Descripción:** El sistema deberá permitir enviar y recibir mensajes de texto dentro de conversaciones privadas.

**Prioridad:** Alta.

**Criterio de verificación:** Un mensaje enviado correctamente deberá quedar asociado a la conversación y estar disponible para el destinatario autorizado.

#### RF-13. Consulta del historial de mensajes

**Descripción:** El sistema deberá permitir consultar el historial de mensajes de las conversaciones a las que el usuario tenga acceso.

**Prioridad:** Alta.

**Criterio de verificación:** Al abrir una conversación existente, el sistema deberá mostrar los mensajes almacenados que correspondan a ella, respetando los permisos de acceso.

### 4.5. Módulo de archivos

#### RF-14. Compartición de archivos

**Descripción:** El sistema deberá permitir adjuntar y compartir archivos en conversaciones privadas y grupos autorizados.

**Prioridad:** Alta.

**Criterio de verificación:** Un archivo válido deberá asociarse al mensaje o espacio correspondiente y estar disponible para los usuarios autorizados.

**Observaciones:** La compartición de archivos en publicaciones generales queda fuera de este requerimiento hasta que se confirme expresamente su inclusión en el alcance.

#### RF-15. Validación de archivos

**Descripción:** El sistema deberá validar los archivos compartidos según los tipos, tamaños y condiciones de aceptación que se establezcan.

**Prioridad:** Alta.

**Criterio de verificación:** El sistema deberá aceptar los archivos que cumplan las reglas definidas y rechazar aquellos que las incumplan, proporcionando una indicación del resultado.

**Observaciones:** Los formatos permitidos, el tamaño máximo y las reglas de almacenamiento deberán especificarse durante el diseño.

### 4.6. Módulo de moderación asistida por inteligencia artificial

#### RF-16. Detección de contenido potencialmente problemático

**Descripción:** El sistema deberá analizar el contenido definido para moderación mediante un mecanismo asistido por inteligencia artificial, con el objetivo de identificar posibles mensajes o publicaciones problemáticas.

**Prioridad:** Alta.

**Criterio de verificación:** Al evaluar contenido de prueba incluido en los casos de validación, el mecanismo deberá producir un resultado de análisis que permita determinar si requiere revisión, de acuerdo con los criterios establecidos.

**Observaciones:** La detección automática no garantiza que todos los casos problemáticos sean identificados correctamente.

#### RF-17. Marcado de contenido para revisión

**Descripción:** El sistema deberá marcar el contenido identificado como potencialmente problemático para facilitar su revisión por una persona autorizada.

**Prioridad:** Alta.

**Criterio de verificación:** Cuando el análisis determine que un contenido requiere revisión, deberá registrarse o señalarse de manera que pueda identificarse para su evaluación posterior.

**Observaciones:** El marcado no deberá implicar un bloqueo o eliminación automática del contenido.

#### RF-18. Revisión humana del contenido señalado

**Descripción:** El sistema deberá proporcionar un mecanismo para que una persona autorizada consulte el contenido marcado y determine las acciones correspondientes conforme a las reglas de moderación.

**Prioridad:** Alta.

**Criterio de verificación:** Una persona autorizada deberá poder consultar el contenido señalado y registrar o ejecutar las acciones de revisión que se habiliten.

**Observaciones:** Los roles de moderación, las acciones disponibles y el registro de las decisiones deberán definirse antes de cerrar la especificación.

## 5. Reglas generales de cumplimiento

Los requerimientos funcionales deberán implementarse respetando las siguientes condiciones:

1. Las funciones que involucren datos de usuarios deberán respetar los permisos y las reglas de privacidad definidas para la plataforma.
2. Las conversaciones privadas y sus archivos deberán estar disponibles únicamente para los usuarios autorizados.
3. La participación en grupos deberá ajustarse a las reglas de pertenencia y permisos.
4. La moderación asistida por IA tendrá como propósito identificar y señalar contenido para revisión humana; no deberá asumirse un bloqueo automático.
5. Las funciones implementadas deberán poder comprobarse mediante casos de prueba.
6. Las decisiones pendientes deberán resolverse antes de establecer los criterios de aceptación definitivos.
7. La implementación deberá mantenerse dentro del alcance y las restricciones de NEXO V1.

## 6. Decisiones pendientes

| ID | Decisión pendiente | Motivo |
|---|---|---|
| DP-01 | Mecanismo de registro y autenticación | Determina cómo se identifican y autorizan los usuarios. |
| DP-02 | Campos obligatorios y opcionales del perfil | Define los datos que almacenará y mostrará el sistema. |
| DP-03 | Tipos de interacciones en publicaciones | Determina si se implementarán reacciones, comentarios o ambos. |
| DP-04 | Reglas para crear grupos y gestionar integrantes | Establece permisos y responsabilidades. |
| DP-05 | Formatos y tamaños permitidos para archivos | Permite establecer validaciones concretas. |
| DP-06 | Criterios de moderación y roles autorizados | Define qué contenido se señala y quién puede revisarlo. |
| DP-07 | Acciones disponibles tras la revisión humana | Establece cómo se gestionarán los casos detectados. |

## 7. Relación con otros documentos

Este documento deberá mantenerse alineado con:

- `docs/01_proyecto/alcance.md`
- `docs/01_proyecto/descripcion_proyecto.md`
- `docs/01_proyecto/objetivos_proyecto.md`
- `docs/02_requerimientos/requerimientos.md`
- `docs/02_requerimientos/criterios_aceptacion.md`
- `docs/02_requerimientos/historias_usuario.md`
- `docs/02_requerimientos/matriz_trazabilidad.md`
- `docs/02_requerimientos/reglas_negocio.md`

Los documentos complementarios deberán desarrollarse tomando estos requerimientos como referencia, sin introducir funciones que contradigan el alcance aprobado de NEXO V1.