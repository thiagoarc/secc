<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->numero != '' ){

		$keysearch = "%{$params->numero}%";

		$stmt = $oConexao->prepare("SELECT idcontrato, numerocontrato as contrato, DATE_FORMAT(validade, '%d%m%Y') as validade, valor FROM contrato WHERE numerocontrato LIKE :numero AND validade >= now() LIMIT 0,5");  
		$stmt->bindParam('numero', $keysearch, PDO::PARAM_STR);
		$stmt->execute();
		$contrato = $stmt->fetchAll(PDO::FETCH_OBJ);

		if( $contrato ){
			echo json_encode($contrato);
		}else{

			$stmt = $oConexao->prepare("SELECT idcontrato, idaditivo, numero as contrato, DATE_FORMAT(validade, '%d%m%Y') as validade, valor, obs FROM aditivo WHERE numero LIKE :numero AND validade >= now() LIMIT 0,5");
			$stmt->bindParam('numero', $keysearch, PDO::PARAM_STR);
			$stmt->execute();
			$aditivo = $stmt->fetchAll(PDO::FETCH_OBJ);

			if( $aditivo ){
				echo json_encode($aditivo);
			}else{
				echo '{ "message": "noresults" }';
			}

		}

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>