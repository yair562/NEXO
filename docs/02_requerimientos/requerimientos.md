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
