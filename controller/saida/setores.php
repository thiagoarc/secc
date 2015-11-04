<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT * FROM setor ORDER BY sigla";
	$stmt = $oConexao->prepare($sql);  
	$stmt->execute();
	$solicitacao = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($solicitacao);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>