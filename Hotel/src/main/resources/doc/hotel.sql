use master
go
drop database if exists hotel
go
create database hotel
go
use hotel
go
create table cliente(
	cpf int not null,
	nome varchar(90) not null,
	telefone int not null,
	cidade varchar(90) not null
	primary key(cpf)
)
go
create table tipo(
	id int not null,
	nome varchar(80) not null,
	preco decimal(7,2) not null
	primary key(id)
)
go
create table quarto(
	tipo_id int not null,
	numero int not null,
	andar int not null,
	descricao varchar(255) not null,
	primary key(numero),
	foreign key(tipo_id) references tipo(id)
)
go
create table servicos(
	id int not null,
	nome varchar(80) not null,
	descricao varchar(255) not null,
	valor decimal(7,2) not null
	primary key (id)
)
go
create table reserva(
	id int not null,
	cliente_cpf int NOT NULL,
	quarto_numero int not null,
	qnt_dias int not null,
	dt_entrada date not null
	primary key(id),
	foreign key (cliente_cpf) references cliente(cpf),
	foreign key (quarto_numero) references quarto(numero)
)
go
create table hospedagem(
	id int not null,
	cliente_cpf int not null,
	quarto_numero int not null,
	dt_entrada date not null, 
	qnt_dias int not null,
	primary key(id),
	foreign key (cliente_cpf) references cliente(cpf),
	foreign key (quarto_numero) references quarto(numero)
)
go
create table servicos_consumidos(
	id int not null,
	hospedagem_id int not null,
	servico_id int not null,
	dt_usada date not null
	primary key (id),
	foreign key (hospedagem_id) references hospedagem(id),
	foreign key (servico_id) references servicos(id)
)
go



create function fn_quartosdisponivel(
	@datainicial date,
	@quantidade int
) 
returns @quartos table (
	numero int,
	andar int,
	descricao varchar(100),
	nometipo varchar(100),
	preco decimal(7,2)
)
as
begin
	declare @numero int, 
	@status bit,
	@datafim date
	set @datafim = DATEADD(day, @quantidade-1, @datainicial)

	declare cursor_quarto cursor for select numero from quarto
	open cursor_quarto
	fetch next from cursor_quarto into @numero

	while @@FETCH_STATUS = 0
	begin
		set @status = 0

		if exists( select 1 from hospedagem
					where hospedagem.quarto_numero = @numero
					and ( @datainicial <= DATEADD(day, hospedagem.qnt_dias-1, hospedagem.dt_entrada)
					and @datafim >= hospedagem.dt_entrada
				)
		)
		begin
			set @status = 1
		end

		if (@status = 0)
		begin
			insert into @quartos (numero, andar, descricao, nometipo, preco )
			select 
				quarto.numero, quarto.andar, quarto.descricao, tipo.nome, tipo.preco
			from quarto
			left join tipo
			on tipo.id = quarto.tipo_id
			where quarto.numero = @numero
		end

		fetch next from cursor_quarto into @numero
	end

	close cursor_quarto
	deallocate cursor_quarto
	return
end
go

create function fn_total_hospedagem (@idhospedagem int)
returns decimal(10,2)
as
begin
	declare @totalHospedagem decimal(10,2)
	declare @totalServicos decimal(10,2)

	select @totalHospedagem = h.qnt_dias * t.preco
		from hospedagem h
		join quarto q on q.numero = h.quarto_numero
		join tipo t on t.id = q.tipo_id
		where h.id = @idhospedagem
	select @totalServicos = isnull(sum(s.valor), 0)
		from servicos_consumidos u
		join servicos s on s.id = u.servico_id
		where u.hospedagem_id = @idhospedagem
	return isnull(@totalHospedagem, 0) + isnull(@totalServicos, 0)
end
go

