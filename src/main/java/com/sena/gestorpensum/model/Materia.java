package com.sena.gestorpensum.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Entidad que representa una Materia o Asignatura.
 * Contiene información como nombre, semestre y estado.
 */
@Entity
@Table(name = "materias")
public class Materia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nombre;

    @Column(nullable = false)
    private Integer semestre;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private EstadoMateria estado;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;

    // Prerrequisitos: Materias que deben estar aprobadas antes de aprobar esta
    @ManyToMany
    @JoinTable(name = "materia_prerrequisitos", joinColumns = @JoinColumn(name = "materia_id"), inverseJoinColumns = @JoinColumn(name = "prerrequisito_id"))
    private Set<Materia> prerrequisitos = new HashSet<>();

    /**
     * Constructor por defecto.
     * Inicializa el estado como PENDIENTE.
     */
    public Materia() {
        this.estado = EstadoMateria.PENDIENTE;
    }

    public Materia(String nombre, Integer semestre, Usuario usuario) {
        this.nombre = nombre;
        this.semestre = semestre;
        this.usuario = usuario;
        this.estado = EstadoMateria.PENDIENTE;
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getSemestre() {
        return semestre;
    }

    public void setSemestre(Integer semestre) {
        this.semestre = semestre;
    }

    public EstadoMateria getEstado() {
        return estado;
    }

    public void setEstado(EstadoMateria estado) {
        this.estado = estado;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Set<Materia> getPrerrequisitos() {
        return prerrequisitos;
    }

    public void setPrerrequisitos(Set<Materia> prerrequisitos) {
        this.prerrequisitos = prerrequisitos;
    }

    /**
     * Verifica si la materia tiene algún prerrequisito que no esté aprobado.
     * 
     * @return true si faltan prerrequisitos por aprobar, false si todos están
     *         aprobados.
     */
    public boolean tienePrerrequisitosPendientes() {
        return prerrequisitos.stream().anyMatch(p -> p.getEstado() != EstadoMateria.APROBADA);
    }
}
