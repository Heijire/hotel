package br.edu.fateczl.Hotel.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import br.edu.fateczl.Hotel.model.Quarto;

public interface QuartoRepository extends JpaRepository<Quarto, Integer> {
	@Query(value = "SELECT * FROM dbo.fn_quartosdisponivel(:dataEntrada, :quantidadeDias)", nativeQuery = true)
	public List<Object[]> findQuartosDisponiveis(@Param("dataEntrada") LocalDate data,
			@Param("quantidadeDias") int quantidade);

}