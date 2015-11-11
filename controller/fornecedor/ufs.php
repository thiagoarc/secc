<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT * FROM uf ORDER BY uf asc";
	$stmt = $oConexao->query($sql);  
	$cidades = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($cidades);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>