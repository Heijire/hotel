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
import br.edu.fateczl.Hotel.service.ClienteService;

@Controller
public class CadastrarClienteController {
	@Autowired
	private ClienteService clienteService;

	@RequestMapping(name = "cadastrar_cliente", value = "/cadastrar_cliente", method = RequestMethod.GET)
	public ModelAndView CadastrarClienteGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String acao = params.get("acao");
		String saida = "";
		String erro = "";
		Cliente cliente = new Cliente();

		if (params.get("id") != null && !params.get("id").isEmpty()) {
			id = Integer.parseInt(params.get("id"));
		}

		try {
			if (id != null) {
				if (acao.equalsIgnoreCase("editar")) {
					cliente = clienteService.buscarPorId(id);
				} else if (acao.equalsIgnoreCase("excluir")) {
					cliente = clienteService.buscarPorId(id);
					clienteService.deletar(id);
					saida = "Cliente: " + cliente.getNome() + " deletado com sucesso";
					cliente = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("cliente", cliente);
		return new ModelAndView("cadastrar_cliente");
	}

	@RequestMapping(name = "cadastrar_cliente", value = "/cadastrar_cliente", method = RequestMethod.POST)
	public ModelAndView cadastrarClientePost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer cpf = null;
		String nome = params.get("nome");
		String telefone = params.get("telefone");
		String cidade = params.get("cidade");
		String comando = params.get("botao");
		String saida = "";
		String erro = "";
		Cliente cliente = new Cliente();
		List<Cliente> clientes = new ArrayList<>();

		if (params.get("cpf") != null && !params.get("cpf").isEmpty()) {
			cpf = Integer.parseInt(params.get("cpf"));
		}

		try {
			if (comando.equalsIgnoreCase("BUSCAR")) {
				clientes = clienteService.listar();
				for(Cliente c: clientes) {
					System.err.println(c.toString());
				}
			}

			if (comando.equalsIgnoreCase("Adicionar")) {
				cliente.setCpf(cpf);
				cliente.setNome(nome);
				cliente.setTelefone(Integer.parseInt(telefone));
				cliente.setCidade(cidade);
				clienteService.salvar(cliente);

				if (clienteService.buscarPorId(cpf) != null) {
					saida = "Cliente (" + cliente.getNome() + ") atualizado com sucesso";
				} else {
					saida = "Cliente adicionado com sucesso";
				}
			}

			if (comando.equalsIgnoreCase("Remover")) {
				if (cpf != null) {
					clienteService.deletar(cpf);
					saida = "Cliente deletado com sucesso";
				} else {
					erro = "Não foi possível deletar o cliente";
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("clientes", clientes);
		return new ModelAndView("cadastrar_cliente");
	}
}