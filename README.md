# Gestor de Pensum - Proyecto Spring Boot

## Descripción
Aplicación web para la gestión de pensum académico, desarrollada con Spring Boot y Thymeleaf.
Incluye autenticación por usuario, gestión de materias por semestre y validación estricta de prerrequisitos.

## Instrucciones para el Docente

Este proyecto es **auto-contenido**. Incluye un "Maven Wrapper" (`mvnw`) para asegurar que se pueda ejecutar en cualquier entorno con Java instalado, sin necesidad de configurar Maven manualmente.

### Opción 1: Ejecución desde Consola (Recomendado)

1.  Descomprima el archivo ZIP.
2.  Abra una terminal (CMD o PowerShell) en la carpeta del proyecto `GestorPensumSpringBoot`.
3.  Ejecute el siguiente comando para iniciar la aplicación:
    
    macOS / Linux:
    ```bash
    ./mvnw spring-boot:run
    ```

    Windows:
    ```powershell
    .\run_springboot.ps1
    ```

4.  Una vez iniciada, abra el navegador en: [http://localhost:8082](http://localhost:8082)

### Opción 2: Importar en IDE (Eclipse, IntelliJ, NetBeans)

1.  Abra su IDE preferido.
2.  Seleccione "Import Project" o "Open Project".
3.  Seleccione el archivo `pom.xml` ubicado en la raíz de esta carpeta.
4.  Deje que el IDE descargue las dependencias y luego ejecute la clase principal: `com.sena.gestorpensum.GestorPensumApplication`.

## Tecnologías
- **Java 8+**
- **Spring Boot 2.7.18**
- **H2 Database** (Base de datos en memoria, se crea automáticamente).
- **Spring Security**

## Credenciales
Puede registrar un usuario nuevo desde la pantalla de inicio o login.
