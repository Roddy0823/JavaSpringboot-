<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Importar enum para comparaciones si fuera necesario, o usar strings si el modelo lo permite. 
     Para comparaciones con Enums en JSP, usualmente se compara como String o se usa scriptlet (menos recomendado).
     Evaluaremos si 'estado' llega como String o Enum. Thymeleaf T(...) es poderoso. En JSP usaremos strings. 
-->
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Mi Pensum - Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
        </head>

        <body>
            <div class="header-bar">
                <span>Bienvenido, <b>
                        <c:out value="${usuario.username}" />
                    </b></span>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="boton boton-eliminar"
                        style="padding: 5px 10px; font-size: 12px;">Cerrar Sesión</button>
                </form>
            </div>

            <div class="container">
                <h1>Gestor de Pensum</h1>

                <!-- Barra de Progreso -->
                <div class="progreso-container">
                    <div class="progreso-label">Progreso de la Carrera:
                        <c:out value="${progreso}" />%
                    </div>
                    <div class="barra-fondo">
                        <!-- JSP EL para estilo -->
                        <div class="barra-relleno" style="width: ${progreso}%"></div>
                    </div>
                </div>

                <!-- Alertas -->
                <c:if test="${not empty error}">
                    <div class="alerta error">
                        <c:out value="${error}" />
                    </div>
                </c:if>
                <c:if test="${not empty mensaje}">
                    <div class="alerta exito">
                        <c:out value="${mensaje}" />
                    </div>
                </c:if>

                <div style="margin: 20px 0; text-align: right;">
                    <a href="${pageContext.request.contextPath}/materia/nueva" class="boton boton-primario">+ Inscribir
                        Materia</a>
                </div>

                <!-- Listado Simple de Materias -->
                <table>
                    <thead>
                        <tr>
                            <th>Semestre</th>
                            <th>Materia</th>
                            <th>Prerrequisitos</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty materias}">
                            <tr>
                                <td colspan="5" style="text-align:center;">No tienes materias inscritas. ¡Comienza
                                    agregando una!</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${materias}" var="m">
                            <!-- classappend logic: si aprobada, fila-aprobada. 
                         Asumiendo que 'estado' se imprime como 'APROBADA' o 'PENDIENTE' -->
                            <tr class="${m.estado == 'APROBADA' ? 'fila-aprobada' : ''}">
                                <td style="text-align: center; font-weight: bold;">
                                    <c:out value="${m.semestre}" />
                                </td>
                                <td>
                                    <c:out value="${m.nombre}" />
                                </td>
                                <td>
                                    <c:if test="${empty m.prerrequisitos}">-</c:if>
                                    <c:forEach items="${m.prerrequisitos}" var="pre" varStatus="loop">
                                        <span class="badge">
                                            <c:out value="${pre.nombre}" />
                                        </span>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${m.estado == 'APROBADA'}">
                                            <span class="badge badge-success">APROBADA</span>
                                        </c:when>
                                        <c:when test="${m.estado == 'PENDIENTE'}">
                                            <span class="badge badge-warning">PENDIENTE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge">${m.estado}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Botón Aprobar -->
                                    <c:if test="${m.estado == 'PENDIENTE'}">
                                        <a href="${pageContext.request.contextPath}/materia/aprobar/${m.id}"
                                            title="Marcar como Aprobada">✅</a>
                                    </c:if>

                                    <!-- Botón Pendiente -->
                                    <c:if test="${m.estado == 'APROBADA'}">
                                        <a href="${pageContext.request.contextPath}/materia/pendiente/${m.id}"
                                            title="Volver a Pendiente">↩️</a>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/materia/editar/${m.id}"
                                        title="Editar">✏️</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>