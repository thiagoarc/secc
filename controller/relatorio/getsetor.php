<?php 	

$oConexao = Conexao::getInstance();

try{

	$stmt = $oConexao->prepare("SELECT idsetor as id, nome, sigla FROM setor ORDER BY nome");  
	$stmt->execute();
	$setor = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($setor);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>