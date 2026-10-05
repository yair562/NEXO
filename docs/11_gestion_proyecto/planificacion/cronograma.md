# Cronograma del proyecto NEXO

## 1. Propósito

Este documento organiza y controla la ejecución de NEXO V1. Las actividades se derivan del alcance aprobado y de la documentación del proyecto, y se relacionan con responsables, dependencias, entregables, estado y evidencia documental.

## 2. Criterios de planificación

- El cronograma se deriva del alcance aprobado.
- Cada actividad corresponde a un entregable, documento o necesidad real del proyecto.
- No se incorporan funcionalidades fuera del alcance aprobado.
- Las dependencias se respetan antes de iniciar actividades que requieran resultados previos.
- Los cambios de alcance se evalúan antes de convertirse en tareas.
- El cronograma se actualiza conforme avance el proyecto.
- Cada actividad conserva trazabilidad con la documentación correspondiente.

## 3. Estado actual

| Actividad | Estado |
|---|---|
| Logo de empresa | Completado |
| Logo de producto NEXO | Completado |
| Definición del alcance V1 | Completado |
| Fichas de rol | En progreso |
| Requerimientos | Pendiente |
| Análisis del sistema | Pendiente |
| Modelado del sistema | Pendiente |
| UX/UI | Pendiente |
| Arquitectura | Pendiente |
| Diseño técnico | Pendiente |
| Implementación | Pendiente |
| Pruebas | Pendiente |
| Validación del MVP | Pendiente |

## 4. Cronograma maestro

Los estados utilizados son: **Completado**, **En progreso** y **Pendiente**. No se incluyen fechas hasta que sean definidas por el equipo.

