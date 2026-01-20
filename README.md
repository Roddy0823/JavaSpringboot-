# Gestor de Pensum - Proyecto Spring Boot

## Descripción General
Este software es una aplicación web diseñada para la **Gestión de Pensum Académico**. Permite a los estudiantes registrarse, iniciar sesión y llevar un control detallado de su progreso académico.

### Características Principales
*   **Gestión de Usuarios**: Registro y autenticación segura (Login).
*   **Control de Materias**: Listado de materias organizado por semestres.
*   **Validación de Prerrequisitos**: El sistema impide aprobar una materia si sus prerrequisitos no han sido aprobados previamente.
*   **Cálculo de Progreso**: Visualización del porcentaje de avance en la carrera.
*   **Persistencia de Datos**: Base de datos local que conserva la información incluso después de reiniciar el equipo.

---

## Instrucciones de Ejecución

Este proyecto ha sido diseñado para ser **100% portable y fácil de ejecutar**. No requiere instalaciones complejas previas de Maven o bases de datos externas.

### Requisitos Previos
*   **Java 8** o superior instalado en el sistema.

### Pasos para Ejecutar (Windows)

1.  **Ubicar el Script de Inicio**:
    En la carpeta principal del proyecto, localice el archivo `run_springboot.ps1`.

2.  **Ejecutar el Script**:
    Haga clic derecho sobre el archivo y seleccione "Ejecutar con PowerShell".
    *   *Nota*: La primera vez que se ejecute, el sistema descargará automáticamente las dependencias necesarias. Esto puede tardar unos minutos dependiendo de su velocidad de internet.

3.  **Acceder a la Aplicación**:
    Una vez que vea el mensaje "Aplicación disponible en...", abra su navegador web y vaya a:
    
    👉 **[http://localhost:8082](http://localhost:8082)**

---

## Arquitectura del Proyecto

El proyecto sigue el patrón de diseño **MVC (Modelo-Vista-Controlador)** utilizando el framework **Spring Boot**.

### Estructura de Carpetas

*   `src/main/java`: Contiene el código fuente Java.
    *   `controller`: Controladores que manejan las peticiones web (Rutas).
    *   `model`: Clases que representan las tablas de la base de datos (Entidades como `Usuario`, `Materia`).
    *   `repository`: Interfaces para la comunicación con la base de datos.
    *   `service`: (Opcional) Lógica de negocio.
*   `src/main/resources`: Archivos de configuración y estáticos.
    *   `templates`: Vistas HTML/JSP de la interfaz de usuario.
    *   `static`: Archivos CSS, JS e imágenes.
    *   `application.properties`: Configuración principal (Puerto, Base de datos).
*   `data/`: Carpeta donde se almacena físicamente la base de datos local (H2). **¡No borrar!**
*   `deps/`: Carpeta que contiene las herramientas de compilación (Maven portatil).

## Datos Técnicos

*   **Lenguaje**: Java 8+
*   **Framework**: Spring Boot 2.7.18
*   **Base de Datos**: H2 Database (Modo archivo, persistente).
*   **Puerto por defecto**: `8082` (Configurado para evitar conflictos con el puerto 8080 común).
*   **Seguridad**: Spring Security (Encriptación de contraseñas con BCrypt).

## Solución de Problemas Frecuentes

### 1. "El puerto ya está en uso"
Si al iniciar recibe un error indicando que el puerto 8082 está ocupado, puede cambiarlo editando el archivo:
`src/main/resources/application.properties`
Busque la línea `server.port=8082` y cambie el número.

### 2. Perdí mi contraseña
Como es un entorno de desarrollo local, puede borrar la carpeta `data/` para reiniciar la base de datos completamente. Esto borrará todos los usuarios y materias, permitiéndole registrarse de nuevo desde cero.

---
**Desarrollado para la Evidencia GA7-220501096-AA3-EV01 - ADSO SENA**
