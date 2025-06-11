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

import br.edu.fateczl.Hotel.model.Quarto;
import br.edu.fateczl.Hotel.model.Tipo;
import br.edu.fateczl.Hotel.service.QuartoService;
import br.edu.fateczl.Hotel.service.TipoService;

@Controller
public class CadastrarQuartoController {

	@Autowired
	private QuartoService quartoService;

	@Autowired
	private TipoService tipoService;

	@RequestMapping(name = "cadastrar_quarto", value = "/cadastrar_quarto", method = RequestMethod.GET)
	public ModelAndView cadastrarQuartoGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer numero = null;
		String acao = params.get("acao");
		String saida = "";
		String erro = "";
		Quarto quarto = new Quarto();

		try {
			if (params.get("numero") != null && !params.get("numero").isEmpty()) {
				numero = Integer.parseInt(params.get("numero"));

				if (acao.equalsIgnoreCase("editar")) {
					quarto = quartoService.buscarporId(numero).orElse(null);
				} else if (acao.equalsIgnoreCase("excluir")) {
					quarto = quartoService.buscarporId(numero).orElse(null);
					quartoService.deletar(numero);
					saida = "Quarto " + numero + " excluído com sucesso";
					quarto = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		List<Tipo> tipos = tipoService.listar();

		model.addAttribute("quarto", quarto);
		model.addAttribute("tipos", tipos);
		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);

		return new ModelAndView("cadastrar_quarto");
	}

	@RequestMapping(name = "cadastrar_quarto", value = "/cadastrar_quarto", method = RequestMethod.POST)
	public ModelAndView cadastrarQuartoPost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer numero = null;
		Integer andar = null;
		String descricao = params.get("descricao");
		Integer tipoId = null;
		String comando = params.get("botao");

		String erro = "";
		String saida = "";
		Quarto quarto = new Quarto();
		List<Quarto> quartos = new ArrayList<>();

		try {
			if (params.get("numero") != null && !params.get("numero").isEmpty()) {
				numero = Integer.parseInt(params.get("numero"));
			}
			if (params.get("andar") != null && !params.get("andar").isEmpty()) {
				andar = Integer.parseInt(params.get("andar"));
			}
			if (params.get("tipo") != null && !params.get("tipo").isEmpty()) {
				tipoId = Integer.parseInt(params.get("tipo"));
			}

			if (comando.equalsIgnoreCase("Listar")) {
				quartos = quartoService.listar();
			} else if (comando.equalsIgnoreCase("adicionar")) {
				Tipo tipo = tipoService.buscarPorId(tipoId).orElse(null);
				quarto.setNumero(numero);
				quarto.setAndar(andar);
				quarto.setDescricao(descricao);
				quarto.setTipo(tipo);

				quartoService.salvar(quarto);
				if (quartoService.buscarporId(numero).isPresent()) {
					saida = "Quarto " + numero + " atualizado com sucesso";
				} else {
					saida = "Quarto " + numero + " cadastrado com sucesso";
				}

			} 

			if (comando.equalsIgnoreCase("Remover")) {
				if (numero != null) {
					quartoService.deletar(numero);
					saida = "Quarto removido com sucesso";
				} else {
					erro = "Número do quarto não informado";
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		List<Tipo> tipos = tipoService.listar();

		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("quartos", quartos);
		model.addAttribute("tipos", tipos);

		return new ModelAndView("cadastrar_quarto");
	}
}