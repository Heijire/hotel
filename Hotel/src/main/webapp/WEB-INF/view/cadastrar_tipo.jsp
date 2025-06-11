<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar tipo</title>
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
            <form action="cadastrar_tipo" method="post">
                <h1>Cadastrar Tipo de Quarto</h1>
                <table>
                    <input type="hidden" name="id" value="${tipo.id}">
                    <tr>
                        <td><label for="nome">Nome da categoria:</label></td>
                        <td><input type="text" id="nome" name="nome" value='<c:out value="${tipo.nome}"/>'></td>
                        <td><button type="submit" name="botao" value="PesquisarCategoria">Pesquisar</button></td>
                    </tr>
                    <tr>
                        <td><label for="valor">Valor:</label></td>
                        <td><input type="number" id="valor" name="valor" value='<c:out value="${tipo.valor}"/>' min="0" step="0.01"></td>
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
                                
                                <td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_tipo?acao=editar&id=${tipo.id}">Editar</a>
								</td>
									
								<td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_tipo?acao=excluir&id=${tipo.id}">Deletar</a>
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

