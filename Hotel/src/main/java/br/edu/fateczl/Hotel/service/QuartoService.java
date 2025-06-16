package br.edu.fateczl.Hotel.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Quarto;
import br.edu.fateczl.Hotel.model.Tipo;
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
	public List<Quarto> quartosDisponiveisPorData(LocalDate data, int dias) {
	    List<Object[]> resultados = quartoRepository.findQuartosDisponiveis(data, dias);
	    List<Quarto> quartos = new ArrayList<>();

	    for (Object[] obj : resultados) {
	        Quarto q = new Quarto();
	        q.setNumero((Integer) obj[0]);
	        q.setAndar((Integer) obj[1]);
	        q.setDescricao((String) obj[2]);
	        Tipo t = new Tipo();
	        t.setNome((String) obj[3]);
	        t.setValor((BigDecimal) obj[4]);
	        q.setTipo(t);
	        quartos.add(q);
	    }
	    return quartos;
	}
}
