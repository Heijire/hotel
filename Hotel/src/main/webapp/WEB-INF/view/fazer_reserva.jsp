<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservar</title>
</head>
<body>

    <div>   <!--div de navegacao-->
        <a href="index">Index</a> -
        <a href="cadastrar_cliente">Cadastrar Cliente</a> -
        <a href="cadastrar_quarto">Cadastrar Quarto</a> -
        <a href="cadastrar_servico">Cadastrar Sevicos</a> -
        <a href="cadastrar_tipo">Cadastrar Tipo de quarto</a> -
        <a href="fazer_hospedagem">Realizar Hospedagem</a> -
        <a href="fazer_reserva">Realizar Reserva</a> -
        <a href="pedir_servicos">Solicitar Sevicos para Quarto</a> -
        <a href="#">Maven site</a>
    </div>

    <div>   <!--div de controle de dados-->
        <div> <!-- div da tabela de input-->
            <form action="fazer_reserva" method="post">
                <h1>Realizar reserva</h1>
                <table>
                    <input type="hidden" name="id" value="${reserva.id}">
                    <tr>
                        <td><label for="cpf">CPF do Cliente:</label></td>
                        <td><input type="number" id="cpf" name="cpf" value='<c:out value="${reserva.cliente.cpf}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="numero">Número do Quarto:</label></td>
                        <td><input type="number" id="numero" name="numero" value='<c:out value="${reserva.quarto.numero}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="dt_entrada">Data de entrada:</label></td>
                        <td><input type="date" name="dt_entrada" id="dt_entrada" value='<c:out value="${reserva.dtEntrada}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="qntDias">Quantidade de Dias:</label></td>
                        <td><input type="number" name="qntDias" id="qntDias" value='<c:out value="${reserva.qntDias}"/>'></td>
                    </tr>

                    <tr>
                        <td><Button type="submit" name="botao" value="Adicionar">Adicionar</Button></td>

                        <td><Button type="submit" name="botao" value="Remover">Remover</Button></td>

                        <td><Button type="submit" name="botao" value="Buscar">Buscar</Button></td>
                    </tr>
                </table>
            </form>
        </div>
        <div> <!--div da tabela de apresentacao de dados-->
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
                                
                                <td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/fazer_reserva?acao=editar&id=${reserva.id}">Editar</a>
								</td>
									
								<td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/fazer_reserva?acao=excluir&id=${reserva.id}">Deletar</a>
                                </td>
                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <div>   <!--div das mensagens de erro e confirmacao-->
            <c:if test="${not empty saida}">
                <h2>
                    <c:out value="${saida}"/>
                </h2>
            </c:if>
        
            <c:if test="${not empty erro}">
                <h2>
                    <c:out value="${erro}"/>
                </h2>
            </c:if>
        </div>
    </div>
    
</body>
</html>