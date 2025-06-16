<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relatorios</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/estilo.css">
</head>
<body>
	<div>
		<!-- Navegação -->
		<ul class="nav nav-pills nav-fill">
			<li class="nav-item"><a class="nav-link" aria-current="page"
				href="index">Index</a></li>
			<li class="nav-item"><a class="nav-link"
				href="cadastrar_cliente">Cadastrar Cliente</a></li>
			<li class="nav-item"><a class="nav-link" href="cadastrar_quarto">Cadastrar
					Quarto</a></li>
			<li class="nav-item"><a class="nav-link"
				href="cadastrar_servico">Cadastrar Sevicos</a></li>
			<li class="nav-item"><a class="nav-link" href="cadastrar_tipo">Cadastrar
					Tipo de quarto</a></li>
			<li class="nav-item"><a class="nav-link" href="fazer_hospedagem">Realizar
					Hospedagem</a></li>
			<li class="nav-item"><a class="nav-link" href="fazer_reserva">Realizar
					Reserva</a></li>
			<li class="nav-item"><a class="nav-link" href="pedir_servicos">Solicitar
					Sevicos para Quarto</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="relatorios">Gerar Relatorios </a></li>
			<li class="nav-item"><a class="nav-link" href="#">Maven site</a></li>
		</ul>
		<br />
	</div>
	<div class="container">

		<!-- div da tabela de input-->
		<form action="relatorios_disp" method="post" target="_blank">
			<table>
				<tr>
					<td><input type="date" id="datadisp" name="datadisp"
						placeholder="Digite a data desejada" /></td>
					<td><button type="submit" class="btn custom-btn" name="botao"
							>Relatorio quartos Disponiveis</button>
													</td>
				</tr>
			</table>
		</form>
		<form action="relatorios_Cliente" method="post" target="_blank">
			<table>
				<tr>
					<td><input type="number" id="hospedagem_id"
						name="hospedagem_id"
						placeholder="Digite o id da hospedagem para relatorio Completo" /></td>
					<td><button type="submit" class="btn custom-btn"
						name="botao">Relatorio valor por id </button></td>
				</tr>
			</table>
		</form>
		<form action="relatorios_Dia" method="post" target="_blank">
			<table>
				<tr>
					<td><input type="date" id="data" name="data"
						placeholder="Digite a Data para ver os clientes" /></td>
					<td><button type="submit" class="btn custom-btn"
						name="botao"> Relatorio todos CLientes </button> </td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>