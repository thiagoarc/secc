<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idos != '' ){

		//return JSON
		$ordem = array();

		$stmt = $oConexao->prepare("SELECT os.idordem_servico, os.idcontratoaditivo, os.tipo, c.numerocontrato, c.valor as valorcontrato, c.numeroata, c.numeropregao, DATE_FORMAT(c.validade, '%d%m%Y') as validadecontrato, a.numero as numeroaditivo, a.valor as valoraditivo, DATE_FORMAT(a.validade, '%d%m%Y') as validadeaditivo
										FROM ordem_servico os
										LEFT JOIN contrato c ON (os.idcontratoaditivo = c.idcontrato)
										LEFT JOIN aditivo a ON (os.idcontratoaditivo = a.idaditivo)
											WHERE os.idordem_servico = :ios");  
		$stmt->bindParam('ios', $params->idos);
		$stmt->execute();
		$osItem = $stmt->fetchAll(PDO::FETCH_ASSOC);

		if( $osItem ){
			$i = 0;
			foreach( $osItem as $row ){

				//informações comuns
				$ordem[$i]['idos'] = $row['idordem_servico'];
				$ordem[$i]['idcontratoaditivo'] = $row['idcontratoaditivo'];
				$ordem[$i]['tipo'] = $row['tipo'];

				if( $row['tipo'] == 1 ){ //contrato

					$ordem[$i]['numerocontrato'] 	= $row['numerocontrato'];
					$ordem[$i]['valorcontrato'] 	= $row['valorcontrato'];
					$ordem[$i]['validadecontrato'] 	= $row['validadecontrato'];
					$ordem[$i]['numeroata'] 		= $row['numeroata'];
					$ordem[$i]['numeropregao'] 		= $row['numeropregao'];

				}else if( $row['tipo'] == 2 ){ //aditivo

					$ordem[$i]['numeroaditivo'] 	= $row['numeroaditivo'];
					$ordem[$i]['valoraditivo'] 		= $row['valoraditivo'];
					$ordem[$i]['validadeaditivo'] 	= $row['validadeaditivo'];

				}

				$stmtca = $oConexao->prepare("SELECT osi.iditens_ordem_servico as iditem, osi.idordem_servico as idos, osi.descricao, osi.qtd, osi.valorunitario, und.sigla, und.idunidade_medida 
												FROM itens_ordem_servico osi
												INNER JOIN unidade_medida und ON(osi.idunidade_medida = und.idunidade_medida)
													WHERE osi.idordem_servico = :ios ORDER by osi.descricao");
				$stmtca->bindParam('ios', $params->idos);
				$stmtca->execute();
				$stmtcontratoaditivo = $stmtca->fetchAll(PDO::FETCH_ASSOC);
				if( $stmtcontratoaditivo ){
					foreach( $stmtcontratoaditivo as $l ){
						$item['iditem'] 			= $l['iditem'];
						$item['descricao'] 			= $l['descricao'];
						$item['qtd'] 				= $l['qtd'];
						$item['valorunitario'] 		= $l['valorunitario'];
						$item['sigla'] 				= $l['sigla'];
						$item['idunidade_medida'] 	= $l['idunidade_medida'];

						//add item a ordem de servico
						$ordem[$i]['item'][] = $item;

					}
				}

				$i++;
			}

			echo json_encode($ordem);

		}else{
			echo '{ "message": "noresults" }';
		}

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}


?>