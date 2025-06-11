package br.edu.fateczl.Hotel.controller;

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
		String erro = "";
		String saida = "";
		Hospedagem hospedagem = new Hospedagem();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				int id = Integer.parseInt(params.get("id"));
				String acao = params.get("acao");

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

		List<Cliente> clientes = clienteService.listar();
		List<Quarto> quartos = quartoService.listar();

		model.addAttribute("hospedagem", hospedagem);
		model.addAttribute("clientes", clientes);
		model.addAttribute("quartos", quartos);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("fazer_hospedagem");
	}

	@RequestMapping(name = "fazer_hospedagem", value = "/fazer_hospedagem", method = RequestMethod.POST)
	public ModelAndView fazerHospedagemPost(@RequestParam Map<String, String> params, ModelMap model) {
		String erro = "";
		String saida = "";
		String comando = params.get("botao");

		Hospedagem hospedagem = new Hospedagem();
		List<Hospedagem> hospedagens = new ArrayList<>();

		try {
			Integer id = null;
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				id = Integer.parseInt(params.get("id"));
				hospedagem.setId(id);
			}

			Integer clienteId = Integer.parseInt(params.get("cliente"));
			Integer quartoId = Integer.parseInt(params.get("quarto"));

			hospedagem.setCliente(clienteService.buscarPorId(clienteId).orElse(null));
			hospedagem.setQuarto(quartoService.buscarporId(quartoId).orElse(null));

			if (comando.equalsIgnoreCase("Listar")) {
				hospedagens = hospedagemService.listar();

			} else if (comando.equalsIgnoreCase("Adicionar")) {
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

		} catch (Exception e) {
			erro = e.getMessage();
		}

		List<Cliente> clientes = clienteService.listar();
		List<Quarto> quartos = quartoService.listar();

		model.addAttribute("hospedagem", hospedagem);
		model.addAttribute("hospedagens", hospedagens);
		model.addAttribute("clientes", clientes);
		model.addAttribute("quartos", quartos);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("fazer_hospedagem");
	}
}
