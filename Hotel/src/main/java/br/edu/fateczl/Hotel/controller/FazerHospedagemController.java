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

import br.edu.fateczl.Hotel.model.Cliente;
import br.edu.fateczl.Hotel.model.Hospedagem;
import br.edu.fateczl.Hotel.model.Quarto;
import br.edu.fateczl.Hotel.service.ClienteService;
import br.edu.fateczl.Hotel.service.HospedagemService;
import br.edu.fateczl.Hotel.service.QuartoService;

@Controller
public class FazerHospedagemController {

	@Autowired
	private HospedagemService hospedagemService;

	@Autowired
	private ClienteService clienteService;

	@Autowired
	private QuartoService quartoService;

	@RequestMapping(name = "fazer_hospedagem", value = "/fazer_hospedagem", method = RequestMethod.GET)
	public ModelAndView fazerHospedagemGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String acao = params.get("acao");
		String erro = "";
		String saida = "";
		Hospedagem hospedagem = new Hospedagem();
		if (params.get("id") != null && !params.get("id").isEmpty()) {
			id = Integer.parseInt(params.get("id"));
		}
		try {
			if (id != null) {
				if (acao.equalsIgnoreCase("editar")) {
					hospedagem = hospedagemService.buscarPorId(id).orElse(null);
				} else if (acao.equalsIgnoreCase("excluir")) {
					hospedagemService.deletar(id);
					saida = "Hospedagem removida com sucesso";
					hospedagem = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("hospedagem", hospedagem);
		model.addAttribute("clientes", clienteService.listar());
		model.addAttribute("quartos", quartoService.listar());
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("fazer_hospedagem");
	}

	@RequestMapping(name = "fazer_hospedagem", value = "/fazer_hospedagem", method = RequestMethod.POST)
	public ModelAndView fazerHospedagemPost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String clienteId = params.get("cliente_id");
		String quartoId = params.get("quarto_id");
		String dtEntradaStr = params.get("dt_entrada");
		String qntDiasStr = params.get("qntDias");
		String comando = params.get("botao");
		String saida = "";
		String erro = "";
		Hospedagem hospedagem = new Hospedagem();
		List<Hospedagem> hospedagens = new ArrayList<>();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				id = Integer.parseInt(params.get("id"));
				hospedagem.setId(id);
			}

			if (comando.equalsIgnoreCase("buscar")) {
				hospedagens = hospedagemService.listar();

			}
			if (comando.equalsIgnoreCase("Adicionar")) {
				if (clienteId != null && quartoId != null) {

					Cliente cliente = clienteService.buscarPorId(Integer.parseInt(clienteId));
					Quarto quarto = quartoService.buscarporId(Integer.parseInt(quartoId)).orElse(null);
					hospedagem.setCliente(cliente);
					hospedagem.setQuarto(quarto);

					if (dtEntradaStr != null && !dtEntradaStr.isEmpty()) {
						hospedagem.setDtEntrada(LocalDate.parse(dtEntradaStr));
					} else {
						erro = "Data de entrada é obrigatória.";
					}

					if (qntDiasStr != null && !qntDiasStr.isEmpty()) {
						hospedagem.setQntDias(Integer.parseInt(qntDiasStr));
					} else {
						erro = "Quantidade de dias é obrigatória.";
					}

					hospedagemService.salvar(hospedagem);

					if (hospedagemService.buscarPorId(id).isPresent()) {
						saida = "Hospedagem (" + hospedagem.getId() + ") atualizado com sucesso";
					} else {
						saida = "Hospedagem adicionado com sucesso";
					}
				} else if (comando.equalsIgnoreCase("Remover")) {
					if (id != null) {
						hospedagemService.deletar(id);
						saida = "Hospedagem removida com sucesso";
					} else {
						erro = "Código da hospedagem não informado";
					}
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("hospedagem", hospedagem);
		model.addAttribute("hospedagens", hospedagens);
		model.addAttribute("clientes", clienteService.listar());
		model.addAttribute("quartos", quartoService.listar());
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("fazer_hospedagem");
	}

    @RequestMapping(value = "/consultar_disponiveis", method = RequestMethod.GET)
    public ModelAndView consultarDisponiveis(@RequestParam Map<String, String> params, ModelMap model) {
        String dataStr = params.get("data");
        String diasStr = params.get("dias");
        String erro = "";

        try {
            LocalDate data = LocalDate.parse(dataStr);
            int dias = Integer.parseInt(diasStr);
            List<Quarto> quartos = quartoService.quartosDisponiveisPorData(data, dias);
            model.addAttribute("quartos", quartos);
        } catch (Exception e) {
            erro = "Erro: " + e.getMessage();
        }

        model.addAttribute("erro", erro);
        return new ModelAndView("consultar_disponiveis", model);
    }
}