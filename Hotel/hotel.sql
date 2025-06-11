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
	h.dt_entrada as DataEntrada, DATEADD(day, h.qnt_dias-1, h.dt_entrada),
	t.preco as Diaria, h.qnt_dias * preco as SomaDiarias,
	dbo.fn_total_hospedagem(h.id) as ValorTotal

	from hospedagem h
	join cliente c 
	on c.cpf = h.cliente_cpf
	join quarto q 
	on q.numero = h.quarto_numero
	join tipo t
	on t.id = q.tipo_id
	where h.id = @idhospedagem

	select u.dt_usada as Data,
		s.nome as Servico,
		s.descricao as Descricao,
		s.valor as valor
	from servicos_consumidos u
	join servicos s
	on s.id = u.servico_id
	where u.hospedagem_id = @idhospedagem
	order by u.dt_usada asc
end 
go
create procedure sp_relatorios(@data date)
as 
begin
	select r.id, c.nome as NomeCliente, c.cpf as CPF, c.telefone as Telefone, c.cidade as Cidade, 
		q.numero as NumeroQuarto, q.andar as Andar, q.descricao as Descricao, t.nome as Tipo, t.preco as Diaria,
		r.qnt_dias as QuantidadeDias, r.dt_entrada as Data_Inicial, DATEADD(day, r.qnt_dias - 1, r.dt_entrada) as Data_Final, 
		(r.qnt_dias * t.preco) as Valor_Diarias

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