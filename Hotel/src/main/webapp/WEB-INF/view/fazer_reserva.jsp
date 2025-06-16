<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reservar</title>
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
			<li class="nav-item"><a class="nav-link active"
				href="fazer_reserva">Realizar Reserva</a></li>
			<li class="nav-item"><a class="nav-link" href="pedir_servicos">Solicitar
					Sevicos para Quarto</a></li>

			<li class="nav-item"><a class="nav-link" href="relatorios">Gerar
					Relatorios </a></li>
			<li class="nav-item"><a class="nav-link" href="#">Maven site</a></li>
		</ul>
		<br />
	</div>

	<div>
		<!--div de controle de dados-->
		<div class="container">
			<!-- div da tabela de input-->
			<form action="fazer_reserva" method="post">
				<h1>Realizar reserva</h1>
				<table>
					<input type="hidden" name="id" value="${reserva.id}">
					<tr>
						<td><label for="cliente_id">CPF do Cliente:</label></td>
						<td><input type="number" id="cliente_id" name="cliente_id"
							value='<c:out value="${reserva.cliente.cpf}"/>'></td>
					</tr>
					<tr>
						<td><label for="quarto_id">Número do Quarto:</label></td>
						<td><input type="number" id="quarto_id" name="quarto_id"
							value='<c:out value="${reserva.quarto.numero}"/>'></td>
					</tr>
					<tr>
						<td><label for="dt_entrada">Data de entrada:</label></td>
						<td><input type="date" name="dt_entrada" id="dt_entrada"
							value='<c:out value="${reserva.dtEntrada}"/>'></td>
					</tr>
					<tr>
						<td><label for="qntDias">Quantidade de Dias:</label></td>
						<td><input type="number" name="qntDias" id="qntDias"
							value='<c:out value="${reserva.qntDias}"/>'></td>
					</tr>

					<tr>
						<td><Button type="submit" class="btn custom-btn" name="botao"
								value="Adicionar">Adicionar</Button></td>

						<td><Button type="submit" class="btn custom-btn" name="botao"
								value="Remover">Remover</Button></td>

						<td><Button type="submit" class="btn custom-btn" name="botao"
								value="Buscar">Buscar</Button></td>
					</tr>
				</table>
			</form>
		</div>
		<form action="consultar_disponiveis_reserva" method="get" class="mb-3">
			<label for="data">Data de entrada:</label> <input type="date"
				id="data" name="data" required> <label for="dias">Quantidade
				de dias:</label> <input type="number" id="dias" name="dias" required min="1">

			<button type="submit" class="btn custom-btn">Ver
				Disponíveis</button>
		</form>
		<div class="container">
			<!--div da tabela de apresentacao de dados-->
			<c:if test="${not empty reservas}">
				<table>
					<thead>
						<tr>
							<th>CPF do Cliente:</th>
							<th>Número do Quarto:</th>
							<th>Data de entrada:</th>
							<th>Qnt dias:</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reservas" items="${reservas}">
							<tr>
								<td>${reservas.cliente.cpf}</td>
								<td>${reservas.quarto.numero}</td>
								<td>${reservas.dtEntrada}</td>
								<td>${reservas.qntDias}</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/fazer_reserva?acao=editar&id=${reservas.id}">Editar</a>
								</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/fazer_reserva?acao=excluir&id=${reservas.id}">Deletar</a>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
		<div>
			<!--div das mensagens de erro e confirmacao-->
			<c:if test="${not empty saida}">
				<h2>
					<c:out value="${saida}" />
				</h2>
			</c:if>

			<c:if test="${not empty erro}">
				<h2>
					<c:out value="${erro}" />
				</h2>
			</c:if>
		</div>
	</div>
	<c:if test="${not empty quartos}">
		<h2>Quartos Disponíveis:</h2>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Número</th>
					<th>Andar</th>
					<th>Descrição</th>
					<th>Tipo</th>
					<th>Preço</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="q" items="${quartos}">
					<tr>
						<td>${q.numero}</td>
						<td>${q.andar}</td>
						<td>${q.descricao}</td>
						<td>${q.tipo.nome}</td>
						<td>${q.tipo.valor}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</body>
</html>