package br.edu.fateczl.Hotel.controller;

import java.math.BigDecimal;
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

import br.edu.fateczl.Hotel.model.Tipo;
import br.edu.fateczl.Hotel.service.TipoService;

@Controller
public class CadastrarTipoController {

	@Autowired
	private TipoService tipoService;

	@RequestMapping(name = "cadastrar_tipo", value = "/cadastrar_tipo", method = RequestMethod.GET)
	public ModelAndView cadastrarTipoGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer codigo = null;
		String acao = params.get("acao");
		String erro = "";
		String saida = "";
		Tipo tipo = new Tipo();

		try {
			if (params.get("codigo") != null && !params.get("codigo").isEmpty()) {
				codigo = Integer.parseInt(params.get("codigo"));

				if (acao.equalsIgnoreCase("editar")) {
					tipo = tipoService.buscarPorId(codigo).orElse(null);
				} else if (acao.equalsIgnoreCase("excluir")) {
					tipoService.deletar(codigo);
					saida = "Tipo " + codigo + " removido com sucesso";
					tipo = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("tipo", tipo);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("cadastrar_tipo");
	}

	@RequestMapping(name = "cadastrar_tipo", value = "/cadastrar_tipo", method = RequestMethod.POST)
	public ModelAndView cadastrarTipoPost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String nome = params.get("nome");
		BigDecimal valor = null;
		String comando = params.get("botao");

		String erro = "";
		String saida = "";
		Tipo tipo = new Tipo();
		List<Tipo> tipos = new ArrayList<>();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				id = Integer.parseInt(params.get("id"));
			}
			if (params.get("valor") != null && !params.get("valor").isEmpty()) {
				valor = new BigDecimal(params.get("valor").replace(",", "."));
			}

			if (comando.equalsIgnoreCase("Buscar")) {
				tipos = tipoService.listar();
			} else if(comando.equalsIgnoreCase("PesquisarCategoria")) {
				tipo = tipoService.buscarPorNome(nome);
			}

			if (comando.equalsIgnoreCase("Adicionar")) {
				tipo.setId(id);
				tipo.setNome(nome);
				tipo.setValor(valor);

				tipoService.salvar(tipo);

				if (tipoService.buscarPorId(id) != null) {
					saida = "Tipo (" + tipo.getNome() + ") atualizado com sucesso";
				} else {
					saida = "Tipo adicionado com sucesso";
				}

			}

			if (comando.equalsIgnoreCase("Remover")) {
				if (id != null) {
					tipoService.deletar(id);
					saida = "Tipo removido com sucesso";
				} else {
					erro = "Código do tipo não informado";
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("tipo", tipo);
		model.addAttribute("tipos", tipos);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("cadastrar_tipo");
	}
}
