<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));


try{

	if( $params->idunidade_medida != '' ){

		$stmt = $oConexao->prepare("UPDATE unidade_medida SET sigla = :sigla, descricao = :descricao WHERE idunidade_medida = :id");  
		$stmt->bindParam('sigla', $params->sigla);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->bindParam('id', $params->idunidade_medida);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO unidade_medida (sigla, descricao) VALUES(:sigla, :descricao)");  
		$stmt->bindParam('sigla', $params->sigla);
		$stmt->bindParam('descricao', $params->descricao);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro realizado com sucesso.';
    	echo json_encode($msg);
	
	}
	//MENSAGEM DE SUCESSO
    // $msg['msg']         = 'success';
    // $msg['msg_success'] = 'Cadastro efetuado com sucesso.';
    // echo json_encode($msg);
	// echo json_encode($);
}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>