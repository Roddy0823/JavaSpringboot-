<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Login - Gestor de Pensum</title>
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
                <h1 style="font-size: 24px;">Iniciar Sesión</h1>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="campo">
                        <label>Usuario:</label>
                        <input type="text" name="username" required />
                    </div>
                    <div class="campo">
                        <label>Contraseña:</label>
                        <input type="password" name="password" required />
                    </div>
                    <div class="botones" style="text-align: center;">
                        <button type="submit" class="boton boton-primario" style="width: 100%;">Entrar</button>
                    </div>
                </form>
                <p style="text-align: center; margin-top: 20px;">
                    ¿No tienes cuenta? <a href="${pageContext.request.contextPath}/registro">Regístrate aquí</a>
                </p>
                <c:if test="${param.error != null}">
                    <div style="color: red; text-align: center; margin-top: 10px;">
                        Usuario o contraseña inválidos.
                    </div>
                </c:if>
                <c:if test="${param.registrado != null}">
                    <div style="color: green; text-align: center; margin-top: 10px;">
                        ¡Registro exitoso! Inicia sesión.
                    </div>
                </c:if>
            </div>
        </body>

        </html>