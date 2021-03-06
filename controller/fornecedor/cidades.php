<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT * FROM cidade WHERE iduf = :iduf ORDER BY nome asc";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('iduf', $params->iduf);
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