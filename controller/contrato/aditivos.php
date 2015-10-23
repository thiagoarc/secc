<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT a.idaditivo, a.idcontrato, a.numero, a.valor, DATE_FORMAT(a.validade, '%d/%m/%Y') as validade, a.obs, c.numerocontrato FROM aditivo a, contrato c WHERE a.idcontrato = c.idcontrato AND a.idcontrato = :idcontrato ORDER BY a.idaditivo asc LIMIT 0, $limit";
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