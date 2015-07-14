<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT * FROM produto WHERE id = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$produto = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($produto);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>