<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Registro - Gestor de Pensum</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
                <style>
                    .login-box {
                        max-width: 400px;
                        margin: 50px auto;
                        padding: 30px;
                        background: white;
                        border-radius: 8px;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    }
                </style>
            </head>

            <body style="background-color: #f0f2f5;">
                <div class="login-box">
                    <h1 style="font-size: 24px;">Crear Cuenta</h1>
                    <!-- Spring Form Tag automatically handles CSRF if enabled, but explicit doesn't hurt or if using standard form -->
                    <form:form action="${pageContext.request.contextPath}/registro" modelAttribute="usuario"
                        method="post">
                        <div class="campo">
                            <label>Nombre de Usuario:</label>
                            <form:input path="username" required="required" />
                        </div>
                        <div class="campo">
                            <label>Contraseña:</label>
                            <form:password path="password" required="required" />
                        </div>
                        <div class="campo">
                            <label>Confirmar Contraseña:</label>
                            <input type="password" name="confirmPassword" required="required" />
                        </div>

                        <c:if test="${not empty error}">
                            <div style="color: red; text-align: center; margin-bottom: 15px;">
                                <c:out value="${error}" />
                            </div>
                        </c:if>
                        <div class="botones">
                            <button type="submit" class="boton boton-primario" style="width: 100%;">Registrarse</button>
                        </div>
                    </form:form>
                    <p style="text-align: center; margin-top: 20px;">
                        <a href="${pageContext.request.contextPath}/login">Volver al Login</a>
                    </p>
                </div>
            </body>

            </html>