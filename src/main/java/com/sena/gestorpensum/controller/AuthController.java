package com.sena.gestorpensum.controller;

import com.sena.gestorpensum.model.Usuario;
import com.sena.gestorpensum.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * Controlador para la autenticación de usuarios.
 * Maneja el inicio de sesión y el registro de nuevos usuarios.
 */
@Controller
public class AuthController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * Muestra la página de inicio de sesión.
     * 
     * @return Nombre de la vista "login"
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * Muestra el formulario de registro de usuario.
     * 
     * @param model Modelo para pasar datos a la vista
     * @return Nombre de la vista "registro"
     */
    @GetMapping("/registro")
    public String registro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro";
    }

    /**
     * Procesa la solicitud de registro de un nuevo usuario.
     * Valida que las contraseñas coincidan y encripta la contraseña antes de
     * guardar.
     * 
     * @param usuario         Objeto Usuario con los datos del formulario
     * @param confirmPassword Confirmación de la contraseña
     * @param model           Modelo para reportar errores
     * @return Redirección al login en caso de éxito, o vuelta al registro en caso
     *         de error.
     */
    @PostMapping("/registro")
    public String procesarRegistro(Usuario usuario,
            @org.springframework.web.bind.annotation.RequestParam String confirmPassword,
            Model model) {

        if (!usuario.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Las contraseñas no coinciden");
            return "registro";
        }

        // Encriptar contraseña antes de guardar
        usuario.setPassword(passwordEncoder.encode(usuario.getPassword()));
        usuarioRepository.save(usuario);
        return "redirect:/login?registrado";
    }
}
