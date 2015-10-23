<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{

	if( $params->idcontrato != '' ){

		$stmt = $oConexao->prepare("UPDATE contrato SET idorgao = :idorgao, tipo = :tipo, tipoobjetos = :tipoobjetos, numerotali = :numerotali, 
			dataassinaturatali = :dataassinaturatali, numeroata = :numeroata, validadeata = :validadeata, numeropregao = :numeropregao, numeroprocesso = :numeroprocesso, 
			numerocd = :numerocd, numeroparecerjuridico = :numeroparecerjuridico, datacompra = :datacompra, numerocontrato = :numerocontrato, objeto = :objeto,
			valor = :valor, validade = :validade, dataassinatura = :dataassinatura, numeroempenho = :numeroempenho WHERE idcontrato = :idcontrato");  
		$stmt->bindParam('idorgao', $params->idorgao);
		$stmt->bindParam('tipo', $params->tipo);
		$stmt->bindParam('tipoobjetos', $params->tipoobjetos);
		$stmt->bindParam('numerotali', $params->numerotali);

		$data1 = substr($params->dataassinaturatali, 4, 4)."-".substr($params->dataassinaturatali, 2, 2)."-".substr($params->dataassinaturatali, 0, 2);//implode("-",array_reverse(explode("/",$params->dataassinaturatali)));//date('Y-m-d', strtotime());
		$stmt->bindParam('dataassinaturatali', $data1);
		//$stmt->bindParam('dataassinaturatali', $params->dataassinaturatali);

		$stmt->bindParam('numeroata', $params->numeroata);

		$data2 = substr($params->validadeata, 4, 4)."-".substr($params->validadeata, 2, 2)."-".substr($params->validadeata, 0, 2);//implode("-",array_reverse(explode("/",$params->validadeata)));
		$stmt->bindParam('validadeata', $data2);
		//$stmt->bindParam('validadeata', $params->validadeata);

		$stmt->bindParam('numeropregao', $params->numeropregao);
		$stmt->bindParam('numeroprocesso', $params->numeroprocesso);
		$stmt->bindParam('numerocd', $params->numerocd);
		$stmt->bindParam('numeroparecerjuridico', $params->numeroparecerjuridico);

		$data3 = substr($params->datacompra, 4, 4)."-".substr($params->datacompra, 2, 2)."-".substr($params->datacompra, 0, 2);//implode("-",array_reverse(explode("/",$params->datacompra)));
		$stmt->bindParam('datacompra', $data3);
		//$stmt->bindParam('datacompra', $params->datacompra);

		$stmt->bindParam('numerocontrato', $params->numerocontrato);
		$stmt->bindParam('objeto', $params->objeto);
		$stmt->bindParam('valor', $params->valor);

		$data4 = substr($params->validade, 4, 4)."-".substr($params->validade, 2, 2)."-".substr($params->validade, 0, 2);//implode("-",array_reverse(explode("/",$params->validade)));
		$stmt->bindParam('validade', $data4);
		//$stmt->bindParam('validade', $params->validade);

		$data5 = substr($params->dataassinatura, 4, 4)."-".substr($params->dataassinatura, 2, 2)."-".substr($params->dataassinatura, 0, 2);//implode("-",array_reverse(explode("/",$params->dataassinatura)));
		$stmt->bindParam('dataassinatura', $data5);
		//$stmt->bindParam('dataassinatura', $params->dataassinatura);

		$stmt->bindParam('numeroempenho', $params->numeroempenho);
		$stmt->bindParam('idcontrato', $params->idcontrato);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{

		$stmt = $oConexao->prepare("INSERT INTO contrato (idorgao, tipo, tipoobjetos, numerotali, dataassinaturatali, numeroata, validadeata, numeropregao, 
			numeroprocesso, numerocd, numeroparecerjuridico, datacompra, numerocontrato, objeto, valor, validade, dataassinatura, numeroempenho) VALUES 
		(:idorgao, :tipo, :tipoobjetos, :numerotali, :dataassinaturatali, :numeroata, :validadeata, :numeropregao, 
			:numeroprocesso, :numerocd, :numeroparecerjuridico, :datacompra, :numerocontrato, :objeto, :valor, :validade, :dataassinatura, :numeroempenho)");  
		$stmt->bindParam('idorgao', $params->idorgao);
		$stmt->bindParam('tipo', $params->tipo);
		$stmt->bindParam('tipoobjetos', $params->tipoobjetos);
		$stmt->bindParam('numerotali', $params->numerotali);

		$data1 = substr($params->dataassinaturatali, 4, 4)."-".substr($params->dataassinaturatali, 2, 2)."-".substr($params->dataassinaturatali, 0, 2);//implode("-",array_reverse(explode("/",$params->dataassinaturatali)));//date('Y-m-d', strtotime());
		$stmt->bindParam('dataassinaturatali', $data1);
		//$stmt->bindParam('dataassinaturatali', $params->dataassinaturatali);

		$stmt->bindParam('numeroata', $params->numeroata);

		$data2 = substr($params->validadeata, 4, 4)."-".substr($params->validadeata, 2, 2)."-".substr($params->validadeata, 0, 2);//implode("-",array_reverse(explode("/",$params->validadeata)));
		$stmt->bindParam('validadeata', $data2);
		//$stmt->bindParam('validadeata', $params->validadeata);

		$stmt->bindParam('numeropregao', $params->numeropregao);
		$stmt->bindParam('numeroprocesso', $params->numeroprocesso);
		$stmt->bindParam('numerocd', $params->numerocd);
		$stmt->bindParam('numeroparecerjuridico', $params->numeroparecerjuridico);

		$data3 = substr($params->datacompra, 4, 4)."-".substr($params->datacompra, 2, 2)."-".substr($params->datacompra, 0, 2);//implode("-",array_reverse(explode("/",$params->datacompra)));
		$stmt->bindParam('datacompra', $data3);
		//$stmt->bindParam('datacompra', $params->datacompra);

		$stmt->bindParam('numerocontrato', $params->numerocontrato);
		$stmt->bindParam('objeto', $params->objeto);
		$stmt->bindParam('valor', $params->valor);

		$data4 = substr($params->validade, 4, 4)."-".substr($params->validade, 2, 2)."-".substr($params->validade, 0, 2);//implode("-",array_reverse(explode("/",$params->validade)));
		$stmt->bindParam('validade', $data4);
		//$stmt->bindParam('validade', $params->validade);

		$data5 = substr($params->dataassinatura, 4, 4)."-".substr($params->dataassinatura, 2, 2)."-".substr($params->dataassinatura, 0, 2);//implode("-",array_reverse(explode("/",$params->dataassinatura)));
		$stmt->bindParam('dataassinatura', $data5);
		//$stmt->bindParam('dataassinatura', $params->dataassinatura);

		$stmt->bindParam('numeroempenho', $params->numeroempenho);
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