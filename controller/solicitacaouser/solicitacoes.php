<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = $_SESSION['ang_secc_uid'];

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT idsolicitacao, DATE_FORMAT(datasolicitacao, '%d/%m/%Y') as datasolicitacao, idusuario, CASE WHEN status = 1 THEN 'Finalizado' WHEN status = 2 THEN 'Cancelado' WHEN status = 0 THEN 'Aguardando' end AS status, motivo FROM solicitacao WHERE idusuario = :idusuario ORDER BY datasolicitacao desc LIMIT 0, $limit";
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