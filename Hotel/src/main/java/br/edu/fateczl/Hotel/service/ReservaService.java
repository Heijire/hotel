package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Reserva;
import br.edu.fateczl.Hotel.repository.ReservaRepository;

@Service
public class ReservaService {
	 @Autowired
	    private ReservaRepository reservaRepository;

	    public List<Reserva> listar() {
	        return reservaRepository.findAll();
	    }

	    public Optional<Reserva> buscarPorId(Integer id) {
	        return reservaRepository.findById(id);
	    }

	    public Reserva salvar(Reserva reserva) {
	        return reservaRepository.save(reserva);
	    }

	    public void deletar(Integer id) {
	        reservaRepository.deleteById(id);
	    }
}
