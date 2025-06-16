package br.edu.fateczl.Hotel.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "servicos_consumidos")
public class ServicosConsumidos {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private int id;

	@ManyToOne(targetEntity = Servicos.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "servicos", nullable = false)
	private Servicos servicos;

	@ManyToOne(targetEntity = Hospedagem.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "hospedagem_id", nullable = false)
	private Hospedagem hospedagem;

	@Column(name = "dt_usada", nullable = false)
	private LocalDate dtUsada;

}
