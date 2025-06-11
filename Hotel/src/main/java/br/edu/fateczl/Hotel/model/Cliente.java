package br.edu.fateczl.Hotel.model;

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
@Table(name = "cliente")
public class Cliente {
	
	@Id
	@Column(name = "cpf", nullable = false)
	private int cpf;
	
	@Column(name = "nome", length = 90, nullable = false)
	private String nome;
	
	@Column(name = "telefone", nullable = false)
	private int telefone;
	
	@Column(name = "cidade", length = 90, nullable = false)
	private String cidade;

}
