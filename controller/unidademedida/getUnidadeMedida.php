<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT * FROM unidade_medida WHERE idunidade_medida = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$unidademedida = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($unidademedida);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>