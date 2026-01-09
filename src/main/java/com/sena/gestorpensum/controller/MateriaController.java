package com.sena.gestorpensum.controller;

import com.sena.gestorpensum.model.EstadoMateria;
import com.sena.gestorpensum.model.Materia;
import com.sena.gestorpensum.model.Usuario;
import com.sena.gestorpensum.repository.MateriaRepository;
import com.sena.gestorpensum.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MateriaController {

    @Autowired
    private MateriaRepository materiaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    /**
     * Dashboard Principal: Muestra las materias por semestre y el progreso.
     */
    @GetMapping("/")
    public String dashboard(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        Usuario usuario = usuarioRepository.findByUsername(userDetails.getUsername()).get();
        List<Materia> materias = materiaRepository.findByUsuarioOrderBySemestreAscNombreAsc(usuario);

        // Agrupar por semestres (Lógica simple para la vista)
        // Calculo de progreso
        long totalmaterias = materias.size();
        long aprobadas = materias.stream().filter(m -> m.getEstado() == EstadoMateria.APROBADA).count();
        double porcentaje = totalmaterias > 0 ? (double) aprobadas / totalmaterias * 100 : 0;

        model.addAttribute("materias", materias);
        model.addAttribute("progreso", (int) porcentaje);
        model.addAttribute("usuario", usuario);

        return "dashboard";
    }

    /**
     * Formulario para crear NUEVA materia.
     */
    @GetMapping("/materia/nueva")
    public String nuevaMateria(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        Usuario usuario = usuarioRepository.findByUsername(userDetails.getUsername()).get();
        Materia materia = new Materia();

        // Cargar materias existentes del usuario para el selector de prerrequisitos
        List<Materia> posiblesPrerrequisitos = materiaRepository.findByUsuario(usuario);

        model.addAttribute("materia", materia);
        model.addAttribute("listaMaterias", posiblesPrerrequisitos);
        return "formulario_materia";
    }

    /**
     * Guardar materia (Creación o Edición).
     */
    @PostMapping("/materia/guardar")
    public String guardarMateria(@AuthenticationPrincipal UserDetails userDetails,
            @ModelAttribute Materia materia,
            RedirectAttributes redirectAttrs) {
        Usuario usuario = usuarioRepository.findByUsername(userDetails.getUsername()).get();

        // Asignar el usuario dueño si es nueva
        if (materia.getId() == null) {
            materia.setUsuario(usuario);
        } else {
            // Si es edición, recuperar la original para no perder el usuario y validar
            // cambios
            Materia original = materiaRepository.findById(materia.getId()).orElse(null);
            if (original != null) {
                materia.setUsuario(original.getUsuario()); // Mantener dueño
            }
        }

        // VALIDACIÓN DE PRERREQUISITOS
        if (materia.getEstado() == EstadoMateria.APROBADA) {
            // Verificar si sus prerrequisitos están aprobados
            // Nota: Al venir del formulario, los objetos Prerrequisito solo tienen ID.
            // Necesitamos buscarlos.
            for (Materia prerreq : materia.getPrerrequisitos()) {
                Materia pCompleta = materiaRepository.findById(prerreq.getId()).orElse(null);
                if (pCompleta != null && pCompleta.getEstado() != EstadoMateria.APROBADA) {
                    redirectAttrs.addFlashAttribute("error", "No puedes aprobar '" + materia.getNombre() +
                            "' porque el prerrequisito '" + pCompleta.getNombre() + "' no está aprobado.");
                    // Revertir estado a pendiente si falló validación
                    materia.setEstado(EstadoMateria.PENDIENTE);
                }
            }
        }

        materiaRepository.save(materia);
        return "redirect:/";
    }

    /**
     * Editar materia existente.
     */
    @GetMapping("/materia/editar/{id}")
    public String editarMateria(@PathVariable Long id, @AuthenticationPrincipal UserDetails userDetails, Model model) {
        Usuario usuario = usuarioRepository.findByUsername(userDetails.getUsername()).get();
        Materia materia = materiaRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("ID inválido"));

        // Seguridad: Verificar que la materia sea del usuario
        if (!materia.getUsuario().getId().equals(usuario.getId())) {
            return "redirect:/";
        }

        // Excluir la propia materia de la lista de prerrequisitos (evitar ciclos
        // simples)
        List<Materia> posibles = materiaRepository.findByUsuario(usuario).stream()
                .filter(m -> !m.getId().equals(id))
                .collect(Collectors.toList());

        model.addAttribute("materia", materia);
        model.addAttribute("listaMaterias", posibles);
        return "formulario_materia";
    }

    /**
     * Acción rápida para marcar aprobada desde el dashboard.
     */
    @GetMapping("/materia/aprobar/{id}")
    public String aprobarRapido(@PathVariable Long id, @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttrs) {
        Materia materia = materiaRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("ID inválido"));

        // Validar prerrequisitos
        if (materia.tienePrerrequisitosPendientes()) {
            redirectAttrs.addFlashAttribute("error",
                    "No puedes aprobar " + materia.getNombre() + ". Faltan prerrequisitos.");
        } else {
            materia.setEstado(EstadoMateria.APROBADA);
            materiaRepository.save(materia);
            redirectAttrs.addFlashAttribute("mensaje", "¡Materia aprobada!");
        }
        return "redirect:/";
    }

    @GetMapping("/materia/pendiente/{id}")
    public String pendienteRapido(@PathVariable Long id) {
        Materia materia = materiaRepository.findById(id).orElse(null);
        if (materia != null) {
            materia.setEstado(EstadoMateria.PENDIENTE);
            materiaRepository.save(materia);
        }
        return "redirect:/";
    }
}
