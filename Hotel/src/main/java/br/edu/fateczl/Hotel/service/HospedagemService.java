package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.Hospedagem;
import br.edu.fateczl.Hotel.repository.HospedagemRepository;

@Service
public class HospedagemService {

    @Autowired
    private HospedagemRepository hospedagemRepository;

    public List<Hospedagem> listar() {
        return hospedagemRepository.findAll();
    }

    public Optional<Hospedagem> buscarPorId(Integer id) {
        return hospedagemRepository.findById(id);
    }

    public Hospedagem salvar(Hospedagem hospedagem) {
        return hospedagemRepository.save(hospedagem);
    }

    public void deletar(Integer id) {
        hospedagemRepository.deleteById(id);
    }
}
