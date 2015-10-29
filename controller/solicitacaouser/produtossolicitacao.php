<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

//$limit = $params->limit != '' ?  $params->limit : 10;
try{

	$sql = "SELECT sp.idsolicitacao_produto, p.idproduto, p.descricao as produto, sp.idsolicitacao, sp.qtd, CASE WHEN sp.status = 1 THEN 'Deferido' WHEN sp.status = 2 THEN 'Indeferido'  WHEN sp.status = 0 THEN 'Aguardando' end AS status, sp.motivo FROM produto p, solicitacao_produto sp WHERE p.idproduto = sp.idproduto AND sp.idsolicitacao = :idsolicitacao ORDER BY p.descricao asc";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idsolicitacao', $params->idsolicitacao);
	$stmt->execute(); 
	$produtos = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($produtos);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>