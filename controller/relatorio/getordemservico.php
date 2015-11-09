<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	//return JSON
	$ordem = array();

	if( $params->osinicio == null || $params->osfinal == null ){

		$stmt = $oConexao->prepare("SELECT os.idordem_servico, os.idcontratoaditivo, os.tipo, DATE_FORMAT(os.datasolicitacao, '%d%m%Y') as datasolicitacao, c.numerocontrato, c.valor as valorcontrato, DATE_FORMAT(c.validade, '%d%m%Y') as validadecontrato, a.numero as numeroaditivo, a.valor as valoraditivo, DATE_FORMAT(a.validade, '%d%m%Y') as validadeaditivo
									FROM ordem_servico os
									LEFT JOIN contrato c ON (os.idcontratoaditivo = c.idcontrato)
									LEFT JOIN aditivo a ON (os.idcontratoaditivo = a.idaditivo)");  
		$stmt->execute();

	}else{

		$osinicio 	= formata_data_en_US( $params->osinicio );
		$osfinal 	= formata_data_en_US( $params->osfinal );

		$stmt = $oConexao->prepare("SELECT os.idordem_servico, os.idcontratoaditivo, os.tipo, DATE_FORMAT(os.datasolicitacao, '%d%m%Y') as datasolicitacao, c.numerocontrato, c.valor as valorcontrato, DATE_FORMAT(c.validade, '%d%m%Y') as validadecontrato, a.numero as numeroaditivo, a.valor as valoraditivo, DATE_FORMAT(a.validade, '%d%m%Y') as validadeaditivo
									FROM ordem_servico os
									LEFT JOIN contrato c ON (os.idcontratoaditivo = c.idcontrato)
									LEFT JOIN aditivo a ON (os.idcontratoaditivo = a.idaditivo)
									WHERE
										os.datasolicitacao >= :dtainicio
										AND
										os.datasolicitacao <= :dtafinal");  
		$stmt->bindParam('dtainicio',  $osinicio);
		$stmt->bindParam('dtafinal', $osfinal);
		$stmt->execute();

	}

	$osItem = $stmt->fetchAll(PDO::FETCH_ASSOC);

	if( $osItem ){
		$i = 0;
		foreach( $osItem as $row ){

			$valorOS = 0;

			//informações comuns
			$ordem[$i]['idos'] = $row['idordem_servico'];
			$ordem[$i]['idcontratoaditivo'] = $row['idcontratoaditivo'];
			$ordem[$i]['tipo'] = $row['tipo'];
			$ordem[$i]['datasolicitacao'] = $row['datasolicitacao'];

			if( $row['tipo'] == 1 ){ //contrato

				$ordem[$i]['numerocontrato'] 	= $row['numerocontrato'];
				$ordem[$i]['valorcontrato'] 	= $row['valorcontrato'];
				$ordem[$i]['validadecontrato'] 	= $row['validadecontrato'];


			}else if( $row['tipo'] == 2 ){ //aditivo

				$ordem[$i]['numeroaditivo'] 	= $row['numeroaditivo'];
				$ordem[$i]['valoraditivo'] 		= $row['valoraditivo'];
				$ordem[$i]['validadeaditivo'] 	= $row['validadeaditivo'];

			}

			$stmtca = $oConexao->prepare("SELECT osi.iditens_ordem_servico as iditem, osi.idordem_servico as idos, osi.descricao, osi.qtd, osi.valorunitario, und.sigla, und.idunidade_medida 
											FROM itens_ordem_servico osi
											INNER JOIN unidade_medida und ON(osi.idunidade_medida = und.idunidade_medida)
												WHERE osi.idordem_servico = :ios ORDER by osi.descricao");
			$stmtca->bindParam('ios', $row['idordem_servico']);
			$stmtca->execute();
			$stmtcontratoaditivo = $stmtca->fetchAll(PDO::FETCH_ASSOC);
			if( $stmtcontratoaditivo ){
				foreach( $stmtcontratoaditivo as $l ){

					$v = $l['qtd'] * $l['valorunitario'];
					$valorOS += $v;

				}
			}

			$ordem[$i]['valortotalos'] = $valorOS;

			$i++;
		}

		echo json_encode($ordem);

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