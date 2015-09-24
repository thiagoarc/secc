<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT idordem_servico as idos, idcontratoaditivo, tipo, DATE_FORMAT(datasolicitacao, '%d%m%Y') as datasolicitacao  FROM ordem_servico ORDER BY idos desc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$os = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	if( $os ){
		echo json_encode($os);
	}else{
		echo '{ "message": "noresults" }';
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>