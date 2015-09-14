<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

	if( $params->idaditivo != '' ){

		$stmt = $oConexao->prepare("UPDATE aditivo SET idcontrato = :idcontrato, numero = :numero, validade = :validade, valor = :valor, obs = :obs WHERE idaditivo = :idaditivo");  
		$stmt->bindParam('idcontrato', $params->idcontrato);
		$stmt->bindParam('numero', $params->numero);

		$data4 = substr($params->validade, 4, 4)."-".substr($params->validade, 2, 2)."-".substr($params->validade, 0, 2);//implode("-",array_reverse(explode("/",$params->validade)));
		$stmt->bindParam('validade', $data4);
		//$stmt->bindParam('validade', $params->validade);
		
		$stmt->bindParam('valor', $params->valor);
		$stmt->bindParam('obs', $params->obs);
		$stmt->bindParam('idaditivo', $params->idaditivo);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO aditivo (idcontrato, numero, validade, valor, obs) VALUES (:idcontrato, :numero, :validade, :valor, :obs)");  
		$stmt->bindParam('idcontrato', $params->idcontrato);
		$stmt->bindParam('numero', $params->numero);

		$data4 = substr($params->validade, 4, 4)."-".substr($params->validade, 2, 2)."-".substr($params->validade, 0, 2);//implode("-",array_reverse(explode("/",$params->validade)));
		$stmt->bindParam('validade', $data4);
		//$stmt->bindParam('validade', $params->validade);
		
		$stmt->bindParam('valor', $params->valor);
		$stmt->bindParam('obs', $params->obs);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro realizado com sucesso.';
    	echo json_encode($msg);
	
	}

}catch (PDOException $e){
	echo $e->errorInfo[0]."   ".$e->getMessage();
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar salvar.';
    echo json_encode($msg);
}

?>