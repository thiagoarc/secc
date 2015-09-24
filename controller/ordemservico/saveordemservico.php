<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->ordem && $params->produtos && sizeof($params->produtos) > 0 ){


		// print_r($params->ordem);
		// print_r($params->produtos);

		//inserção da ordem de serviço
		$stmt = $oConexao->prepare("INSERT INTO ordem_servico(idcontratoaditivo, tipo, datasolicitacao) VALUES(?, ?, now())");  
		$stmt->bindValue(1, $params->ordem->contratoaditivo);
		$stmt->bindValue(2, $params->ordem->tipo); //1 - Contrato ou 2 - Aditivo
		$os = $stmt->execute();
		$idos = $oConexao->lastInsertId('idordem_servico');

		if( $os ){
			for( $i = 0; $i < sizeof($params->produtos); $i++ ){
				if( $params->produtos[$i]->qtdordem > 0 ){
					//deduzir a quantidade do item
					if( $params->ordem->tipo == 1 ){ //deduzir do itens_contrato
						$stmt = $oConexao->prepare("UPDATE itens_contrato SET qtdordem = (qtd - ?) WHERE idcontrato = ? AND iditens_contrato = ?");  
						$stmt->bindValue(1, $params->produtos[$i]->qtdordem);
						$stmt->bindValue(2, $params->ordem->contratoaditivo);
						$stmt->bindValue(3, $params->produtos[$i]->iditem);
						$stmt->execute();
					}else if( $params->ordem->tipo == 2 ){ //deduzir do itens_aditivo
						$stmt = $oConexao->prepare("UPDATE itens_aditivo SET qtdordem = (qtd - ?) WHERE idaditivo = ? AND iditens_aditivo = ?");  
						$stmt->bindValue(1, $params->produtos[$i]->qtdordem);
						$stmt->bindValue(2, $params->ordem->contratoaditivo);
						$stmt->bindValue(3, $params->produtos[$i]->iditem);
						$stmt->execute();
					}
					//inserção dos itens do serviço
					$stmt = $oConexao->prepare("INSERT INTO itens_ordem_servico(idordem_servico, descricao, qtd, valorunitario, idunidade_medida, iditens_contratoaditivo) 
												VALUES(?, ?, ?, ?, ?, ?)");
					$stmt->bindValue(1, $idos);
					$stmt->bindValue(2, $params->produtos[$i]->descricao);
					$stmt->bindValue(3, $params->produtos[$i]->qtdordem);
					$stmt->bindValue(4, $params->produtos[$i]->valorunitario);
					$stmt->bindValue(5, $params->produtos[$i]->idunidade_medida);
					$stmt->bindValue(6, $params->produtos[$i]->iditem);
					$stmt->execute();

					//verificar a existencia do produto
					$stmt = $oConexao->prepare("SELECT idproduto FROM produto WHERE idfornecedor = ? AND idunidade_medida = ? AND descricao = ? AND valorunitario = ?");  
					$stmt->bindValue(1, $params->produtos[$i]->idfornecedor);
					$stmt->bindValue(2, $params->produtos[$i]->idunidade_medida);
					$stmt->bindValue(3, $params->produtos[$i]->descricao);
					$stmt->bindValue(4, $params->produtos[$i]->valorunitario);
					$stmt->execute();

					if( $stmt->rowCount() == 0 ){
						//inserção de produto
						$stmt = $oConexao->prepare("INSERT INTO produto(idfornecedor, idunidade_medida, descricao, valorunitario) 
													VALUES(?, ?, ?, ?)");
						$stmt->bindValue(1, $params->produtos[$i]->idfornecedor);
						$stmt->bindValue(2, $params->produtos[$i]->idunidade_medida);
						$stmt->bindValue(3, $params->produtos[$i]->descricao);
						$stmt->bindValue(4, $params->produtos[$i]->valorunitario);
						$stmt->execute();
					}
				}
			}
			echo '{ "message": "success", "msg_success": "Cadastro realizado com sucesso." }';
		}else{
			echo '{ "message": "error" }';
		}

	}else{
		echo '{ "message": "error" }';
	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>