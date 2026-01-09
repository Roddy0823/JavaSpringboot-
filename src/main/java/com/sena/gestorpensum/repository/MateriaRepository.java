package com.sena.gestorpensum.repository;

import com.sena.gestorpensum.model.Materia;
import com.sena.gestorpensum.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MateriaRepository extends JpaRepository<Materia, Long> {
    // Buscar materias SOLO del usuario actual, ordenadas por semestre y nombre
    List<Materia> findByUsuarioOrderBySemestreAscNombreAsc(Usuario usuario);

    // Buscar todas las materias del usuario (para el selector de prerrequisitos)
    List<Materia> findByUsuario(Usuario usuario);
}
