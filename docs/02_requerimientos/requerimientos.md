<<<<<<< HEAD
# Requerimientos de NEXO V1

| Campo | Valor |
|---|---|
| Estado | En elaboración |
| Versión | 1.0 |
| Fecha de creación | 05/09/2026 |
| Última actualización | 05/09/2026 |
| Elaboró | Ale — Product Owner |
| Última actualización por | Ale — Product Owner |
| Responsable | Ale — Product Owner |

## Historial de cambios

| Fecha | Versión | Cambio | Realizado por |
|---|---:|---|---|
| 05/09/2026 | 1.0 | Creación del documento maestro de requerimientos de NEXO V1 | Ale — Product Owner |

## 1. Propósito

Este documento concentra los requerimientos generales de **NEXO V1** y establece la base para la especificación posterior de requisitos funcionales, no funcionales, reglas de negocio, historias de usuario, criterios de aceptación y trazabilidad.

Su finalidad es describir las necesidades que justifican el producto, relacionarlas con el alcance aprobado y mantener una base consistente para la definición formal del sistema.

## 2. Fuentes de información

### 2.1 Alcance de NEXO V1

La definición del alcance aprobado de NEXO V1 se encuentra en:

- [`../01_proyecto/alcance.md`](../01_proyecto/alcance.md)

Este documento establece las capacidades que forman parte del núcleo funcional de la V1 y las que quedan fuera de ese alcance.

### 2.2 Encuesta a estudiantes

Se analizaron 13 respuestas de estudiantes para identificar necesidades, barreras de participación y oportunidades de diseño orientadas a la comunidad estudiantil.

La información recopilada se utilizó como evidencia para la formulación de necesidades y requisitos generales. No se incorporan datos personales ni correos electrónicos de los participantes.

### 2.3 Análisis del problema

El análisis del problema se fundamenta en la documentación existente del proyecto, incluida la síntesis de hallazgos y problemáticas identificadas en:

- [`../03_analysis/analysis.md`](../03_analysis/analysis.md)

Este análisis aporta la base para establecer necesidades y objetivos que posteriormente se convierten en requerimientos generales.

## 3. Necesidades identificadas

Las necesidades que se consolidan a continuación están sustentadas en la evidencia de la encuesta y en la interpretación del problema documentado. Se presentan de forma general para evitar convertir respuestas puntuales en funcionalidades específicas sin validación posterior.

### N-01 — Resolver dudas académicas

Existe una necesidad de plantear y resolver dudas relacionadas con materias y aprendizaje en un entorno común para la comunidad estudiantil.

Evidencia:

- 8 de 13 participantes seleccionaron "dudas" entre los problemas que una plataforma debería ayudar a resolver.
- 6 de 13 seleccionaron "publicar/responder preguntas".
- 5 de 13 indicaron interés en resolver dudas con otros estudiantes.

### N-02 — Encontrar información académica rápidamente

Existe una necesidad de localizar información útil de manera oportuna y reducir la dispersión de recursos, referencias y respuestas.

Evidencia:

- 10 de 13 seleccionaron "información rápida".
- 10 de 13 calificaron como "Regular" la facilidad para localizar información vista anteriormente.

### N-03 — Encontrar y compartir recursos académicos

Existe una necesidad de disponer de materiales académicos en un mismo entorno, con posibilidad de compartirlos entre estudiantes.

Evidencia:

- Apuntes: 6 de 13.
- Tutoriales: 5 de 13.
- Ejercicios: 5 de 13.
- Encontrar recursos: 5 de 13.

### N-04 — Localizar contenido mediante criterios académicos

Existe una necesidad de encontrar contenido utilizando categorías y criterios relevantes para el estudiante.

Evidencia:

- Tema: 6 de 13.
- Categorías: 6 de 13.
- Materia: 4 de 13.
- Palabras clave: 3 de 13.

### N-05 — Facilitar colaboración e interacción entre estudiantes

Existe una necesidad de contar con un espacio que apoye el estudio, la resolución de dudas, el intercambio de conocimiento y la colaboración en proyectos.

Evidencia:

- Compartir conocimientos: 6 de 13.
- Proyectos: 5 de 13.
- Estudiar: 4 de 13.
- Resolver dudas: 4 de 13.
- Intereses similares: 4 de 13.

### N-06 — Reducir barreras para iniciar interacción

La interacción con otros estudiantes presenta barreras sociales para algunos participantes. Esta necesidad no debe traducirse automáticamente en una funcionalidad específica de recomendaciones, coincidencias, conexiones o soluciones de recomendación automática.

Evidencia:

- Pena al buscar ayuda: 6 de 13.
- Pena/inseguridad como impedimento para participar: 7 de 13.
- No saber con quién interactuar: 5 de 13.
- Facilidad para conocer estudiantes con intereses similares: 9 de 13 la calificaron como "Regular".

