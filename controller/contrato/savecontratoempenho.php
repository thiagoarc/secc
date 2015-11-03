<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{
		if( $params->idempenho_contrato != '0' ){
			$stmt = $oConexao->prepare("UPDATE empenho_contrato SET  idcontrato = :idcontrato, idfornecedor = :idfornecedor, numero = :numero, valor = :valor WHERE idempenho_contrato = :idempenho_contrato");  
			$stmt->bindParam('idcontrato', $params->idcontrato);
			$stmt->bindParam('idfornecedor', $params->idfornecedor);
			$stmt->bindParam('numero', $params->numero);
			$stmt->bindParam('valor', $params->valor);
			$stmt->bindParam('idempenho_contrato', $params->idempenho_contrato);
			$stmt->execute();
			$oConexao = null;

			$msg['msg']         = 'success';
    		$msg['msg_success'] = 'Empenho alterado com sucesso.';
    		echo json_encode($msg);
		}else{
			$stmt = $oConexao->prepare("INSERT INTO empenho_contrato (idcontrato, idfornecedor, numero, valor) VALUES (:idcontrato, :idfornecedor, :numero, :valor)");  
			$stmt->bindParam('idcontrato', $params->idcontrato);
			$stmt->bindParam('idfornecedor', $params->idfornecedor);
			$stmt->bindParam('numero', $params->numero);
			$stmt->bindParam('valor', $params->valor);
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