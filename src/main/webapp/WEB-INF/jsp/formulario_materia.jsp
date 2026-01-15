<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Materia - Gestor de Pensum</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
            </head>

            <body>
                <div class="container">
                    <h1>Gestor de Pensum</h1>
                    <h2>Datos de la Materia</h2>

                    <form:form action="${pageContext.request.contextPath}/materia/guardar" modelAttribute="materia"
                        method="post">
                        <form:hidden path="id" />
                        <!-- Mantenemos el estado original si existe, o el default -->
                        <form:hidden path="estado" />

                        <div class="campo">
                            <label>Nombre de la Materia:</label>
                            <form:input path="nombre" required="required" placeholder="Ej: Cálculo Integral" />
                        </div>

                        <div class="campo">
                            <label>Semestre:</label>
                            <form:input path="semestre" type="number" required="required" min="1" max="12" />
                        </div>

                        <div class="campo">
                            <label>Prerrequisitos (Selecciona las materias necesarias):</label>
                            <div style="max-height: 200px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                                <c:forEach items="${listaMaterias}" var="mat">
                                    <div>
                                        <!-- Checkbox para cada materia. Value = ID de la materia -->
                                        <form:checkbox path="prerrequisitos" value="${mat.id}" />
                                        <label style="display:inline; font-weight:normal;">
                                            <c:out value="${mat.nombre} (Sem ${mat.semestre})" />
                                        </label>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty listaMaterias}">
                                    <div>No tienes otras materias registradas para ser prerrequisitos.</div>
                                </c:if>
                            </div>
                            <small>Marca las materias que debes haber aprobado ANTES de ver esta.</small>
                        </div>

                        <div class="botones">
                            <button type="submit" class="boton boton-primario">Guardar Materia</button>
                            <a href="${pageContext.request.contextPath}/" class="boton boton-eliminar">Cancelar</a>
                        </div>
                    </form:form>
                </div>
            </body>

            </html>