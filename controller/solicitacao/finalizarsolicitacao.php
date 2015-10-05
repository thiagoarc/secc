<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;

try{
	$oConexao->beginTransaction(); 

		$status = false;

		//faz o update com a nova qtd
		$sql = "SELECT * FROM solicitacao_produto WHERE idsolicitacao = :idsolicitacao";
		$stmt3 = $oConexao->prepare($sql);  
		$stmt3->bindParam('idsolicitacao', $params->id);
		$stmt3->execute();
		while($row = $stmt3->fetch(PDO::FETCH_OBJ)){
			if($row->status == 0){
				$status = false;
				break; 
			}else{
				$status = true;
			}
		}

		if($status){

			//faz o update com a nova qtd
			$sql = "UPDATE solicitacao SET status = 1 WHERE idsolicitacao = :idsolicitacao";
			$stmt3 = $oConexao->prepare($sql);  
			$stmt3->bindParam('idsolicitacao', $params->id);
			$stmt3->execute();

			$oConexao->commit();

			$oConexao = null;

			$msg['msg']         = 'success';
	    	$msg['msg_success'] = 'Solicitação finalizada com sucesso.';
	    	echo json_encode($msg);
	    }else{
	    	$msg['msg']         = 'erro1';
	    	$msg['msg_success'] = 'Ainda não foram deferidos todos os produtos, por favor defira-os e depois finalize a solicitação.';
	    	echo json_encode($msg);
	    }


}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar finalizar a solicitação.';
    echo json_encode($msg);
}
?>