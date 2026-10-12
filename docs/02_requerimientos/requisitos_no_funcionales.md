# NEXO — Plataforma Comunitaria Estudiantil

**Documento:** Requerimientos no funcionales  
**Código:** NEXO-RNF-01  
**Estado:** Borrador  
**Versión:** 1.0  
**Fecha de creación:** 11 de octubre de 2026  
**Última actualización:** 11 de octubre de 2026  
**Elaboró:** Equipo de desarrollo NEXO  
**Responsable:** Product Owner

---

## 1. Propósito

El presente documento establece los requerimientos no funcionales de NEXO, una plataforma comunitaria estudiantil orientada a facilitar la comunicación, la colaboración y el intercambio de información entre estudiantes del Tecnológico de Estudios Superiores de Huixquilucan (TESH).

Estos requerimientos definen las condiciones de calidad, seguridad, privacidad, operación y mantenimiento que deberá cumplir la plataforma durante su desarrollo y funcionamiento inicial.

## 2. Alcance

Los requerimientos no funcionales aplican a la versión 1.0 de NEXO, que contempla perfiles de usuario, publicaciones, grupos internos, mensajería privada, intercambio de archivos y moderación asistida por inteligencia artificial.

La primera versión estará orientada a un entorno de operación en red local y deberá mantenerse dentro del alcance del producto mínimo viable (MVP), considerando el tiempo y los recursos disponibles para el equipo de desarrollo.

## 3. Requerimientos no funcionales

### RNF-01. Seguridad de acceso

**Descripción:** La plataforma deberá proteger el acceso a sus funciones y recursos mediante mecanismos que permitan identificar a los usuarios y limitar las operaciones según los permisos que tengan asignados.

**Criterio de verificación:** Comprobar que un usuario no pueda acceder a funciones o recursos para los cuales no tenga autorización.

**Prioridad:** Alta.

### RNF-02. Privacidad de la información

**Descripción:** NEXO deberá proteger la información privada de los usuarios, las conversaciones individuales y los archivos compartidos en espacios restringidos, evitando que sean consultados por personas no autorizadas.

**Criterio de verificación:** Realizar pruebas con usuarios diferentes y comprobar que no puedan consultar conversaciones privadas ni archivos de grupos a los que no tengan acceso.

**Prioridad:** Alta.

### RNF-03. Entorno de operación

**Descripción:** La versión 1.0 de NEXO deberá poder ejecutarse en un entorno de red local, permitiendo que los usuarios autorizados dentro de dicho entorno accedan a las funciones implementadas.

**Criterio de verificación:** Instalar o ejecutar la plataforma en el entorno de prueba definido por el equipo y comprobar el acceso desde los dispositivos conectados a la red local, de acuerdo con la configuración establecida.

**Prioridad:** Alta.

### RNF-04. Rendimiento

**Descripción:** La plataforma deberá responder de manera adecuada a las operaciones principales, como consultar publicaciones, abrir grupos, enviar mensajes y consultar archivos, evitando demoras innecesarias durante las pruebas de uso previstas para el MVP.

**Criterio de verificación:** Medir los tiempos de respuesta de las operaciones principales en el entorno de prueba y documentar los resultados. Los tiempos máximos aceptables deberán definirse y aprobarse por el equipo antes de la validación final.

**Prioridad:** Media.

### RNF-05. Integridad y persistencia de los datos

**Descripción:** NEXO deberá conservar la información registrada correctamente, manteniendo las relaciones entre usuarios, publicaciones, grupos, mensajes y archivos, según corresponda.

**Criterio de verificación:** Registrar, consultar y actualizar información mediante las funciones disponibles, y comprobar que los datos permanezcan consistentes y asociados a los elementos correctos.

**Prioridad:** Alta.

### RNF-06. Usabilidad

**Descripción:** La interfaz deberá presentar las funciones principales de manera clara y organizada, facilitando que los estudiantes comprendan cómo navegar por la plataforma, consultar publicaciones, participar en grupos y utilizar la mensajería.