| ID | Fase | Actividad | Responsable | Dependencia | Entregable | Referencia | Estado |
|---|---|---|---|---|---|---|---|
| F1-01 | Definición del proyecto | Identidad del proyecto | Equipo | — | Identidad inicial documentada | `docs/06_identidad/identidad_visual.md` | Completado |
| F1-02 | Definición del proyecto | Creación de identidad visual inicial | Equipo | F1-01 | Logo de empresa y lineamientos iniciales | `docs/06_identidad/manual_identidad.md` | Completado |
| F1-03 | Definición del proyecto | Definición del alcance V1 | Ale — Product Owner (PO) | F1-01 | Alcance aprobado | `docs/01_proyecto/alcance.md` | Completado |
| F1-04 | Definición del proyecto | Elaboración de fichas de rol | Equipo | F1-01 | Fichas de rol del equipo | `docs/11_gestion_proyecto/equipo/fichas_roles/` | En progreso |
| F1-05 | Definición del proyecto | Organización del equipo | Equipo | F1-04 | Organización de responsabilidades | `docs/11_gestion_proyecto/equipo/fichas_roles/` | Pendiente |
| F2-01 | Requerimientos | Revisión de necesidades identificadas | Ale — Product Owner (PO) | F1-03 | Necesidades revisadas | `docs/03_analisis/analysis.md` | Pendiente |
| F2-02 | Requerimientos | Consolidación de hallazgos | Ale — Product Owner (PO) | F2-01 | Hallazgos consolidados | `docs/03_analisis/analysis.md` | Pendiente |
| F2-03 | Requerimientos | Identificación de necesidades funcionales | Ale — Product Owner (PO) | F2-02 | Necesidades funcionales documentadas | `docs/03_analisis/analysis.md` | Pendiente |
| F2-04 | Requerimientos | Priorización de necesidades | Ale — Product Owner (PO) | F2-03 | Prioridades de necesidades | `docs/03_analisis/analysis.md` | Pendiente |
| F2-05 | Requerimientos | Elaboración de requerimientos funcionales | Por asignar | F2-04 | Requerimientos funcionales | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F2-06 | Requerimientos | Elaboración de requerimientos no funcionales | Por asignar | F2-04 | Requerimientos no funcionales | `docs/02_requerimientos/requisitos_no_funcionales.md` | Pendiente |
| F2-07 | Requerimientos | Elaboración de historias de usuario | Por asignar | F2-05 | Historias de usuario | `docs/02_requerimientos/historias_usuario.md` | Pendiente |
| F2-08 | Requerimientos | Definición de criterios de aceptación | Ale — Product Owner (PO) | F2-05, F2-07 | Criterios de aceptación | `docs/02_requerimientos/criterios_aceptacion.md` | Pendiente |
| F2-09 | Requerimientos | Priorización de requisitos | Ale — Product Owner (PO) | F2-05, F2-06, F2-07 | Requisitos priorizados | `docs/02_requerimientos/requerimientos.md` | Pendiente |
| F2-10 | Requerimientos | Validación de requisitos | Equipo | F2-08, F2-09 | Requisitos validados | `docs/02_requerimientos/matriz_trazabilidad.md` | Pendiente |
| F3-01 | Análisis y modelado | Identificación de actores | Por asignar | F2-10 | Actores identificados | `docs/04_modelado_sistema/actores.md` | Pendiente |
| F3-02 | Análisis y modelado | Identificación de interacciones principales | Por asignar | F3-01 | Interacciones principales | `docs/04_modelado_sistema/modelado_sistema.md` | Pendiente |
| F3-03 | Análisis y modelado | Definición de casos de uso | Por asignar | F3-02 | Casos de uso | `docs/04_modelado_sistema/casos_uso.md` | Pendiente |
| F3-04 | Análisis y modelado | Definición de flujos principales | Por asignar | F3-03 | Flujos principales | `docs/04_modelado_sistema/modelado_sistema.md` | Pendiente |
| F3-05 | Análisis y modelado | Elaboración del modelo conceptual | Por asignar | F3-03 | Modelo conceptual | `docs/04_modelado_sistema/modelado_sistema.md` | Pendiente |
| F3-06 | Análisis y modelado | Definición de reglas de negocio necesarias | Por asignar | F2-10 | Reglas de negocio | `docs/02_requerimientos/reglas_negocio.md` | Pendiente |
| F3-07 | Análisis y modelado | Validación del modelo | Equipo | F3-04, F3-05, F3-06 | Modelo validado | `docs/04_modelado_sistema/modelado_sistema.md` | Pendiente |
| F4-01 | UX/UI | Definición de arquitectura de información | Por asignar | F2-10 | Arquitectura de información | `docs/05_ux_ui/arquitectura_informacion.md` | Pendiente |
| F4-02 | UX/UI | Definición de flujos de usuario | Por asignar | F3-04, F4-01 | Flujos de usuario | `docs/05_ux_ui/user_flows.md` | Pendiente |
| F4-03 | UX/UI | Elaboración de wireframes | Por asignar | F4-02 | Wireframes | `docs/05_ux_ui/wireframes.md` | Pendiente |
| F4-04 | UX/UI | Diseño de interfaces | Por asignar | F4-03 | Propuesta de interfaces | `docs/05_ux_ui/prototipo.md` | Pendiente |
| F4-05 | UX/UI | Definición de componentes visuales necesarios | Por asignar | F4-04 | Componentes visuales documentados | `docs/05_ux_ui/design_system.md` | Pendiente |
| F4-06 | UX/UI | Validación de la propuesta de interfaz | Equipo | F4-05 | Propuesta UX/UI validada | `docs/05_ux_ui/validacion_ux.md` | Pendiente |
| F5-01 | Arquitectura | Definición de arquitectura del sistema | Por asignar | F2-10, F3-07 | Arquitectura del sistema | `docs/07_arquitectura/arquitectura.md` | Pendiente |
| F5-02 | Arquitectura | Identificación de componentes principales | Por asignar | F5-01 | Componentes principales | `docs/07_arquitectura/arquitectura_sistema.md` | Pendiente |
| F5-03 | Arquitectura | Definición de comunicación entre componentes | Por asignar | F5-02 | Comunicación entre componentes | `docs/07_arquitectura/arquitectura_aplicacion.md` | Pendiente |
| F5-04 | Arquitectura | Elaboración del modelo general de datos | Por asignar | F3-05, F5-02 | Modelo general de datos | `docs/07_arquitectura/arquitectura_datos.md` | Pendiente |
| F5-05 | Arquitectura | Definición de condiciones de operación en red Wi-Fi/local | Por asignar | F5-01 | Condiciones de operación | `docs/07_arquitectura/arquitectura_despliegue.md` | Pendiente |
| F5-06 | Arquitectura | Validación de la arquitectura | Equipo | F5-03, F5-04, F5-05 | Arquitectura validada | `docs/07_arquitectura/arquitectura.md` | Pendiente |
| F6-01 | Diseño técnico | Diseño de base de datos | Por asignar | F5-04, F2-10 | Diseño de datos | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F6-02 | Diseño técnico | Diseño de mecanismos de comunicación del sistema | Por asignar | F5-03, F2-10 | Mecanismos de comunicación definidos | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F6-03 | Diseño técnico | Diseño de autenticación y autorización | Por asignar | F3-01, F5-02 | Diseño de acceso | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F6-04 | Diseño técnico | Diseño de gestión de archivos | Por asignar | F2-05, F5-02 | Gestión de archivos diseñada | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F6-05 | Diseño técnico | Diseño del flujo de moderación asistida por IA | Por asignar | F2-05, F3-06, F5-02 | Flujo de moderación diseñado | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F6-06 | Diseño técnico | Consolidación de definiciones técnicas necesarias | Por asignar | F5-06, F6-01, F6-02, F6-03, F6-04, F6-05 | Diseño técnico consolidado | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F7-01 | Implementación | Implementación de perfiles | Por asignar | F4-06, F6-06 | Perfiles implementados | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-02 | Implementación | Implementación de publicaciones | Por asignar | F4-06, F6-06 | Publicaciones implementadas | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-03 | Implementación | Implementación de grupos | Por asignar | F4-06, F6-06 | Grupos implementados | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-04 | Implementación | Implementación de mensajería privada | Por asignar | F4-06, F6-06 | Mensajería implementada | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-05 | Implementación | Implementación de compartición de archivos | Por asignar | F4-06, F6-04 | Compartición de archivos implementada | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-06 | Implementación | Implementación de moderación asistida por IA | Por asignar | F4-06, F6-05 | Moderación implementada | `docs/02_requerimientos/requisitos_funcionales.md` | Pendiente |
| F7-07 | Implementación | Integración funcional del sistema | Equipo | F7-01, F7-02, F7-03, F7-04, F7-05, F7-06 | Núcleo funcional implementado | `docs/07_arquitectura/arquitectura.md` | Pendiente |
| F8-01 | Integración | Integración de módulos | Equipo | F7-07 | Módulos integrados | `docs/10_pruebas/plan_pruebas.md` | Pendiente |
| F8-02 | Integración | Integración de persistencia de datos | Por asignar | F7-07 | Persistencia integrada | `docs/07_arquitectura/arquitectura_datos.md` | Pendiente |
| F8-03 | Integración | Integración de autenticación | Por asignar | F7-01, F7-07 | Acceso integrado | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F8-04 | Integración | Integración de archivos | Por asignar | F7-05, F7-07 | Archivos integrados | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F8-05 | Integración | Integración de moderación | Por asignar | F7-06, F7-07 | Moderación integrada | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F8-06 | Integración | Preparación del entorno funcional | Por asignar | F5-05, F8-01 | Entorno funcional preparado | `docs/07_arquitectura/arquitectura_despliegue.md` | Pendiente |
| F8-07 | Integración | Verificación del flujo integrado del MVP | Equipo | F8-02, F8-03, F8-04, F8-05, F8-06 | Flujo integrado verificado | `docs/10_pruebas/plan_pruebas.md` | Pendiente |
| F9-01 | Pruebas | Preparación de pruebas | Por asignar | F2-08, F8-07 | Plan y casos de prueba | `docs/10_pruebas/plan_pruebas.md` | Pendiente |
| F9-02 | Pruebas | Ejecución de pruebas funcionales | Por asignar | F9-01, F8-07 | Resultados funcionales | `docs/10_pruebas/pruebas_funcionales.md` | Pendiente |
| F9-03 | Pruebas | Ejecución de pruebas de integración | Por asignar | F9-01, F8-07 | Resultados de integración | `docs/10_pruebas/pruebas_integracion.md` | Pendiente |
| F9-04 | Pruebas | Validación de criterios de aceptación | Ale — Product Owner (PO) | F9-02, F9-03 | Criterios verificados | `docs/10_pruebas/pruebas_aceptacion.md` | Pendiente |
| F9-05 | Pruebas | Corrección de errores | Por asignar | F9-02, F9-03 | Errores corregidos | `docs/09_calidad/gestion_defectos.md` | Pendiente |
| F9-06 | Pruebas | Reejecución de pruebas después de correcciones | Por asignar | F9-05 | Pruebas reejecutadas | `docs/10_pruebas/casos_prueba.md` | Pendiente |
| F9-07 | Pruebas | Pruebas del flujo completo del MVP | Equipo | F9-04, F9-06 | Flujo completo verificado | `docs/10_pruebas/pruebas_aceptacion.md` | Pendiente |
| F10-01 | Validación y cierre | Validación del MVP | Ale — Product Owner (PO) | F9-07 | MVP validado | `docs/10_pruebas/pruebas_aceptacion.md` | Pendiente |
| F10-02 | Validación y cierre | Revisión contra el alcance | Ale — Product Owner (PO) | F10-01 | Revisión de alcance | `docs/01_proyecto/alcance.md` | Pendiente |
| F10-03 | Validación y cierre | Revisión de requisitos | Equipo | F10-01 | Requisitos revisados | `docs/02_requerimientos/matriz_trazabilidad.md` | Pendiente |
| F10-04 | Validación y cierre | Verificación de criterios de aceptación | Ale — Product Owner (PO) | F10-01 | Aceptación verificada | `docs/02_requerimientos/criterios_aceptacion.md` | Pendiente |
| F10-05 | Validación y cierre | Documentación técnica final | Por asignar | F10-02, F10-03 | Documentación técnica final | `docs/08_diseno_tecnico/diseno_tecnico.md` | Pendiente |
| F10-06 | Validación y cierre | Documentación básica de operación | Por asignar | F10-02, F10-03 | Documentación de operación | `docs/15_manuales/manual_usuario.md` | Pendiente |
| F10-07 | Validación y cierre | Cierre de la versión V1 | Ale — Product Owner (PO) | F10-04, F10-05, F10-06 | V1 cerrada | `docs/11_gestion_proyecto/seguimiento/seguimiento.md` | Pendiente |

