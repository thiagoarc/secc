<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{
		if( $params->iditens_contrato != '0' ){
			$stmt = $oConexao->prepare("UPDATE itens_contrato SET  idcontrato = :idcontrato, idunidade_medida = :idunidade_medida, descricao = :descricao, qtd = :qtd, valorunitario = :valorunitario, idfornecedor = :idfornecedor WHERE iditens_contrato = :iditens_contrato");  
			$stmt->bindParam('idcontrato', $params->idcontrato);
			$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
			$stmt->bindParam('descricao', $params->descricao);
			$stmt->bindParam('qtd', $params->qtd);
			$stmt->bindParam('valorunitario', $params->valorunitario);
			$stmt->bindParam('idfornecedor', $params->idfornecedor);
			$stmt->bindParam('iditens_contrato', $params->iditens_contrato);
			$stmt->execute();
			$oConexao = null;

			$msg['msg']         = 'success';
    		$msg['msg_success'] = 'Item alterado com sucesso.';
    		echo json_encode($msg);
		}else{
			$stmt = $oConexao->prepare("INSERT INTO itens_contrato (idcontrato, idunidade_medida, descricao, qtd, valorunitario, idfornecedor) VALUES (:idcontrato, :idunidade_medida, :descricao, :qtd, :valorunitario, :idfornecedor)");  
			$stmt->bindParam('idcontrato', $params->idcontrato);
			$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
			$stmt->bindParam('descricao', $params->descricao);
			$stmt->bindParam('qtd', $params->qtd);
			$stmt->bindParam('valorunitario', $params->valorunitario);
			$stmt->bindParam('idfornecedor', $params->idfornecedor);
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