## 4. Objetivos de NEXO V1

Los objetivos de NEXO V1 se derivan del alcance aprobado y de las necesidades identificadas. Su finalidad es concreta y verificable: responder a una necesidad comunitaria estudiantil mediante un núcleo funcional integrado, sin ampliar el alcance más allá de la V1.

### O-01 — Establecer identidad estudiantil en la plataforma

Permitir que cada usuario cuente con un perfil básico que represente su identidad dentro de la comunidad y facilite la interacción.

### O-02 — Facilitar la publicación y consulta de contenido relevante

Permitir a los usuarios crear y consultar publicaciones orientadas a la comunidad estudiantil, con la información necesaria para apoyar la interacción y el intercambio de conocimiento.

### O-03 — Apoyar la comunicación directa entre estudiantes

Permitir el intercambio privado y la conversación en un entorno controlado dentro de la plataforma.

### O-04 — Organizar la interacción por grupos

Facilitar la creación y participación en grupos internos para apoyar la colaboración, la organización y el intercambio dentro de espacios definidos.

### O-05 — Habilitar intercambio de recursos dentro de los espacios permitidos

Permitir compartir archivos vinculados a la comunicación y la colaboración dentro de la V1.

### O-06 — Proporcionar mecanismos básicos de moderación

Incorporar una capacidad de revisión y señalamiento de contenido potencialmente problemático con apoyo de inteligencia artificial, manteniendo la supervisión humana.

### O-07 — Operar en un entorno local inicial

Permitir la operación inicial de la plataforma dentro de una red Wi-Fi o local, conforme a la definición del alcance de la V1.

## 5. Requerimientos generales

Los requerimientos generales que se listan a continuación derivan del alcance aprobado y de las necesidades previamente identificadas. Se mantienen dentro del núcleo funcional de NEXO V1 y no incluyen capacidades fuera del alcance.

| ID | Requerimiento | Fuente | Prioridad |
|---|---|---|---|
| RG-01 | Perfil básico de estudiante | Alcance de NEXO V1; N-05; N-06 | Alta |
| RG-02 | Publicación de contenido académico y comunitario | Alcance de NEXO V1; N-01; N-02; N-05 | Alta |
| RG-03 | Consulta e interacción con publicaciones | Alcance de NEXO V1; N-01; N-02; N-03; N-05 | Alta |
| RG-04 | Localización de contenido académico y comunitario | Alcance de NEXO V1; N-02; N-03; N-04 | Alta |
| RG-05 | Intercambio de archivos dentro de espacios habilitados | Alcance de NEXO V1; N-03; N-05 | Alta |
| RG-06 | Grupos internos para colaboración y comunicación | Alcance de NEXO V1; N-05; N-06 | Alta |
| RG-07 | Mensajería privada entre usuarios | Alcance de NEXO V1; N-01; N-05; N-06 | Alta |
| RG-08 | Moderación asistida por IA | Alcance de NEXO V1; N-06 | Alta |
| RG-09 | Operación inicial mediante Wi-Fi/red local | Alcance de NEXO V1 | Alta |

### Nota metodológica

La prioridad de estos requerimientos es alta porque las capacidades asociadas forman parte del alcance explicitado de NEXO V1 y no se identifican justificaciones documentadas para una prioridad distinta en esta etapa.

## 6. Priorización

Se utilizarán únicamente las siguientes categorías de prioridad:

- Alta
- Media
- Baja

En esta etapa, las capacidades explícitamente incluidas en el alcance de NEXO V1 se consideran de prioridad alta, salvo una justificación formal posterior. En la presente versión del documento no se identifican razones documentadas para reducir la prioridad de ninguna de las capacidades del núcleo funcional.

## 7. Trazabilidad inicial

La siguiente tabla relaciona necesidades identificadas con los requerimientos generales que tienen evidencia suficiente de soporte en el alcance y la investigación documental disponible.

| Necesidad | Requerimiento | Fuente |
|---|---|---|
| N-01 — Resolver dudas académicas | RG-02 — Publicación de contenido académico y comunitario; RG-03 — Consulta e interacción con publicaciones; RG-07 — Mensajería privada entre usuarios | Encuesta; alcance |
| N-02 — Encontrar información académica rápidamente | RG-03 — Consulta e interacción con publicaciones; RG-04 — Localización de contenido académico y comunitario | Encuesta; alcance |
| N-03 — Encontrar y compartir recursos académicos | RG-04 — Localización de contenido académico y comunitario; RG-05 — Intercambio de archivos dentro de espacios habilitados | Encuesta; alcance |
| N-04 — Localizar contenido mediante criterios académicos | RG-04 — Localización de contenido académico y comunitario | Encuesta; alcance |
| N-05 — Facilitar colaboración e interacción entre estudiantes | RG-01 — Perfil básico de estudiante; RG-02 — Publicación de contenido académico y comunitario; RG-06 — Grupos internos para colaboración y comunicación; RG-07 — Mensajería privada entre usuarios | Encuesta; alcance |
| N-06 — Reducir barreras para iniciar interacción | RG-01 — Perfil básico de estudiante; RG-06 — Grupos internos para colaboración y comunicación; RG-07 — Mensajería privada entre usuarios | Encuesta; alcance |

