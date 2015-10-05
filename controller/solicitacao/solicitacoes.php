<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT s.idsolicitacao, DATE_FORMAT(s.datasolicitacao, '%d/%m/%Y') as datasolicitacao, s.motivo, u.idusuario, u.nome, se.idsetor, se.sigla, CASE WHEN s.status = 1 THEN 'Finalizado' WHEN s.status = 2 THEN 'Cancelado'  WHEN s.status = 0 THEN 'Aguardando' end AS status FROM solicitacao s, usuario u, setor se WHERE s.idusuario = u.idusuario AND u.idsetor = se.idsetor AND s.idusuario = :idusuario ORDER BY s.status, s.datasolicitacao desc LIMIT 0, $limit";
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