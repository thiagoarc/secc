<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT * FROM veiculo v, setor s WHERE v.idsetor = s.idsetor ORDER BY v.placa asc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$veiculos = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($veiculos);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>