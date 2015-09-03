<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT fc.idfornecedor_contrato, fc.idcontrato, f.idfornecedor, f.razaosocial, f.cnpj FROM fornecedor_contrato fc, fornecedor f WHERE  f.idfornecedor = fc.idfornecedor AND fc.idcontrato = :id ORDER BY f.razaosocial asc";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('id', $params->id);
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