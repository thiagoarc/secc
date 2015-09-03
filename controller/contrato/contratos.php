<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT idcontrato, CASE WHEN tipo = 1 THEN 'Termo de Adesão' WHEN tipo = 2 THEN 'Licitação' WHEN tipo = 3 THEN 'Compra Direta' end AS tipo, numerocontrato, valor, DATE_FORMAT(validade, '%d/%m/%Y') as validade FROM contrato ORDER BY idcontrato desc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$fornecedores = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($fornecedores);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'.$e->getMessage().'}}'; 
	die();
}

?>