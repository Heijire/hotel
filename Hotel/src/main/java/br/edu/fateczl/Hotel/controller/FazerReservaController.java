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
import br.edu.fateczl.Hotel.model.Quarto;
import br.edu.fateczl.Hotel.model.Reserva;
import br.edu.fateczl.Hotel.service.ClienteService;
import br.edu.fateczl.Hotel.service.QuartoService;
import br.edu.fateczl.Hotel.service.ReservaService;

@Controller
public class FazerReservaController {

	@Autowired
	private ReservaService reservaService;

	@Autowired
	private ClienteService clienteService;

	@Autowired
	private QuartoService quartoService;

	@RequestMapping(name = "fazer_reserva", value = "/fazer_reserva", method = RequestMethod.GET)
	public ModelAndView fazerReservaGet(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String acao = params.get("acao");
		String saida = "";
		String erro = "";
		Reserva reserva = new Reserva();

		if (params.get("id") != null && !params.get("id").isEmpty()) {
			id = Integer.parseInt(params.get("id"));
		}

		try {
			if (id != null) {
				if (acao.equalsIgnoreCase("editar")) {
					reserva = reservaService.buscarPorId(id).orElse(null);
				} else if (acao.equalsIgnoreCase("excluir")) {
					reserva = reservaService.buscarPorId(id).orElse(null);
					reservaService.deletar(id);
					saida = "Reserva excluída com sucesso";
					reserva = null;
				}
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("reserva", reserva);
		model.addAttribute("clientes", clienteService.listar());
		model.addAttribute("quartos", quartoService.listar());

		return new ModelAndView("fazer_reserva");
	}

	@RequestMapping(name = "fazer_reserva", value = "/fazer_reserva", method = RequestMethod.POST)
	public ModelAndView fazerReservaPost(@RequestParam Map<String, String> params, ModelMap model) {
		Integer id = null;
		String clienteId = params.get("cliente_id");
		String quartoId = params.get("quarto_id");
		String dtEntradaStr = params.get("dt_entrada");
		String qntDiasStr = params.get("qntDias");
		String comando = params.get("botao");
		String saida = "";
		String erro = "";

		Reserva reserva = new Reserva();
		List<Reserva> reservas = new ArrayList<>();

		try {
			if (params.get("id") != null && !params.get("id").isEmpty()) {
				id = Integer.parseInt(params.get("id"));
				reserva.setId(id);
			}

			if (comando.equalsIgnoreCase("buscar")) {
				reservas = reservaService.listar();
			}

			if (comando.equalsIgnoreCase("Adicionar")) {
				if (clienteId != null && quartoId != null) {

					Cliente cliente = clienteService.buscarPorId(Integer.parseInt(clienteId));
					Quarto quarto = quartoService.buscarporId(Integer.parseInt(quartoId)).orElse(null);
					reserva.setCliente(cliente);
					reserva.setQuarto(quarto);

					if (dtEntradaStr != null && !dtEntradaStr.isEmpty()) {
						reserva.setDtEntrada(LocalDate.parse(dtEntradaStr));
					} else {
						erro = "Data de entrada é obrigatória.";
					}

					if (qntDiasStr != null && !qntDiasStr.isEmpty()) {
						reserva.setQntDias(Integer.parseInt(qntDiasStr));
					} else {
						erro = "Quantidade de dias é obrigatória.";
					}

					reservaService.salvar(reserva);

					if (reservaService.buscarPorId(reserva.getId()).isPresent()) {
						saida = "Reserva atualizada com sucesso";
					} else {
						saida = "Reserva adicionada com sucesso";
					}
				} else {
					erro = "Cliente ou quarto não informados.";
				}
			}

			if (comando.equalsIgnoreCase("Remover")) {
				if (id != null) {
					reservaService.deletar(id);
					saida = "Reserva removida com sucesso";
				} else {
					erro = "ID da reserva inválido";
				}
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		model.addAttribute("erro", erro);
		model.addAttribute("saida", saida);
		model.addAttribute("reservas", reservas);
		model.addAttribute("clientes", clienteService.listar());
		model.addAttribute("quartos", quartoService.listar());

		return new ModelAndView("fazer_reserva");
	}

    @RequestMapping(value = "/consultar_disponiveis_reserva", method = RequestMethod.GET)
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
