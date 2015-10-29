<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->numero != '' ){

		$keysearch = $params->numero;

		$stmt = $oConexao->prepare("SELECT * FROM ordem_servico WHERE idordem_servico = :numero");  
		$stmt->bindParam('numero', $keysearch, PDO::PARAM_STR);
		$stmt->execute();
		
		//$os = "";

		if( $stmt->rowCount() > 0){
			$os = $stmt->fetchAll(PDO::FETCH_OBJ);

			// if($os1->tipo == 1){
			// 	$stmt = $oConexao->prepare("SELECT c.idcontrato, c.numerocontrato as contrato, DATE_FORMAT(c.validade, '%d%m%Y') as validadecontrato, c.valor, os.idordem_servico, DATE_FORMAT(os.datasolicitacao, '%d%m%Y') as datasolicitacao FROM ordem_servico os, contrato c WHERE os.idordem_servico = :numero AND os.idcontratoaditivo = c.idcontrato LIMIT 0,5");  
			// 	$stmt->bindParam('numero', $os1->idordem_servico, PDO::PARAM_STR);
			// 	$stmt->execute();
			// 	$os = $stmt->fetchAll(PDO::FETCH_OBJ);
			// }else{
			// 	$stmt = $oConexao->prepare("SELECT a.idcontrato, a.idaditivo, a.numero as contrato, DATE_FORMAT(a.validade, '%d%m%Y') as validade, a.valor, a.obs, os.idordem_servico, DATE_FORMAT(os.datasolicitacao, '%d%m%Y') as datasolicitacao FROM ordem_servico os, aditivo a WHERE os.idordem_servico = :numero AND os.idcontratoaditivo = a.idaditivo LIMIT 0,5");  
			// 	$stmt->bindParam('numero', $os1->idordem_servico, PDO::PARAM_STR);
			// 	$stmt->execute();
			// 	$os = $stmt->fetchAll(PDO::FETCH_OBJ);
			// }

			echo json_encode($os);
		}else{
			echo '{ "message": "noresults" }';
		}

		//}

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>