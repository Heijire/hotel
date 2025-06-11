<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Cliente</title>
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
            <form action="cadastrar_cliente" method="post">
                <h1>Cadastrar Cliente</h1>
                <table>
                    <tr>
                        <td><label for="cpf">CPF:</label></td>
                        <td><input type="number" id="cpf" name="cpf" value='<c:out value="${cliente.cpf}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="nome">Nome:</label></td>
                        <td><input type="text" id="nome" name="nome" value='<c:out value="${cliente.nome}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="telefone">Telefone:</label></td>
                        <td><input type="tel" id="telefone" name="telefone" value='<c:out value="${cliente.telefone}"/>'></td>
                    </tr>
                    <tr>
                        <td><label for="cidade">Cidade:</label></td>
                        <td><input type="text" id="cidade" name="cidade" value='<c:out value="${cliente.cidade}"/>'></td>
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
            <c:if test="${not empty servicoss}">
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
                                
                                
                                <td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath}/cadastrar_cliente?acao=editar&id=${cliente.cpf}">Editar</a>
								</td>
									
								<td>
                                    <a class="a_link_clicavel"
									href="${pageContext.request.contextPath }/cadastrar_cliente?acao=excluir&id=${cliente.cpf}">Deletar</a>
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

