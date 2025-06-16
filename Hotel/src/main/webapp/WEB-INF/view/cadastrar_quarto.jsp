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
		<!-- Navegação -->
		<ul class="nav nav-pills nav-fill">
			<li class="nav-item"><a class="nav-link" aria-current="page"
				href="index">Index</a></li>
			<li class="nav-item"><a class="nav-link"
				href="cadastrar_cliente">Cadastrar Cliente</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="cadastrar_quarto">Cadastrar Quarto</a></li>
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
			<form action="cadastrar_quarto" method="post">
				<h1>Cadastrar Quarto</h1>
				<table>
					<tr>
						<td><label for="numero">Numero do Quarto:</label></td>
						<td><input type="number" name="numero" id="numero"
							value='<c:out value="${quarto.numero}"/>'></td>
					</tr>
					<tr>
						<td><label for="andar">Andar:</label></td>
						<td><input type="number" id="andar" name="andar"
							value='<c:out value="${quarto.andar}"/>'></td>
					</tr>
					<tr>
						<td><label for="descricao">Descricao:</label></td>
						<td><input type="text" id="descricao" name="descricao"
							value='<c:out value="${quarto.descricao}"/>'></td>
					</tr>

					<tr>
						<td><label for="tipo">Tipo:</label></td>
						<td><select name="tipo" id="tipo">
								<c:forEach var="tipo" items="${tipos}">
									<option value="${tipo.id}"
										<c:if test="${quarto.tipo != null && quarto.tipo.id == tipo.id}">selected</c:if>>${tipo.nome}</option>
								</c:forEach>
						</select></td>
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
		<div>
			<!--div da tabela de apresentacao de dados-->
			<c:if test="${not empty quartos}">
				<table>
					<thead>
						<tr>
							<th>Num do Quarto:</th>
							<th>Andar:</th>
							<th>Descricao:</th>
							<th>Tipo:</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="quartos" items="${quartos}">
							<tr>
								<td>${quartos.numero}</td>
								<td>${quartos.andar}</td>
								<td>${quartos.descricao}</td>
								<td>${quartos.tipo.nome}</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_quarto?acao=editar&numero=${quartos.numero}">Editar</a>
								</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_quarto?acao=excluir&numero=${quartos.numero}">Deletar</a>
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

</body>
</html>