## 5. Hitos

| Hito | Descripción | Dependencia principal | Estado |
|---|---|---|---|
| H1 — Alcance aprobado | Alcance de NEXO V1 definido y aprobado | F1-03 | Completado |
| H2 — Roles del equipo definidos | Fichas y responsabilidades formalizadas | F1-04, F1-05 | Pendiente |
| H3 — Requerimientos V1 definidos | Requisitos y criterios de aceptación validados | F2-10 | Pendiente |
| H4 — Modelado funcional completado | Actores, interacciones, flujos y modelo validados | F3-07 | Pendiente |
| H5 — UX/UI V1 definido | Flujos, wireframes, interfaces y validación completados | F4-06 | Pendiente |
| H6 — Arquitectura definida | Arquitectura y condiciones de operación validadas | F5-06 | Pendiente |
| H7 — Diseño técnico definido | Diseños técnicos necesarios consolidados | F6-06 | Pendiente |
| H8 — Núcleo funcional implementado | Capacidades de la V1 implementadas | F7-07 | Pendiente |
| H9 — Integración completada | Módulos y flujo integrado verificados | F8-07 | Pendiente |
| H10 — Pruebas completadas | Pruebas ejecutadas y correcciones verificadas | F9-07 | Pendiente |
| H11 — MVP validado | V1 revisada contra alcance y criterios de aceptación | F10-07 | Pendiente |

## 6. Actualización del cronograma

El cronograma es un documento vivo. Los estados, responsables, dependencias y fechas se actualizarán conforme avance el proyecto. Las modificaciones deberán conservar la trazabilidad con el alcance, los requisitos y los entregables correspondientes.

Cuando el equipo establezca fechas, la tabla podrá ampliarse con fecha de inicio, fecha de finalización y duración. Hasta entonces, no se registran fechas.

## 7. Control del cronograma

- Cada actividad debe mantener un estado actualizado.
- Los cambios importantes deben quedar registrados.
- Las actividades deben conservar su referencia documental.
- Una nueva funcionalidad no debe incorporarse directamente al cronograma si no está contemplada en el alcance.
- Toda funcionalidad propuesta debe evaluarse primero como cambio de alcance.
- El cronograma no debe utilizarse para modificar el alcance aprobado.
