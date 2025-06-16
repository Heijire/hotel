package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Tipo;
import br.edu.fateczl.Hotel.repository.TipoRepository;

@Service
public class TipoService {
	@Autowired
	private TipoRepository tipoRepository;

	public List<Tipo> listar(){
		return tipoRepository.findAll();
	}
	public Optional<Tipo> buscarPorId(int id ) {
		return tipoRepository.findById(id);
	}
	
	public Tipo buscarPorNome(String nome) {
		return tipoRepository.findByNome(nome);
	}
	

	public Tipo salvar(Tipo tipo) {
		return tipoRepository.save(tipo);
	}
	public void deletar(int id) {
		tipoRepository.deleteById(id);
	}
}
