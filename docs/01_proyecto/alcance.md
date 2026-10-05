# Alcance del proyecto NEXO

## 1. Propósito del documento

Este documento delimita el alcance de **NEXO V1**, una plataforma comunitaria para estudiantes del Tecnológico de Estudios Superiores de Huixquilucan (TESH).

La V1 se define como un **MVP funcional** que concentra un núcleo reducido de comunicación e interacción estudiantil. Su propósito es validar el concepto de una comunidad estudiantil integrada sin convertirse en una plataforma académica completa ni en una red social generalista.

## 2. Propósito del producto

NEXO proporcionará un espacio digital común donde los estudiantes puedan:

- Crear una identidad básica dentro de la comunidad.
- Publicar información.
- Interactuar mediante grupos.
- Comunicarse de forma privada.
- Compartir archivos relacionados con sus actividades.
- Participar en una comunidad con mecanismos básicos de moderación.

NEXO no pretende sustituir las plataformas institucionales ni resolver todos los problemas académicos de los estudiantes. Su propósito inicial es ofrecer un punto de encuentro digital propio para la comunidad estudiantil.

## 3. Problema que se busca atender

Los estudiantes utilizan distintos medios para comunicarse, compartir información y organizar actividades. Esta dispersión dificulta contar con un espacio común orientado específicamente a la comunidad estudiantil.

NEXO busca reducir esa fragmentación mediante un entorno controlado que concentre capacidades básicas de:

- Identidad estudiantil.
- Publicación de contenido.
- Comunicación privada.
- Organización mediante grupos.
- Intercambio de archivos.
- Interacción comunitaria.

## 4. Objetivo de la V1

Demostrar que una plataforma estudiantil puede proporcionar, dentro de un mismo entorno:

1. Perfiles básicos de usuario.
2. Publicaciones.
3. Mensajería privada.
4. Grupos internos.
5. Compartición de archivos.
6. Moderación asistida por inteligencia artificial.
7. Funcionamiento inicial dentro de una red Wi-Fi o local.

Estas capacidades constituyen el núcleo comprometido de la V1 y tendrán prioridad sobre cualquier funcionalidad secundaria.

## 5. Alcance incluido

### 5.1 Perfiles de usuario

Cada usuario contará con un perfil básico que permita representarlo dentro de la comunidad.

El perfil podrá incluir:

- Identificación del usuario.
- Información básica.
- Carrera, semestre o área, si se confirma en los requisitos.
- Intereses que favorezcan la interacción comunitaria.

La autenticación, los datos obligatorios, los permisos y el mecanismo de identificación se definirán en los requisitos. No se implementará información académica administrativa, como calificaciones o historial escolar.

### 5.2 Publicaciones

Los usuarios podrán crear y consultar publicaciones dentro de la comunidad.

La V1 contemplará como mínimo:

- Crear publicaciones.
- Consultar publicaciones.
- Visualizar el autor.
- Visualizar el contenido.
- Realizar interacciones básicas, si se priorizan en los requisitos.

No se requiere un algoritmo avanzado de recomendación o clasificación personalizada.

### 5.3 Grupos internos

Los usuarios podrán participar en grupos relacionados con una materia, interés, actividad, proyecto u otro propósito comunitario.

La V1 contemplará como mínimo:

- Crear o gestionar grupos según los permisos definidos.
- Incorporar usuarios.
- Visualizar integrantes.
- Publicar o comunicarse dentro del grupo.
- Compartir archivos relacionados con el grupo.

Los permisos de administradores y miembros se especificarán posteriormente.

### 5.4 Mensajería privada

NEXO incluirá comunicación privada entre usuarios.

La V1 permitirá como mínimo:

- Iniciar una conversación.
- Enviar mensajes.
- Recibir mensajes.
- Consultar el historial de una conversación.

Quedan fuera de esta primera versión las llamadas de voz, videollamadas, mensajes efímeros, reacciones avanzadas y otras funciones multimedia complejas.

### 5.5 Compartición de archivos

Los usuarios podrán compartir archivos dentro de los espacios permitidos por la V1:

- Conversaciones privadas.
- Grupos.
- Publicaciones, únicamente si se prioriza durante la especificación.

Quedan pendientes de definición técnica:

- Formatos permitidos.
- Tamaño máximo.
- Almacenamiento.
- Conservación y eliminación.
- Validación de archivos.
- Controles de seguridad.

La V1 no contempla un sistema avanzado de gestión documental.

### 5.6 Moderación asistida por inteligencia artificial

La V1 incorporará moderación asistida por IA para detectar contenido potencialmente problemático y apoyar su revisión.

La IA podrá utilizarse para:

- Detectar contenido.
- Clasificar posibles incidentes.
- Señalar publicaciones o mensajes para revisión.
- Apoyar a la persona responsable de moderación.

La IA no sustituirá la responsabilidad humana ni tomará decisiones académicas, disciplinarias o definitivas de forma autónoma. Los criterios de uso y el flujo de revisión se definirán en los requisitos y en la documentación técnica correspondiente.

### 5.7 Despliegue en red local

La V1 operará inicialmente dentro de un entorno de red Wi-Fi o local. Las condiciones específicas de despliegue y operación se documentarán en la arquitectura y en la documentación técnica correspondiente.

Esta condición corresponde al alcance operativo inicial y no representa una limitación permanente del producto. El acceso por Internet podrá evaluarse en versiones posteriores.

## 6. Flujo funcional mínimo

```text
Usuario
   |
   v
Perfil
   |
   +--------------> Publicaciones
   |
   +--------------> Mensajes privados
   |
   +--------------> Grupos
                         |
                         v
                    Archivos
                         |
                         v
                 Moderación asistida
                         por IA
```

