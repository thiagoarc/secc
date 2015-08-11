<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT f.*, c.idcidade, c.nome as cidade FROM fornecedor f, cidade c WHERE f.idcidade = c.idcidade AND f.idfornecedor = :id");  
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