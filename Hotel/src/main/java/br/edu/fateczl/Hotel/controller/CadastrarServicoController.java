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

import br.edu.fateczl.Hotel.model.Servicos;
import br.edu.fateczl.Hotel.service.ServicoService;

@Controller
public class CadastrarServicoController {

	@Autowired
	private ServicoService servicoService;

	@RequestMapping(name = "cadastrar_servico", value = "/cadastrar_servico", method = RequestMethod.GET)
	public ModelAndView cadastrarServicoGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer codigo = null;
		String acao = params.get("acao");
		String erro = "";
		String saida = "";
		Servicos servicos = new Servicos();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				codigo = Integer.parseInt(params.get("id"));

				if (acao.equalsIgnoreCase("editar")) {
					servicos = servicoService.buscarPorId(codigo).orElse(null);
				} else if (acao.equalsIgnoreCase("excluir")) {
					servicoService.deletar(codigo);
					saida = "Serviço " + codigo + " removido com sucesso";
					servicos = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("servicos", servicos);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("cadastrar_servico");
	}

	@RequestMapping(name = "cadastrar_servico", value = "/cadastrar_servico", method = RequestMethod.POST)
	public ModelAndView cadastrarServicoPost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String nome = params.get("nome");
		String descricao = params.get("descricao");
		BigDecimal valor = null;
		String comando = params.get("botao");

		String erro = "";
		String saida = "";
		Servicos servicos = new Servicos();
		List<Servicos> servicoss = new ArrayList<>();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				id = Integer.parseInt(params.get("id"));
			}
			if (params.get("valor") != null && !params.get("valor").isEmpty()) {
				valor = new BigDecimal(params.get("valor").replace(",", "."));
			}

			if (comando.equalsIgnoreCase("buscar")) {
				servicoss = servicoService.listar();

			} else if (comando.equalsIgnoreCase("Adicionar")) {
				servicos.setId(id);
				servicos.setNome(nome);
				servicos.setDescricao(descricao);
				servicos.setValor(valor);
				servicoService.salvar(servicos);
				if (servicoService.buscarPorId(id).isPresent()) {
					saida = "Servico (" + servicos.getNome() + ") atualizado com sucesso";
				} else {
					saida = "Servico cadastrado com sucesso";
				}
			} else if (comando.equalsIgnoreCase("Remover")) {
				if (id != null) {
					servicoService.deletar(id);
					saida = "Serviço removido com sucesso";
				} else {
					erro = "Código do serviço não informado";
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("servicos", servicos);
		model.addAttribute("servicoss", servicoss);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("cadastrar_servico");
	}
}
