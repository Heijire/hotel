package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Servicos;
import br.edu.fateczl.Hotel.repository.ServicosRepository;

@Service
public class ServicoService {

	@Autowired
	private ServicosRepository servicosRepository;

	public List<Servicos> listar() {
		return servicosRepository.findAll();
	}

	public Optional<Servicos> buscarPorId(Integer id) {
		return servicosRepository.findById(id);
	}

	public Servicos salvar(Servicos servico) {
		return servicosRepository.save(servico);
	}

	public void deletar(Integer id) {
		servicosRepository.deleteById(id);
	}
}
