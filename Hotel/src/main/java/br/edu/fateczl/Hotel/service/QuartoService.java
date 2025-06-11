package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Quarto;
import br.edu.fateczl.Hotel.repository.QuartoRepository;

@Service
public class QuartoService {

	@Autowired
	private QuartoRepository quartoRepository;
	
	public List<Quarto> listar(){
		return quartoRepository.findAll();
	}
	
	public Optional<Quarto> buscarporId(int numero) {
		return quartoRepository.findById(numero);
	}
	
	public Quarto salvar(Quarto quarto) {
		return quartoRepository.save(quarto);
	}
	public void deletar(int numero) {
		quartoRepository.deleteById(numero);
	}
}
