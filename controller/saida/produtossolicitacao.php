<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

//$limit = $params->limit != '' ?  $params->limit : 10;
try{

	$sql = "SELECT s.saida_idsaida, p.idproduto, p.descricao as produto, s.qtd FROM produto p, saida_produto s WHERE p.idproduto = s.produto_idproduto AND s.saida_idsaida = :idsaida ORDER BY p.descricao asc";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idsaida', $params->idsaida);
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