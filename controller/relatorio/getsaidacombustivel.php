<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	//return JSON
	$saida = array();

	if( $params->osinicio == null || $params->osfinal == null ){

		$stmt = $oConexao->prepare("SELECT s.idsaida, DATE_FORMAT(s.datasaida, '%d%m%Y') as datasaida, s.idusuario, se.sigla, 
										   se.nome, v.placa, v.motorista, v.modelo 
										FROM saida s, setor se, veiculo v 
											WHERE 
												s.idveiculo = v.idveiculo 
											AND 
												s.idsetor = se.idsetor 
											ORDER BY s.datasaida desc");  
		$stmt->execute();

	}else{

		$osinicio 	= formata_data_en_US( $params->osinicio );
		$osfinal 	= formata_data_en_US( $params->osfinal );

		$stmt = $oConexao->prepare("SELECT s.idsaida, DATE_FORMAT(s.datasaida, '%d%m%Y') as datasaida, s.idusuario, se.sigla, 
										   se.nome, v.placa, v.motorista, v.modelo 
										FROM saida s, setor se, veiculo v 
											WHERE 
												s.idveiculo = v.idveiculo 
											AND 
												s.idsetor = se.idsetor
											AND
												s.datasaida >= :dtainicio
											AND
												s.datasaida <= :dtafinal");  
		$stmt->bindParam('dtainicio',  $osinicio);
		$stmt->bindParam('dtafinal', $osfinal);
		$stmt->execute();

	}

	$osItem = $stmt->fetchAll(PDO::FETCH_ASSOC);

	if( $osItem ){
		$i = 0;
		foreach( $osItem as $row ){

			$qtdLT = 0;

			//informações comuns
			$saida[$i]['idsaida'] 			= $row['idsaida'];
			$saida[$i]['datasaida'] 		= $row['datasaida'];
			$saida[$i]['setorsigla'] 		= $row['sigla'];
			$saida[$i]['setornome'] 		= $row['nome'];
			$saida[$i]['veiculoplaca'] 		= $row['placa'];
			$saida[$i]['veiculomotorista'] 	= $row['motorista'];
			$saida[$i]['veiculomodelo'] 	= $row['modelo'];

			$stmtca = $oConexao->prepare("SELECT qtd 
											FROM saida_produto osi
												WHERE saida_idsaida = :idsaida");
			$stmtca->bindParam('idsaida', $row['idsaida']);
			$stmtca->execute();
			$stmtsaida = $stmtca->fetchAll(PDO::FETCH_ASSOC);
			if( $stmtsaida ){
				foreach( $stmtsaida as $l ){

					$v = $l['qtd'];
					$qtdLT += $v;

				}
			}

			$saida[$i]['qtdtotal'] = $qtdLT;

			$i++;
		}

		echo json_encode($saida);

	}else{
		echo '{ "message": "noresults" }';
	}


	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}


?>