<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Formulario de Estudiante</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
            </head>

            <body>
                <div class="container">
                    <h1>Gestor de Pensum</h1>
                    <!-- Lógica simple para el título: si id no es nulo, es Editar -->
                    <h2>
                        <c:out value="${estudiante.id != null ? 'Editar Estudiante' : 'Nuevo Estudiante'}" />
                    </h2>

                    <form:form action="${pageContext.request.contextPath}/guardar" modelAttribute="estudiante"
                        method="POST">
                        <!-- Campo oculto para ID -->
                        <form:hidden path="id" />

                        <div class="campo">
                            <label>Nombre Completo:</label>
                            <form:input path="nombre" required="required" placeholder="Ej: Pepito Pérez" />
                        </div>

                        <div class="campo">
                            <label>Correo Electrónico:</label>
                            <form:input path="correo" type="email" required="required"
                                placeholder="Ej: pepito@sena.edu.co" />
                        </div>

                        <div class="campo">
                            <label>Semestre:</label>
                            <form:input path="semestre" type="number" required="required" min="1" max="10" />
                        </div>

                        <div class="botones">
                            <button type="submit" class="boton boton-primario">Guardar</button>
                            <a href="${pageContext.request.contextPath}/" class="boton boton-eliminar">Cancelar</a>
                        </div>
                    </form:form>
                </div>
            </body>

            </html>