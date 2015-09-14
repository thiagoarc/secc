<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	//$oConexao->beginTransaction();

	$idcontrato = $params->idcontrato;
	$idaditivo = $params->idaditivo;

	//verifica se o contrato tem itens
	$stmt = $oConexao->prepare("SELECT * FROM itens_contrato WHERE idcontrato = :id");  
	$stmt->bindParam('id', $idcontrato);
	$rs = $stmt->execute();
	$qtd = $stmt->rowCount();

	if($qtd > 0){

		//verifica se o aditivo ja tem itens, se ja nao insere
		$rsA = $oConexao->prepare("SELECT * FROM itens_aditivo WHERE idaditivo = :id");  
		$rsA->bindParam('id', $idaditivo);
		$rsA->execute();
		$qtdA = $rsA->rowCount();

		if($qtdA == 0){

			while($row = $stmt->fetch(PDO::FETCH_OBJ)){
				$rs = $oConexao->prepare("INSERT INTO itens_aditivo (idaditivo, idunidade_medida, descricao, qtd, valorunitario, idfornecedor) VALUES (:idaditivo, :idunidade_medida, :descricao, :qtd, :valorunitario, :idfornecedor)");  
				$rs->bindParam('idaditivo', $idaditivo);
				$rs->bindParam('idunidade_medida', $row->idunidade_medida);
				$rs->bindParam('descricao', $row->descricao);
				$rs->bindParam('qtd', $row->qtd);
				$rs->bindParam('valorunitario', $row->valorunitario);
				$rs->bindParam('idfornecedor', $row->idfornecedor);
				$rs->execute();
			}
			//$oConexao->commit();
			$msg['msg']         = 'success';
			$msg['msg_success'] = "Itens clonados com sucesso";
    		echo json_encode($msg);
    	}else{
    		//$oConexao->commit();
			$msg['msg']         = 'success';
			$msg['msg_success'] = "";
    		echo json_encode($msg);
    	}
	}else{
		$msg['msg']         = 'warning';
    	echo json_encode($msg);
	}
	

}catch (PDOException $e){
	$oConexao->rollBack();
	$msg['msg']         = 'error';
    $msg['msg_success'] = $e->getMessage();
    echo json_encode($msg);
    die();
}

?>