package br.edu.fateczl.Hotel.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class RelatorioController {
	@Autowired
	private DataSource ds;

    @RequestMapping("/relatorios")
    public String abrirPaginaRelatorios() {
        return "relatorios"; 
    }
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(name = "relatorios_disp", value = "/relatorios_disp", method = RequestMethod.POST)
	public ResponseEntity geraRelatorioDisp(@RequestParam Map<String, String> params) {
		String erro = "";
		String data = params.get("datadisp");

		Map<String, Object> relatorioparams = new HashMap<String, Object>();
		relatorioparams.put("data", data);
		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders headers = new HttpHeaders();

		Connection conn = DataSourceUtils.getConnection(ds);
		try {
			File arquivo = ResourceUtils.getFile("classpath:/reports/quarto.jasper");
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, relatorioparams, conn);
		} catch (Exception e) {
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				ByteArrayInputStream stream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(stream);
				headers.setContentLength(bytes.length);
				headers.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}

		return new ResponseEntity(resource, headers, status);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(name = "relatorios_Cliente", value = "/relatorios_Cliente", method = RequestMethod.POST)
	public ResponseEntity geraRelatorioCliente(@RequestParam Map<String, String> params) {
		String erro = "";
		String hospedagem_id = params.get("hospedagem_id");

		Map<String, Object> relatorioparams = new HashMap<String, Object>();
		relatorioparams.put("hospedagem_id", hospedagem_id);
		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders headers = new HttpHeaders();

		Connection conn = DataSourceUtils.getConnection(ds);
		try {
			File arquivo = ResourceUtils.getFile("classpath:/reports/TOTAL.jasper");
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, relatorioparams, conn);
		} catch (Exception e) {
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				ByteArrayInputStream stream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(stream);
				headers.setContentLength(bytes.length);
				headers.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}

		return new ResponseEntity(resource, headers, status);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(name = "relatorios_Dia", value = "/relatorios_Dia", method = RequestMethod.POST)
	public ResponseEntity geraRelatorio(@RequestParam Map<String, String> params) {
		String erro = "";
		String data = params.get("data");

		Map<String, Object> relatorioparams = new HashMap<String, Object>();
		relatorioparams.put("data", data);
		byte[] bytes = null;

		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders headers = new HttpHeaders();

		Connection conn = DataSourceUtils.getConnection(ds);
		try {
			File arquivo = ResourceUtils.getFile("classpath:/reports/Reservas.jasper");
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, relatorioparams, conn);
		} catch (Exception e) {
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				ByteArrayInputStream stream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(stream);
				headers.setContentLength(bytes.length);
				headers.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}

		return new ResponseEntity(resource, headers, status);
	}
}
