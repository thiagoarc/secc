<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT ic.iditens_contrato, ic.idcontrato, ic.descricao, ic.qtd, ic.valorunitario, um.sigla, um.idunidade_medida, f.razaosocial, f.idfornecedor FROM itens_contrato ic, unidade_medida um, fornecedor f WHERE  f.idfornecedor = ic.idfornecedor AND um.idunidade_medida = ic.idunidade_medida AND ic.idcontrato = :id");  
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