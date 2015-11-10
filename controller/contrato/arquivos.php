<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{


	$sql = "SELECT * FROM arquivos_contrato WHERE idcontrato = :idcontrato ORDER BY idcontrato desc";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idcontrato', $params->id);
	$stmt->execute();
	$fornecedores = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($fornecedores);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'.$e->getMessage().'}}'; 
	die();
}

?>