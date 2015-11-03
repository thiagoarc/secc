<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT ec.idempenho_contrato, ec.idcontrato, ec.idfornecedor, f.razaosocial, ec.valor, ec.numero, f.cnpj FROM empenho_contrato ec, contrato c, fornecedor f WHERE  f.idfornecedor = ec.idfornecedor AND ec.idcontrato = c.idcontrato AND c.idcontrato = :id";
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