<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT ec.idempenho_aditivo, ec.idaditivo, ec.idfornecedor, f.razaosocial, ec.valor, ec.numero, f.cnpj FROM empenho_aditivo ec, aditivo c, fornecedor f WHERE  f.idfornecedor = ec.idfornecedor AND ec.idaditivo = c.idaditivo AND c.idaditivo = :id";
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