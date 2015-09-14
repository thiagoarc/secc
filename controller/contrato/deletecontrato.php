<?php 
	
include_once('../../conn/config.php');
$oConexao = Conexao::getInstance();

$id = $_GET['id'];
try{
	if( $id > 0){

		$stmt = $oConexao->prepare("SELECT * FROM fornecedor_contrato WHERE idcontrato = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		$qtdContratos = $stmt->rowCount();


		$stmt = $oConexao->prepare("SELECT * FROM itens_contrato WHERE idcontrato = :id");  
		$stmt->bindParam('id', $id);
		$stmt->execute();
		$qtdItens = $stmt->rowCount();

		if($qtdContratos == 0 && $qtdItens == 0){
			$stmt = $oConexao->prepare("DELETE FROM contrato WHERE idcontrato = :id");  
			$stmt->bindParam('id', $id);
			if($stmt->execute()){
				$oConexao = null;
				$msg['msg']         = 'success';
    			$msg['msg_success'] = 'Registro deletado com sucesso.';
    			echo json_encode($msg);
    		}else{
    			$oConexao = null;
				$msg['msg']         = 'error1';
    			$msg['msg_success'] = 'Ocorreu algum erro ao tentar excluir o registro.';
    			echo json_encode($msg);
    		}
    	}else{
    		$oConexao = null;
				$msg['msg']         = 'error2';
    			$msg['msg_success'] = 'Não foi possível excluir este contrato, pois existem itens(produtos, fornecedores ou aditivos) vinculados ao mesmo.';
    			echo json_encode($msg);
    	}
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = $e->getMessage();
    echo json_encode($msg);
    //echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>