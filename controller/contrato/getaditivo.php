<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		//$stmt = $oConexao->prepare("SELECT * FROM contrato WHERE idcontrato = :id");  
		$stmt = $oConexao->prepare("SELECT a.idaditivo, a.idcontrato, a.numero, a.valor, DATE_FORMAT(a.validade, '%d%m%Y') as validade, a.obs, c.numerocontrato, TIMESTAMPDIFF(DAY, now(), a.validade) AS diasrestantes FROM aditivo a, contrato c WHERE a.idcontrato = c.idcontrato AND a.idaditivo = :id");  
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