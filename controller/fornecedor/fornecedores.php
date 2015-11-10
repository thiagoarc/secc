<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT f.*, c.idcidade, c.nome as cidade, u.iduf, u.uf FROM fornecedor f, cidade c, uf u WHERE f.idcidade = c.idcidade AND u.iduf = c.iduf ORDER BY razaosocial asc LIMIT 0, $limit";
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