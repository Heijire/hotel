<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hotel</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/estilo.css">
</head>
<body>
	<!-- Navegação -->
	<ul class="nav nav-pills nav-fill">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="index">Index</a></li>
		<li class="nav-item"><a class="nav-link" href="cadastrar_cliente">Cadastrar
				Cliente</a></li>
		<li class="nav-item"><a class="nav-link" href="cadastrar_quarto">Cadastrar
				Quarto</a></li>
		<li class="nav-item"><a class="nav-link" href="cadastrar_servico">Cadastrar
				Sevicos</a></li>
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
	<div class="container text-center">
		<h1>Tela Inicial</h1>
		<br />
		<h2>Escolha qual dos cruds você deseja utilizar.</h2>
		<br />
		<div class="d-grid gap-2 col-6 mx-auto" role="group"
			aria-label="Basic outlined example">
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='cadastrar_cliente'">Cadastrar
				Cliente</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='cadastrar_quarto'">Cadastrar
				Quarto</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='cadastrar_servico'">Cadastrar
				Sevicos</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='cadastrar_tipo'">Cadastrar
				Tipo de quarto</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='fazer_hospedagem'">Realizar
				Hospedagem</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='fazer_reserva'">Realizar
				Reserva</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='pedir_servicos'">Solicitar
				Sevicos para Quarto</button>
			<button type="submit" class="btn custom-btn"
				onclick="window.location.href='relatorios'">Gerar
				Relatorios</button>

		</div>
	</div>
</body>
</html>
