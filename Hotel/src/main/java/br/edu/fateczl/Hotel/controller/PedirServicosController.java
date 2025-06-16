package br.edu.fateczl.Hotel.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.Hotel.model.Hospedagem;
import br.edu.fateczl.Hotel.model.Servicos;
import br.edu.fateczl.Hotel.model.ServicosConsumidos;
import br.edu.fateczl.Hotel.service.HospedagemService;
import br.edu.fateczl.Hotel.service.ServicoService;
import br.edu.fateczl.Hotel.service.ServicosConsumidosService;

@Controller
public class PedirServicosController {

    @Autowired
    private ServicosConsumidosService servicosConsumidosService;

    @Autowired
    private ServicoService servicoService;

    @Autowired
    private HospedagemService hospedagemService;

    @RequestMapping(name = "pedir_servicos", value = "/pedir_servicos", method = RequestMethod.GET)
    public ModelAndView pedirServicosGet(@RequestParam Map<String, String> params, ModelMap model) {
        String erro = "";
        String saida = "";

        List<ServicosConsumidos> listaServicosConsumidos = new ArrayList<>();

        try {
            listaServicosConsumidos = servicosConsumidosService.listar();
        } catch (Exception e) {
            erro = e.getMessage();
        }

        model.addAttribute("servico", servicoService.listar());
        model.addAttribute("hospedagem", hospedagemService.listar());
        model.addAttribute("servicosconsumidoss", listaServicosConsumidos);

        model.addAttribute("erro", erro);
        model.addAttribute("saida", saida);

        return new ModelAndView("pedir_servicos");
    }

    @RequestMapping(name = "pedir_servicos", value = "/pedir_servicos", method = RequestMethod.POST)
    public ModelAndView pedirServicosPost(@RequestParam Map<String, String> params, ModelMap model) {
        String erro = "";
        String saida = "";
        String botao = params.get("botao");

        try {
            if (botao.equalsIgnoreCase("Adicionar")) {
                int servicoId = Integer.parseInt(params.get("servico"));
                int hospedagemId = Integer.parseInt(params.get("hospedagem"));
                LocalDate dtUsada = LocalDate.parse(params.get("dtUsada"));

                Servicos servicos = servicoService.buscarPorId(servicoId).orElse(null);
                Hospedagem hospedagem = hospedagemService.buscarPorId(hospedagemId).orElse(null);

                if (servicos != null && hospedagem != null && dtUsada != null) {
                    ServicosConsumidos sc = new ServicosConsumidos();
                    sc.setServicos(servicos);
                    sc.setHospedagem(hospedagem);
                    sc.setDtUsada(dtUsada);

                    servicosConsumidosService.salvar(sc);
                    saida = "Serviço consumido registrado com sucesso.";
                } else {
                    erro = "Dados incompletos para registrar o serviço.";
                }
            }
        } catch (Exception e) {
            erro = e.getMessage();
        }
        model.addAttribute("servico", servicoService.listar());
        model.addAttribute("hospedagem", hospedagemService.listar());
        model.addAttribute("servicosconsumidoss", servicosConsumidosService.listar());
        model.addAttribute("erro", erro);
        model.addAttribute("saida", saida);

        return new ModelAndView("pedir_servicos");
    }
}
