<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

	if( $params->idproduto != '' ){

		$stmt = $oConexao->prepare("UPDATE fornecedor SET razaosocial = :razaosocial, cnpj = :cnpj, cep = :cep, logradouro = :logradouro, numero = :numero, complemento = :complemento, bairro = :bairro, telefone = :telefone, celular = :celular, email = :email, responsavel = :responsavel, idcidade = :idcidade WHERE idfornecedor = :idfornecedor");  
		$stmt->bindParam('razaosocial', $params->razaosocial);
		$stmt->bindParam('cnpj', $params->cnpj);
		$stmt->bindParam('cep', $params->cep);
		$stmt->bindParam('logradouro', $params->logradouro);
		$stmt->bindParam('numero', $params->numero);
		$stmt->bindParam('complemento', $params->complemento);
		$stmt->bindParam('bairro', $params->bairro);
		$stmt->bindParam('telefone', $params->telefone);
		$stmt->bindParam('celular', $params->celular);
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('responsavel', $params->responsavel);
		$stmt->bindParam('idcidade', $params->idcidade);
		$stmt->bindParam('idfornecedor', $params->idfornecedor);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO produto (razaosocial, cnpj, cep, logradouro, numero, complemento, bairro, telefone, celular, email, responsavel, idcidade) VALUES(:razaosocial, :cnpj, :cep, :logradouro, :numero, :complemento, :bairro, :telefone, :celular, :email, :responsavel, :idcidade)");  
		$stmt->bindParam('razaosocial', $params->razaosocial);
		$stmt->bindParam('cnpj', $params->cnpj);
		$stmt->bindParam('cep', $params->cep);
		$stmt->bindParam('logradouro', $params->logradouro);
		$stmt->bindParam('numero', $params->numero);
		$stmt->bindParam('complemento', $params->complemento);
		$stmt->bindParam('bairro', $params->bairro);
		$stmt->bindParam('telefone', $params->telefone);
		$stmt->bindParam('celular', $params->celular);
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('responsavel', $params->responsavel);
		$stmt->bindParam('idcidade', $params->idcidade);
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