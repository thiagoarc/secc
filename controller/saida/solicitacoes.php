<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT idsaida, DATE_FORMAT(datasaida, '%d/%m/%Y') as datasaida, idusuario FROM saida WHERE idusuario = :idusuario ORDER BY datasaida desc LIMIT 0, $limit";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idusuario', $idusuario);
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