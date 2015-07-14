<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

	if( $params->id != '' ){

		$stmt = $oConexao->prepare("UPDATE produto SET nome = :nome, descricao = :descricao, preco = :preco, quantidade = :quantidade WHERE id = :id");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->bindParam('preco', $params->preco);
		$stmt->bindParam('quantidade', $params->quantidade);
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro salvo com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO produto (nome, descricao, preco, quantidade, idcategoria) VALUES(:nome, :descricao, :preco, :quantidade, 1)");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->bindParam('preco', $params->preco);
		$stmt->bindParam('quantidade', $params->quantidade);
		$stmt->execute();

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro salvo com sucesso.';
    	echo json_encode($msg);
	
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>