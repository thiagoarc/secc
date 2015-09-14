<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		//$stmt = $oConexao->prepare("SELECT * FROM contrato WHERE idcontrato = :id");  
		$stmt = $oConexao->prepare("SELECT idaditivo, idcontrato, numero, valor, DATE_FORMAT(validade, '%d%m%Y') as validade, obs FROM aditivo WHERE idaditivo = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$fornecedor = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($fornecedor);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>