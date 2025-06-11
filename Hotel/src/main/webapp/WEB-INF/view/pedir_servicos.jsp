<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Quarto</title>
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
            <form action="pedir_servicos" method="post">
                <h1>Realizar pedido</h1>
                <table>
                    <input type="hidden" name="id" value="${servicosconsumidos.id}">
                    <tr>
                        <td><label for="servico">Servico:</label></td>
                        <td>
                            <select name="servico" id="servico">
                                <c:forEach var="servico" items="${servico}">
                                    <option value="${servico.id}"
                                        <c:if test="${servicosconsumidos.servico.id == servico.id}">selected</c:if>
                                        >${servico.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td><label for="hospedagem">Hospedagem:</label></td>
                        <td>
                            <select name="hospedagem" id="hospedagem">
                                <c:forEach var="hospedagem" items="${hospedagem}">
                                    <option value="${hospedagem.id}"
                                        <c:if test="${servicosconsumidos.hospedagem.id == hospedagem.id}">selected</c:if>
                                        >${hospedagem.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td><label for="dtUsada">Data soliciada:</label></td>
                        <td><input type="date" name="dtUsada" id="dtUsada" value='<c:out value="${servicosconsumidos.dtUsada}"/>'></td>
                    </tr>

                    <tr>
                        <td><Button type="submit" name="botao" value="Adicionar">Adicionar</Button></td>

                        <td><Button type="submit" name="botao" value="Remover">Remover</Button></td>
                    </tr>
                </table>
            </form>
        </div>

        <div> <!--div da tabela de apresentacao de dados-->
            <c:if test="${not empty servicosconsumidoss}">
                <table>
                    <thead>
                        <tr>
                            <th>ID:</th>
                            <th>CPF do Cliente:</th>
                            <th>Núm do Quarto:</th>
                            <th>Data soliciada:</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="servicosconsumidoss" items="${servicosconsumidoss}">
                            <tr>
                                <td>${servicosconsumidoss.id}</td>
                                <td>${servicosconsumidoss.cliente.cpf}</td>
                                <td>${servicosconsumidoss.quarto.numero}</td>
                                <td>${servicosconsumidoss.tipo.nome}</td>
                                
                                <td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/pedir_servicos?acao=editar&id=${servicosconsumidos.id}">Editar</a>
								</td>
									
								<td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/pedir_servicos?acao=excluir&id=${servicosconsumidos.id}">Deletar</a>
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

