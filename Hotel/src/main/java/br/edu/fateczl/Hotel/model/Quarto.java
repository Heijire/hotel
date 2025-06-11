package br.edu.fateczl.Hotel.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@Table(name = "quarto")
public class Quarto {
	
	@Id
	@Column(name = "numero", nullable = false)
	private int numero;
	
	@Column(name = "andar", nullable = false)
	private int andar;
	
	@Column(name = "descricao", length =255, nullable = false)
	private String descricao;
	
	@ManyToOne(targetEntity = Tipo.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "tipo_id", nullable = false)
	private Tipo tipo;

}
