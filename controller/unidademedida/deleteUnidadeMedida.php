<?php 
	
$oConexao = Conexao::getInstance();

$id = $_GET['id'];

try{

	if( $id > 0){

		$stmt = $oConexao->prepare("SELECT * FROM produto WHERE idunidade_medida = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		if($stmt->rowCount() == 0){

			$stmt = $oConexao->prepare("DELETE FROM unidade_medida WHERE idunidade_medida = :id");  
			$stmt->bindParam('id', $id);
			$stmt->execute();
			$oConexao = null;
			$msg['msg']         = 'success';
    		$msg['msg_success'] = 'Exclusão realizada com sucesso.';
    		echo json_encode($msg);
    		die();
    	}else{
    		$msg['msg']         = 'error';
    		$msg['msg_success'] = 'Não foi possível excluir, pois existe um produto cadastrado com essa unidade de medida.';
    		echo json_encode($msg);
			die();
    	}
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	$msg['msg']         = 'error';
    $msg['msg_success'] = $e->getMessage()."<br>Por favor entre em contato com o adimistrador do sistema e informe o erro.";
    echo json_encode($msg);
	die();
}

?>