## 8. Consideraciones para la siguiente especificación

Este documento establece los requerimientos generales de NEXO V1. A partir de aquí, la especificación detallada se desarrollará en documentos dedicados que definirán comportamiento, restricciones y validación sin duplicar el contenido del presente documento.

Los documentos subsecuentes serán:

- Requisitos funcionales
- Requisitos no funcionales
- Reglas de negocio
- Historias de usuario
- Criterios de aceptación
- Matriz de trazabilidad

La intención es mantener este documento como base general de la visión del producto y no sustituir la especificación detallada que corresponde a cada dimensión del sistema.

## 9. Control documental

| Campo | Valor |
|---|---|
| Estado | En elaboración |
| Versión | 1.0 |
| Fecha de creación | 05/09/2026 |
| Última actualización | 05/09/2026 |
| Elaboró | Ale — Product Owner |
| Última actualización por | Ale — Product Owner |
| Responsable | Ale — Product Owner |

### Revisión del documento

Este documento se mantiene alineado con el alcance aprobado de NEXO V1 y con la evidencia disponible de la encuesta y el análisis del problema. Toda modificación posterior debe conservar la trazabilidad entre evidencia, necesidad y requerimiento general.

No se incorporan funcionalidades no contempladas en el alcance aprobado ni decisiones técnicas que correspondan a arquitectura o diseño detallado.

### Regla de control de cambios

Cualquier cambio en el alcance funcional debe:

1. Ser justificado con evidencia o necesidad documentada.
2. Evaluar impacto sobre el MVP.
3. Identificar qué capacidad del producto se afecta.
4. Mantener trazabilidad con la finalidad del producto.
5. Ser aprobado antes de incorporarse al backlog o a la especificación formal.

## Cierre

Este documento sirve como referencia general para la definición del sistema y como base formal para las especificaciones posteriores. Su contenido debe mantenerse consistente con el alcance aprobado de la V1 y con la evidencia que soporta la necesidad del producto.
=======
# NEXO — Plataforma Comunitaria Estudiantil

**Documento:** Requerimientos del sistema

**Estado:** Borrador  
**Versión:** 1.0  
**Fecha de creación:** 11 de octubre de 2026  
**Última actualización:** 11 de octubre de 2026

## 1. Propósito del documento

Definir los requerimientos funcionales y no funcionales de NEXO V1, estableciendo las capacidades que deberá ofrecer el sistema y las condiciones necesarias para su implementación y validación.

## 2. Fuentes de los requerimientos

Los requerimientos se derivan de las siguientes fuentes:

- Documento de alcance de NEXO V1.
- Encuesta de necesidades estudiantiles.
- Documento de hallazgos y necesidades.
- Criterios generales de éxito del proyecto.
- Restricciones técnicas y operativas del MVP.

El alcance aprobado constituye la referencia principal para determinar las funcionalidades incluidas en la V1.

## 3. Requerimientos funcionales

Los requerimientos funcionales describen las acciones y capacidades que deberá proporcionar el sistema.

### 3.1 Perfiles de usuario

**RF-01. Gestión de perfiles**

El sistema deberá permitir que cada usuario cuente con un perfil básico que lo represente dentro de la comunidad estudiantil.

**RF-02. Información del perfil**

El sistema deberá permitir visualizar la información básica definida para el perfil del usuario. Los datos obligatorios y opcionales deberán establecerse durante el análisis detallado.

### 3.2 Publicaciones

**RF-03. Creación de publicaciones**

El sistema deberá permitir que los usuarios creen publicaciones dentro de la comunidad.

**RF-04. Consulta de publicaciones**

El sistema deberá permitir consultar las publicaciones disponibles y visualizar su contenido y autor.

**RF-05. Interacciones básicas**

El sistema podrá incorporar interacciones básicas en las publicaciones si el equipo las confirma como parte de la V1.

### 3.3 Grupos internos

**RF-06. Gestión de grupos**

El sistema deberá permitir crear o gestionar grupos de acuerdo con los permisos definidos para la V1.

**RF-07. Incorporación de integrantes**

El sistema deberá permitir incorporar usuarios a los grupos y visualizar a sus integrantes.

**RF-08. Comunicación grupal**

