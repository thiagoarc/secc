<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT * FROM aditivo WHERE idcontrato = :idcontrato ORDER BY idaditivo asc LIMIT 0, $limit";
	$stmt = $oConexao->prepare($sql);
	$stmt->bindParam('idcontrato', $params->id);
	$stmt->execute();  
	$cidades = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($cidades);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>