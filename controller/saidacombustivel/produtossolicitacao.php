<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

//$limit = $params->limit != '' ?  $params->limit : 10;
try{

	$sql = "SELECT s.saida_idsaida, p.idproduto, p.descricao as produto, s.qtd, v.placa, v.modelo, v.motorista FROM produto p, saida_produto s, saida sa, veiculo v WHERE s.saida_idsaida = sa.idsaida AND sa.idveiculo = v.idveiculo AND p.idproduto = s.produto_idproduto AND sa.tipo = 3 AND s.saida_idsaida = :idsaida ORDER BY p.descricao asc";
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