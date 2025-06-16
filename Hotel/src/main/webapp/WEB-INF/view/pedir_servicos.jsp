<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastrar Quarto</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/estilo.css">
</head>
<body>

	<div>
		<!--div de navegacao-->
		<!-- Navegação -->
		<ul class="nav nav-pills nav-fill">
			<li class="nav-item"><a class="nav-link " aria-current="page"
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
			<li class="nav-item"><a class="nav-link active"
				href="pedir_servicos">Solicitar Sevicos para Quarto</a></li>
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
			<form action="pedir_servicos" method="post">
				<h1>Realizar pedido</h1>
				<table>
					<input type="hidden" name="id" value="${servicosconsumidos.id}">
					<tr>
						<td><label for="servico">Servico:</label></td>
						<td><select name="servico" id="servico">
								<c:forEach var="itemServico" items="${servico}">
									<option value="${itemServico.id}"
										<c:if test="${servicosconsumidos.servico.id == itemServico.id}">selected</c:if>>
										${itemServico.nome}</option>
								</c:forEach>
						</select></td>
					</tr>

					<tr>
						<td><label for="hospedagem">Hospedagem:</label></td>
						<td><select name="hospedagem" id="hospedagem">
								<c:forEach var="itemHospedagem" items="${hospedagem}">
									<option value="${itemHospedagem.id}"
										<c:if test="${servicosconsumidos.hospedagem.id == itemHospedagem.id}">selected</c:if>>
									${itemHospedagem.id}
									</option>
								</c:forEach>
						</select></td>
					</tr>

					<tr>
						<td><label for="dtUsada">Data solicitada:</label></td>
						<td><input type="date" name="dtUsada" id="dtUsada"
							value="${servicosconsumidos.dtUsada}"></td>
					</tr>

					<tr>
						<td><button type="submit" class="btn custom-btn" name="botao"
								value="Adicionar">Adicionar</button></td>
						<td><button type="submit" class="btn custom-btn" name="botao"
								value="Remover">Remover</button></td>
					</tr>
				</table>
			</form>

			<c:if test="${not empty servicosconsumidoss}">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID:</th>
							<th>CPF do Cliente:</th>
							<th>Núm do Quarto:</th>
							<th>Nome:</th>
							<th>Data solicitada:</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${servicosconsumidoss}">
							<tr>
								<td>${item.id}</td>
								<td>${item.hospedagem.cliente.cpf}</td>
								<td>${item.hospedagem.quarto.numero}</td>
								<td>${item.servicos.nome}</td>
								<td>${item.dtUsada}</td>
								
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

</body>
</html>

