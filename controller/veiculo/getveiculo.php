<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT * FROM veiculo WHERE idveiculo = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$veiculo = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($veiculo);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>