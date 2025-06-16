<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastrar tipo</title>
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
			<li class="nav-item"><a class="nav-link active"
				href="cadastrar_tipo">Cadastrar Tipo de quarto</a></li>
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
			<form action="cadastrar_tipo" method="post">
				<h1>Cadastrar Tipo de Quarto</h1>
				<table>
					<input type="hidden" name="id" value="${tipo.id}">
					<tr>
						<td><label for="nome">Nome da categoria:</label></td>
						<td><input type="text" id="nome" name="nome"
							value='<c:out value="${tipo.nome}"/>'></td>
						<td><button type="submit" class="btn custom-btn" name="botao"
								value="PesquisarCategoria">Pesquisar</button></td>
					</tr>
					<tr>
						<td><label for="valor">Valor:</label></td>
						<td><input type="number" id="valor" name="valor"
							value='<c:out value="${tipo.valor}"/>' min="0" step="0.01"></td>
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
		<div class="container">

			<!--div da tabela de apresentacao de dados-->
			<c:if test="${not empty tipos}">
				<table>
					<thead>
						<tr>
							<th>ID:</th>
							<th>Nome:</th>
							<th>Valor:</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="tipos" items="${tipos}">
							<tr>
								<td>${tipos.id}</td>
								<td>${tipos.nome}</td>
								<td>${tipos.valor}</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_tipo?acao=editar&codigo=${tipos.id}">Editar</a>
								</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_tipo?acao=excluir&codigo=${tipos.id}">Deletar</a>
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

