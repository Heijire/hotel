package br.edu.fateczl.Hotel.model;

import java.math.BigDecimal;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
@Table(name = "tipo")
public class Tipo {
	
	@Id
	@Column(name = "id",  nullable = false)
	private int id;
	
	@Column(name = "nome", length = 80, nullable = false)
	private String nome;
	
	@Column(name = "valor", precision = 7, scale = 2, nullable = false)
	private BigDecimal valor;

}
