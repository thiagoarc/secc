<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		//$stmt = $oConexao->prepare("SELECT * FROM contrato WHERE idcontrato = :id");  
		$stmt = $oConexao->prepare("SELECT idcontrato, idorgao, tipo, tipoobjetos, numerotali, DATE_FORMAT(dataassinaturatali, '%d%m%Y') as dataassinaturatali, numeroata, DATE_FORMAT(validadeata, '%d%m%Y') as validadeata, numeropregao, 
			numeroprocesso, numerocd, numeroparecerjuridico, DATE_FORMAT(datacompra, '%d%m%Y') as datacompra, numerocontrato, objeto, valor, DATE_FORMAT(validade, '%d%m%Y') as validade, DATE_FORMAT(dataassinatura, '%d%m%Y') as dataassinatura, numeroempenho, TIMESTAMPDIFF(DAY, now(), validade) AS diasrestantes FROM contrato WHERE idcontrato = :id");  
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