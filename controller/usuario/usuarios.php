<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT * FROM usuario ORDER BY nome asc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$usuarios = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($usuarios);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>