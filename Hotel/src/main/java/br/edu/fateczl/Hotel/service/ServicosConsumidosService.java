package br.edu.fateczl.Hotel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.fateczl.Hotel.model.ServicosConsumidos;
import br.edu.fateczl.Hotel.repository.ServicosConsumidosRepository;

@Service
public class ServicosConsumidosService {

    @Autowired
    private ServicosConsumidosRepository servicosConsumidosRepository;

    public List<ServicosConsumidos> listar() {
        return servicosConsumidosRepository.findAll();
    }

    public Optional<ServicosConsumidos> buscarPorId(Integer id) {
        return servicosConsumidosRepository.findById(id);
    }

    public ServicosConsumidos salvar(ServicosConsumidos servicosConsumidos) {
        return servicosConsumidosRepository.save(servicosConsumidos);
    }

    public void deletar(Integer id) {
        servicosConsumidosRepository.deleteById(id);
    }
}
