<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

sleep(1);

try{	
		$stmt = $oConexao->prepare("SELECT * FROM fornecedor_contrato WHERE idcontrato = :idcontrato AND idfornecedor = :idfornecedor");  
		$stmt->bindParam('idcontrato', $params->idcontrato);
		$stmt->bindParam('idfornecedor', $params->idfornecedor);
		$stmt->execute();

		if($stmt->rowCount() > 0){
			$msg['msg']         = 'error';
    		$msg['msg_success'] = 'Este fornecesor já está vinculado.';
    		echo json_encode($msg);			
		}else{

			$stmt = $oConexao->prepare("INSERT INTO fornecedor_contrato (idcontrato, idfornecedor) VALUES (:idcontrato, :idfornecedor)");  
			$stmt->bindParam('idcontrato', $params->idcontrato);
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