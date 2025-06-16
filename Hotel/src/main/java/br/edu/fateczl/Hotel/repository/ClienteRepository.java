package br.edu.fateczl.Hotel.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.Hotel.model.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer> {
	
	public Cliente findByCpf(int cpf);

}
