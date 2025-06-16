package br.edu.fateczl.Hotel.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.Hotel.model.Tipo;

public interface TipoRepository extends JpaRepository<Tipo, Integer>{

	public Tipo findByNome(String nome);
	
}
