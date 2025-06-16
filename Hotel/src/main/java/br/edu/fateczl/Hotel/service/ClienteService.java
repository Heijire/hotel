package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Cliente;
import br.edu.fateczl.Hotel.repository.ClienteRepository;

@Service
public class ClienteService {
	@Autowired
	private ClienteRepository clienteRepository;
	public List<Cliente> listar(){
		return clienteRepository.findAll();
	}

	public Cliente buscarPorId(int cpf) {
		return clienteRepository.findByCpf(cpf);
	}

	public Cliente salvar(Cliente cliente) {
		return clienteRepository.save(cliente);
	}

	public void deletar(int cpf) {
	 clienteRepository.deleteById(cpf);
	}
}
