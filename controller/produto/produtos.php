<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT p.idproduto, p.nome, p.descricao, p.marca, un.idunidade_medida, un.sigla, un.descricao as descricaoun   FROM produto p, unidade_medida un WHERE p.idunidade_medida = un.idunidade_medida ORDER BY p.nome asc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$produtos = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($produtos);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>