El sistema deberá permitir publicar contenido o comunicarse dentro de los grupos.

### 3.4 Mensajería privada

**RF-09. Inicio de conversaciones**

El sistema deberá permitir iniciar una conversación privada entre usuarios.

**RF-10. Envío y recepción de mensajes**

El sistema deberá permitir enviar y recibir mensajes dentro de una conversación privada.

**RF-11. Historial de conversaciones**

El sistema deberá permitir consultar el historial de mensajes de una conversación.

### 3.5 Compartición de archivos

**RF-12. Compartición de archivos**

El sistema deberá permitir compartir archivos en los espacios autorizados de la V1, específicamente en conversaciones privadas y grupos.

**RF-13. Validación de archivos**

El sistema deberá aplicar las validaciones y restricciones de archivos que se definan para la V1, incluyendo formatos y tamaño máximo permitido.

### 3.6 Moderación asistida por inteligencia artificial

**RF-14. Detección de contenido potencialmente problemático**

El sistema deberá incorporar un mecanismo de inteligencia artificial que permita identificar contenido potencialmente problemático.

**RF-15. Señalamiento de contenido**

El sistema deberá permitir señalar contenido identificado por el mecanismo de moderación para su revisión.

**RF-16. Revisión humana**

El sistema deberá contemplar la revisión humana de los casos señalados por la moderación asistida por IA.

### 3.7 Operación en red local

**RF-17. Funcionamiento en red local**

El sistema deberá permitir la operación de la V1 dentro del entorno de red Wi-Fi o local establecido para el proyecto.

## 4. Requerimientos no funcionales

Los requerimientos no funcionales describen las condiciones de calidad, seguridad y operación que deberá cumplir el sistema.

**RNF-01. Seguridad**

La solución deberá contemplar controles de seguridad adecuados para los perfiles, las conversaciones, los grupos y los archivos compartidos. Los controles específicos deberán definirse durante el diseño técnico.

**RNF-02. Privacidad**

La solución deberá considerar la protección de la información de los usuarios y el acceso autorizado a las conversaciones y los archivos.

**RNF-03. Operación**

La implementación deberá ser compatible con la infraestructura de red local prevista para la V1.

**RNF-04. Validación**

Los requerimientos implementados deberán contar con escenarios de prueba y criterios de aceptación verificables.

**RNF-05. Viabilidad técnica**

La solución deberá mantener una complejidad compatible con los recursos y las capacidades del equipo de desarrollo.

**Nota:** los requerimientos no funcionales anteriores son una base inicial. Los niveles de rendimiento, las medidas específicas de seguridad y las condiciones de disponibilidad deberán definirse antes de considerarlos requisitos verificables definitivos.

## 5. Prioridades iniciales

| Prioridad | Criterio |
|---|---|
| Alta | Capacidad comprometida en el núcleo funcional de la V1. |
| Media | Elemento condicionado a una decisión del equipo o a la definición de permisos y reglas. |
| Pendiente | Requerimiento que necesita mayor definición antes de asignar una prioridad definitiva. |

Las capacidades principales —perfiles, publicaciones, grupos, mensajería privada, archivos, moderación asistida por IA y operación local— tendrán prioridad alta por estar contempladas expresamente en el alcance.

Las interacciones básicas en publicaciones, los datos opcionales del perfil y las reglas detalladas de permisos deberán confirmarse antes de cerrar sus especificaciones.

## 6. Decisiones pendientes

Antes de aprobar los requerimientos, el equipo deberá definir:

- Mecanismo de autenticación e identificación de usuarios.
- Datos obligatorios y opcionales de los perfiles.
- Permisos para crear, administrar y participar en grupos.
- Reglas para modificar o eliminar publicaciones y mensajes.
- Formatos, tamaño máximo, almacenamiento y eliminación de archivos.
- Criterios de detección y flujo de revisión de la moderación con IA.
- Controles de acceso y protección de datos.
- Condiciones técnicas de operación en la red local.
- Criterios de aceptación y casos de prueba para cada requerimiento.

## 7. Trazabilidad

Cada requerimiento deberá relacionarse con su fuente, prioridad, historia de usuario o caso de uso y criterio de aceptación correspondiente.

La matriz de trazabilidad permitirá verificar que las necesidades del proyecto se encuentren atendidas sin incorporar funcionalidades fuera del alcance aprobado.

## 8. Control de cambios

Cualquier requerimiento que implique ampliar el alcance de NEXO V1 deberá evaluarse y aprobarse antes de incorporarse a la planificación o al desarrollo.

Los requerimientos podrán refinarse durante el proyecto, conservando su identificación y trazabilidad con las necesidades, los objetivos y los criterios de aceptación.
>>>>>>> 0cc91ef (Requerimientos)
