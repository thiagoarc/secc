<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idveiculo != '' ){

		$stmt = $oConexao->prepare("UPDATE veiculo SET placa = :placa, tipo = :tipo, modelo = :modelo, ano = :ano, cor = :cor, tipocombustivel = :tipocombustivel, kminicial = :kminicial, motorista = :motorista, idsetor = :idsetor WHERE idveiculo = :id");  
		$stmt->bindParam('placa', $params->placa);
		$stmt->bindParam('tipo', $params->tipo);
		$stmt->bindParam('modelo', $params->modelo);
		$stmt->bindParam('ano', $params->ano);
		$stmt->bindParam('cor', $params->cor);
		$stmt->bindParam('tipocombustivel', $params->tipocombustivel);
		$stmt->bindParam('kminicial', $params->kminicial);
		$stmt->bindParam('motorista', $params->motorista);
		$stmt->bindParam('idsetor', $params->idsetor);
		$stmt->bindParam('id', $params->idveiculo);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO veiculo (placa, tipo, modelo, ano, cor, tipocombustivel, kminicial, motorista, idsetor) VALUES(:placa, :tipo, :modelo, :ano, :cor, :tipocombustivel, :kminicial, :motorista, :idsetor)");  
		$stmt->bindParam('placa', $params->placa);
		$stmt->bindParam('tipo', $params->tipo);
		$stmt->bindParam('modelo', $params->modelo);
		$stmt->bindParam('ano', $params->ano);
		$stmt->bindParam('cor', $params->cor);
		$stmt->bindParam('tipocombustivel', $params->tipocombustivel);
		$stmt->bindParam('kminicial', $params->kminicial);
		$stmt->bindParam('motorista', $params->motorista);
		$stmt->bindParam('idsetor', $params->idsetor);
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