**Criterio de verificación:** Solicitar a usuarios de prueba que realicen tareas representativas sin instrucciones detalladas y registrar los problemas de navegación o comprensión identificados.

**Prioridad:** Media.

### RNF-07. Mantenibilidad

**Descripción:** El código fuente deberá organizarse de forma clara y modular, utilizando nombres consistentes y documentación técnica básica que facilite la comprensión, corrección y modificación del sistema por parte del equipo.

**Criterio de verificación:** Revisar la estructura del proyecto, la organización de sus componentes, la consistencia de los nombres y la existencia de instrucciones para ejecutar y mantener la aplicación.

**Prioridad:** Media.

### RNF-08. Verificabilidad y pruebas

**Descripción:** Los requerimientos de NEXO deberán poder comprobarse mediante pruebas, inspecciones o revisiones documentadas, de acuerdo con la naturaleza de cada requisito.

**Criterio de verificación:** Verificar que cada requerimiento no funcional cuente con un criterio de comprobación y registrar el resultado de las pruebas realizadas.

**Prioridad:** Alta.

### RNF-09. Viabilidad técnica y alcance del MVP

**Descripción:** La implementación de NEXO deberá ajustarse a los recursos técnicos, humanos y temporales disponibles, priorizando las funciones esenciales de la versión 1.0 y evitando incorporar características que excedan el alcance aprobado.

**Criterio de verificación:** Revisar las funcionalidades implementadas contra el alcance definido del proyecto y documentar cualquier ampliación o cambio que requiera aprobación del equipo.

**Prioridad:** Alta.

### RNF-10. Supervisión de la moderación asistida por inteligencia artificial

**Descripción:** El mecanismo de moderación asistida por inteligencia artificial deberá identificar y señalar contenido potencialmente problemático para su revisión humana. Sus resultados deberán tratarse como indicios que requieren evaluación y no como determinaciones definitivas.

**Criterio de verificación:** Utilizar casos de prueba con contenido permitido y potencialmente problemático, comprobar que el sistema genere las señales previstas y verificar que la decisión final de moderación corresponda a una persona autorizada, sin bloqueo ni eliminación automática por parte del mecanismo de IA.

**Prioridad:** Alta.

### RNF-11. Compatibilidad con el entorno definido

**Descripción:** La plataforma deberá funcionar en los navegadores y dispositivos que el equipo establezca como compatibles para las pruebas de la versión 1.0, manteniendo accesibles las funciones principales dentro de las condiciones previstas.

**Criterio de verificación:** Ejecutar pruebas de las funciones principales en los navegadores y dispositivos incluidos en la lista de compatibilidad acordada por el equipo.

**Prioridad:** Media.

## 4. Criterios generales de cumplimiento

Para considerar cumplidos los requerimientos no funcionales, se deberán observar las siguientes condiciones:

- Cada requerimiento deberá contar con evidencia de verificación.
- Los resultados de las pruebas deberán documentarse.
- Los problemas identificados deberán registrarse para su corrección o seguimiento.
- Las métricas pendientes, como los tiempos máximos de respuesta y los navegadores compatibles, deberán acordarse antes de la validación final.
- Los cambios en los requerimientos deberán revisarse y aprobarse por el equipo responsable del proyecto.

## 5. Consideraciones y restricciones

Los requerimientos establecidos corresponden al alcance inicial de NEXO y podrán ajustarse conforme avance el desarrollo y se obtengan resultados de las pruebas.

La definición de valores cuantitativos para el rendimiento, la compatibilidad y otros aspectos de calidad deberá basarse en las capacidades del entorno de prueba y en los acuerdos del equipo.

La moderación asistida por inteligencia artificial no sustituirá la supervisión humana ni tomará decisiones automáticas de bloqueo o eliminación de contenido en la versión 1.0.

## 6. Estado del documento

Este documento se encuentra en estado de borrador y deberá revisarse con el equipo de desarrollo antes de su aprobación. Una vez validados los criterios y las prioridades, podrá actualizarse a la versión correspondiente.

---

