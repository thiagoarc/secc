<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idos != '' ){

		$stmtOS = $oConexao->prepare("SELECT idordem_servico as idos, qtd, iditens_contratoaditivo as iditem FROM itens_ordem_servico WHERE idordem_servico = ?");  
		$stmtOS->bindValue(1, $params->idos);
		$osItem = $stmtOS->execute();
		
		if( $osItem ){
			if( $params->tipo == 1 ){ //contrato

				//devolução da quantidade os itens do contrato
				while ( $l = $stmtOS->fetch(PDO::FETCH_OBJ) ) {
					$stmt = $oConexao->prepare("UPDATE itens_contrato SET qtdordem = (qtdordem + ?) WHERE iditens_contrato = ?");
					$stmt->bindValue(1, $l->qtd);
					$stmt->bindValue(2, $l->iditem);
					$stmt->execute();
				}

				//exclusão do itens da ordem de serviço
				$stmt = $oConexao->prepare("DELETE FROM itens_ordem_servico WHERE idordem_servico = ?");
				$stmt->bindValue(1, $params->idos);
				$stmt->execute();

				//exclusão
				$stmt = $oConexao->prepare("DELETE FROM ordem_servico WHERE idordem_servico = ?");
				$stmt->bindValue(1, $params->idos);
				$stmt->execute();

				echo '{ "message": "success", "msg_success": "Ordem de serviço cancelado com sucesso." }';

			}else if( $params->tipo == 2 ){ //aditivo

			}
		}else{
			echo '{ "message": "noresults" }';
		}

		// if( $osItem && $stmt->rowCount() > 0 ){
		// 	echo json_encode($osItem);
		// }else{
			
		// }

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>