<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idproduto != '' ){

		$stmt = $oConexao->prepare("UPDATE produto SET qtdminima = :qtdminima, qtdatual = :qtdatual WHERE idproduto = :idproduto");  
		$stmt->bindParam('qtdminima', $params->qtdminima);
		$stmt->bindParam('qtdatual', $params->qtdatual);
		$stmt->bindParam('idproduto', $params->idproduto);
		$stmt->execute();
		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Estoque atualizado com sucesso.';
    	echo json_encode($msg);

	}

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar atualizar o estoque.';
    echo json_encode($msg);
	die();
}

?>