Este flujo representa el núcleo funcional del MVP y servirá como referencia para requisitos, casos de uso, diseño y pruebas.

## 7. Entregables comprendidos

El proyecto contempla desarrollar progresivamente:

- Documentación del proyecto.
- Análisis de necesidades.
- Requisitos funcionales y no funcionales.
- Historias de usuario.
- Criterios de aceptación.
- Modelo de actores y casos de uso.
- Diseño UX/UI del MVP.
- Arquitectura del sistema.
- Diseño técnico.
- Implementación de la V1.
- Pruebas funcionales, de integración y aceptación.
- Documentación técnica y de operación básica.

La existencia de estos entregables no implica que se implementen capacidades fuera del núcleo definido en este documento.

## 8. Fuera de alcance de la V1

### 8.1 Sistema académico institucional

Quedan fuera:

- Control de calificaciones.
- Inscripción.
- Control escolar.
- Horarios institucionales automatizados.
- Evaluación docente.
- Emisión de certificados.
- Gestión académica administrativa.

### 8.2 Plataforma académica avanzada

Quedan fuera de la V1:

- Motor de búsqueda académica avanzado.
- Repositorio especializado de apuntes y tutoriales.
- Sistema completo de preguntas y respuestas académicas.
- Tutor académico autónomo.
- Generación automática de tareas o respuestas.
- Recomendaciones personalizadas.
- Analítica académica o predicción de desempeño.

Estas capacidades podrán evaluarse como evolución posterior, pero no forman parte del MVP.

### 8.3 Red social generalista

NEXO no se desarrollará como una red social pública de propósito general. Quedan fuera:

- Entretenimiento como objetivo principal.
- Publicidad.
- Monetización.
- Comercio electrónico.
- Relaciones comerciales.
- Sistema de influencers.

### 8.4 Comunicación avanzada

Quedan fuera:

- Llamadas de voz.
- Videollamadas.
- Transmisiones en vivo.
- Historias efímeras.
- Mensajes que desaparecen.
- Funciones multimedia avanzadas.

### 8.5 Capacidades de infraestructura avanzada

Quedan fuera de la V1:

- Infraestructura cloud de producción.
- Alta disponibilidad empresarial.
- Escalamiento masivo.
- Despliegue multinacional.

## 9. Restricciones del alcance

La implementación y validación de la V1 estarán condicionadas por:

1. **Equipo disponible:** cuatro integrantes con responsabilidades distribuidas.
2. **Complejidad técnica:** la solución deberá mantener una complejidad razonable para un MVP y ser compatible con las capacidades definidas.
3. **Infraestructura:** la primera versión utilizará una red Wi-Fi o local.
4. **Validación:** el núcleo deberá poder probarse mediante escenarios funcionales concretos y criterios de aceptación verificables.

El cronograma, las actividades y la asignación detallada de trabajo corresponden a la documentación de planificación del proyecto.

## 10. Criterios generales de éxito

El alcance de la V1 se considerará cubierto cuando pueda demostrarse que:

1. Un estudiante puede crear y utilizar un perfil.
2. Un usuario puede crear y consultar publicaciones.
3. Dos estudiantes pueden establecer una conversación privada.
4. Los usuarios pueden participar en un grupo.
5. Los usuarios pueden compartir archivos dentro de los espacios permitidos.
6. El sistema puede identificar contenido potencialmente problemático mediante el mecanismo de moderación definido.
7. La aplicación puede operar dentro del entorno Wi-Fi o local establecido.

Los criterios cuantitativos, condiciones de aceptación y casos de prueba se definirán en [Criterios de aceptación](../02_requerimientos/criterios_aceptacion.md) y en la documentación de [pruebas](../10_pruebas/).

## 11. Trazabilidad inicial

| Necesidad | Capacidad de la V1 | Prioridad |
|---|---|---|
| Identidad dentro de la comunidad | Perfil de usuario | Alta |
| Comunicación entre estudiantes | Mensajería privada | Alta |
| Compartición de información | Publicaciones | Alta |
| Organización de comunidades | Grupos internos | Alta |
| Colaboración e intercambio | Compartición de archivos | Alta |
| Participación segura | Moderación asistida por IA | Alta |
| Conectividad controlada | Despliegue en red Wi-Fi o local | Alta |
| Descubrimiento de estudiantes | Información básica del perfil | Media |

Esta tabla es una guía inicial. La relación definitiva entre necesidades, requisitos, historias de usuario y pruebas deberá mantenerse en la matriz de trazabilidad del proyecto.

## 12. Evolución posterior

Podrán considerarse para versiones posteriores, previa validación y aprobación:

- Acceso mediante Internet.
- Infraestructura cloud.
- Aplicaciones móviles nativas.
- Integración con plataformas institucionales.
- Búsqueda y organización académica avanzada.
- Repositorio de recursos educativos.
- Herramientas de colaboración ampliadas.
- Notificaciones avanzadas.
- Moderación automatizada más sofisticada.
- Analítica de comunidad.
- Escalabilidad para una población estudiantil mayor.

Estas capacidades no forman parte del compromiso de la V1.

## 13. Control del alcance

Cualquier funcionalidad, integración, usuario objetivo o entregable que no esté contemplado en este documento deberá evaluarse antes de incorporarse a la V1.

La solicitud deberá:

1. Registrar la necesidad y su justificación.
2. Evaluar el impacto en tiempo, complejidad, seguridad, datos, UX y arquitectura.
3. Identificar qué elemento del MVP modifica, retrasa o desplaza.
4. Obtener aprobación antes de incorporarse al backlog o a los requisitos.

El alcance podrá refinarse durante el proyecto, pero todo cambio deberá conservar la trazabilidad con los objetivos, las restricciones y las necesidades de los usuarios.
