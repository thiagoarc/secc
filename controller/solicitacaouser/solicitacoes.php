<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT idsolicitacao, DATE_FORMAT(datasolicitacao, '%d/%m/%Y') as datasolicitacao, idusuario, CASE WHEN deferido = 'sim' THEN 'Deferido' WHEN deferido = 'can' THEN 'Cancelado' WHEN deferido = 'não' THEN 'Indeferido' WHEN deferido = 'agu' THEN 'Aguardando' end AS deferido, motivo FROM solicitacao WHERE idusuario = :idusuario ORDER BY datasolicitacao desc LIMIT 0, $limit";
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