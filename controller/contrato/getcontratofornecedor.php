<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT f.razaosocial, f.cnpj, f.idfornecedor, fc.idcontrato, fc.idfornecedor_contrato FROM fornecedor f, fornecedor_contrato fc, contrato c WHERE c.idcontrato = fc.idcontrato AND f.idfornecedor = fc.idfornecedor AND fc.idcontrato = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$fornecedores = $stmt->fetchAll(PDO::FETCH_OBJ);
		$oConexao = null;
		echo json_encode($fornecedores);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>