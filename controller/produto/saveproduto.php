<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idproduto != '' ){

		$stmt = $oConexao->prepare("UPDATE produto SET nome = :nome, descricao = :descricao, marca = :marca, idunidade_medida = :idunidade_medida WHERE idproduto = :idproduto");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->bindParam('marca', $params->marca);
		$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
		$stmt->bindParam('idproduto', $params->idproduto);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO produto (nome, descricao, marca, idunidade_medida) VALUES(:nome, :descricao, :marca, :idunidade_medida)");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->bindParam('marca', $params->marca);
		$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
		$stmt->execute();

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro realizado com sucesso.';
    	echo json_encode($msg);
	
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>