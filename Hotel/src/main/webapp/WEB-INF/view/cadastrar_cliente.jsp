<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastro de Cliente</title>
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
			<li class="nav-item"><a class="nav-link active"
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
			<form action="cadastrar_cliente" method="post">
				<h1>Cadastrar Cliente</h1>
				<table>
					<tr>
						<td><label for="cpf">CPF:</label></td>
						<td><input type="number" id="cpf" name="cpf"
							value='<c:out value="${cliente.cpf}"/>'></td>
					</tr>
					<tr>
						<td><label for="nome">Nome:</label></td>
						<td><input type="text" id="nome" name="nome"
							value='<c:out value="${cliente.nome}"/>'></td>
					</tr>
					<tr>
						<td><label for="telefone">Telefone:</label></td>
						<td><input type="tel" id="telefone" name="telefone"
							value='<c:out value="${cliente.telefone}"/>'></td>
					</tr>
					<tr>
						<td><label for="cidade">Cidade:</label></td>
						<td><input type="text" id="cidade" name="cidade"
							value='<c:out value="${cliente.cidade}"/>'></td>
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
			<c:if test="${not empty clientes}">
				<table>
					<thead>
						<tr>
							<th>CPF:</th>
							<th>Nome:</th>
							<th>Telefon:</th>
							<th>Cidade:</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="clientes" items="${clientes}">
							<tr>
								<td>${clientes.cpf}</td>
								<td>${clientes.nome}</td>
								<td>${clientes.telefone}</td>
								<td>${clientes.cidade}</td>


								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_cliente?acao=editar&id=${clientes.cpf}">Editar</a>
								</td>

								<td><a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_cliente?acao=excluir&id=${clientes.cpf}">Deletar</a>
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

