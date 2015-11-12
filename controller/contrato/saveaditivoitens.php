<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{
		if( $params->iditens_aditivo != '' ){
			$stmt = $oConexao->prepare("UPDATE itens_aditivo SET  idaditivo = :idaditivo, idunidade_medida = :idunidade_medida, descricao = :descricao, qtd = :qtd, qtdordem = :qtdordem, valorunitario = :valorunitario, idfornecedor = :idfornecedor WHERE iditens_aditivo = :iditens_aditivo");  
			$stmt->bindParam('idaditivo', $params->idaditivo);
			$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
			$stmt->bindParam('descricao', $params->descricao);
			$stmt->bindParam('qtd', $params->qtd);
			$stmt->bindParam('qtdordem', $params->qtd);
			$stmt->bindParam('valorunitario', $params->valorunitario);
			$stmt->bindParam('idfornecedor', $params->idfornecedor);
			$stmt->bindParam('iditens_aditivo', $params->iditens_aditivo);
			$stmt->execute();
			$oConexao = null;

			$msg['msg']         = 'success';
    		$msg['msg_success'] = 'Item alterado com sucesso.';
    		echo json_encode($msg);
		}else{
			$stmt = $oConexao->prepare("INSERT INTO itens_aditivo (idaditivo, idunidade_medida, descricao, qtd, qtdordem, valorunitario, idfornecedor) VALUES (:idaditivo, :idunidade_medida, :descricao, :qtd, :qtdordem, :valorunitario, :idfornecedor)");  
			$stmt->bindParam('idaditivo', $params->idaditivo);
			$stmt->bindParam('idunidade_medida', $params->idunidade_medida);
			$stmt->bindParam('descricao', $params->descricao);
			$stmt->bindParam('qtd', $params->qtd);
			$stmt->bindParam('qtdordem', 0);
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