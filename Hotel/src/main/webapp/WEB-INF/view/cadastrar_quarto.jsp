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
            <form action="cadastrar_quarto" method="post">
                <h1>Cadastrar Quarto</h1>
                <table>
                    <tr>
                        <td><label for="numero">Numero do Quarto:</label></td>
                        <td><input type="number" name="numero" id="numero" value='<c:out value="${quarto.numero}"/>'></td>
                        <td><button type="submit" name="botao" value="PesquisarNumero">Pesquisar</button></td>
                    </tr>
                    <tr>
                        <td><label for="andar">Andar:</label></td>
                        <td><input type="number" id="andar" name="andar" value='<c:out value="${quarto.andar}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="descricao">Descricao:</label></td>
                        <td><input type="text" id="descricao" name="descricao" value='<c:out value="${quarto.descricao}"/>'></td>
                    </tr>

                    <tr>
                        <td><label for="tipo_id">Tipo:</label></td>
                        <td>
                            <select name="tipo_id" id="tipo_id">
                                <c:forEach var="tipos" items="${tipos}">
                                    <option value="${tipos.id}"
                                        <c:if test="${quarto.tipo.id == tipos.id}">selected</c:if>
                                        >${tipos.nome}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
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
                                <td>${quartos.id}</td>
                                <td>${quartos.nome}</td>
                                <td>${quartos.descricao}</td>
                                <td>${quartos.tipo.nome}</td>
                                
                                <td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_quarto?acao=editar&id=${quarto.numero}">Editar</a>
								</td>
									
								<td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_quarto?acao=excluir&id=${quarto.numero}">Deletar</a>
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