go
create procedure sp_hospedagem(@idhospedagem int)
as
begin
	select c.nome as NomeCliente, c.cpf as CPF, c.telefone as telefone, c.cidade as Cidade,
	q.numero as NumeroQuarto, t.nome as TipoQuarto, 
	h.dt_entrada as DataEntrada, DATEADD(day, h.qnt_dias-1, h.dt_entrada) as Saida,
	t.preco as Diaria, h.qnt_dias * preco as SomaDiarias,
	dbo.fn_total_hospedagem(h.id) as ValorTotal

	from hospedagem h
	join cliente c 
	on c.cpf = h.cliente_cpf
	join quarto q 
	on q.numero = h.quarto_numero
	join tipo t
	on t.id = q.tipo_id
	where h.id = @idhospedagem -- 1

	select u.dt_usada as Data,
		s.nome as Servico,
		s.descricao as Descricao,
		s.valor as valor
	from servicos_consumidos u
	join servicos s
	on s.id = u.servico_id
	where u.hospedagem_id = @idhospedagem --1
	order by u.dt_usada asc
end 
go
create procedure sp_relatorios(@data date)
as 
begin
	select r.id, c.nome , c.cpf, c.telefone , c.cidade , 
		q.numero , q.andar, q.descricao , t.nome as tipo_quarto , t.preco,
		r.qnt_dias , r.dt_entrada, DATEADD(day, r.qnt_dias - 1, r.dt_entrada)  AS data_final, 
		(r.qnt_dias * t.preco) AS valor_diarias

	from reserva r
	join cliente c
	on c.cpf = r.cliente_cpf
	join quarto q 
	on q.numero = r.quarto_numero
	join tipo t on t.id = q.tipo_id
	where r.dt_entrada = @data
	order by c.nome
end 
go

-- CLIENTES
INSERT INTO cliente (cpf, nome, telefone, cidade) VALUES
(11111, 'Maria Silva', 990010001, 'Recife'),
(22222, 'João Souza', 990010002, 'Olinda'),
(33333, 'Ana Costa', 990010003, 'Paulista');

-- TIPOS DE QUARTO
INSERT INTO tipo (id, nome, preco) VALUES
(1, 'Standard', 150.00),
(2, 'Luxo', 300.00),
(3, 'Executivo', 450.00);

-- QUARTOS
INSERT INTO quarto (tipo_id, numero, andar, descricao) VALUES
(1, 101, 1, 'Quarto com cama de casal e ventilador'),
(2, 202, 2, 'Quarto com ar-condicionado e TV LED'),
(3, 303, 3, 'Suíte com vista para o mar, banheira e Wi-Fi');

-- SERVIÇOS
INSERT INTO servicos (id, nome, descricao, valor) VALUES
(1, 'Café da manhã', 'Serviço de café da manhã incluso', 25.00),
(2, 'Lavanderia', 'Serviço de lavanderia para roupas pessoais', 35.00),
(3, 'SPA', 'Acesso ao SPA e massagem relaxante', 100.00);

-- RESERVAS (data usada para testar relatórios)
INSERT INTO reserva (id, cliente_cpf, quarto_numero, qnt_dias, dt_entrada) VALUES
(1, 11111, 101, 2, '2025-06-15'),
(2, 22222, 202, 3, '2025-06-15'),
(3, 33333, 303, 1, '2025-06-16');

-- HOSPEDAGENS
INSERT INTO hospedagem (id, cliente_cpf, quarto_numero, dt_entrada, qnt_dias) VALUES
(1, 11111, 101, '2025-06-10', 3),
(2, 22222, 202, '2025-06-14', 4);

-- SERVIÇOS CONSUMIDOS
INSERT INTO servicos_consumidos (id, hospedagem_id, servico_id, dt_usada) VALUES
(1, 1, 1, '2025-06-10'),
(2, 1, 2, '2025-06-11'),
(3, 2, 1, '2025-06-14'),
(4, 2, 3, '2025-06-15');

go
SELECT 
    c.cpf,    c.nome AS cliente_nome,
    h.dt_entrada, h.qnt_dias, DATEADD(day, h.qnt_dias - 1, h.dt_entrada) as saida,
    q.numero,t.nome AS tipo_quarto, t.preco,
    s.nome AS servico_nome,   s.valor AS servico_valor,    sc.dt_usada
FROM hospedagem h
JOIN cliente c ON h.cliente_cpf = c.cpf
JOIN quarto q ON h.quarto_numero = q.numero
JOIN tipo t ON q.tipo_id = t.id
LEFT JOIN servicos_consumidos sc ON h.id = sc.hospedagem_id
LEFT JOIN servicos s ON sc.servico_id = s.id
WHERE h.id = 1