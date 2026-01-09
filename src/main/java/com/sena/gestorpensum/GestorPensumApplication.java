package com.sena.gestorpensum;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Clase principal de arranque para la aplicación Spring Boot.
 * Inicia el contexto de Spring y el servidor Tomcat embebido.
 */
@SpringBootApplication
public class GestorPensumApplication {

    public static void main(String[] args) {
        SpringApplication.run(GestorPensumApplication.class, args);
    }

}
