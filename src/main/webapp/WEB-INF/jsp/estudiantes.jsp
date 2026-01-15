<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Gestor de Pensum - Estudiantes</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
        </head>

        <body>
            <div class="container">
                <h1>Gestor de Pensum</h1>
                <h2>Lista de Estudiantes</h2>

                <a href="${pageContext.request.contextPath}/nuevo" class="boton boton-primario">Agregar Nuevo
                    Estudiante</a>

                <br><br>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Correo Electrónico</th>
                            <th>Semestre</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listaEstudiantes}" var="estudiante">
                            <tr>
                                <td>
                                    <c:out value="${estudiante.id}" />
                                </td>
                                <td>
                                    <c:out value="${estudiante.nombre}" />
                                </td>
                                <td>
                                    <c:out value="${estudiante.correo}" />
                                </td>
                                <td>
                                    <c:out value="${estudiante.semestre}" />
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/editar/${estudiante.id}"
                                        class="boton boton-editar">Editar</a>
                                    <a href="${pageContext.request.contextPath}/eliminar/${estudiante.id}"
                                        class="boton boton-eliminar"
                                        onclick="return confirm('¿Estás seguro de eliminar este estudiante?')">Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>