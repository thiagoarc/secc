<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = 1;
/*
try{
	$oConexao->beginTransaction(); 
	//$sql = "SELECT s.idsolicitacao, DATE_FORMAT(s.datasolicitacao, '%d/%m/%Y') as datasolicitacao, u.idusuario, u.nome, se.idsetor, se.sigla FROM solicitacao s, usuario u, setor se WHERE s.idusuario = u.idusuario AND u.idsetor = se.idsetor AND s.idusuario = :idusuario ORDER BY s.datasolicitacao desc LIMIT 0, $limit";
	$sql = "SELECT * FROM solicitacao_produto WHERE idsolicitacao = :idsolicitacao";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idsolicitacao', $params->idsolicitacao);
	$stmt->execute();
	$total = $stmt->rowCount();
	
	if($total > 0){
		while($row = $stmt->fetch(PDO::FETCH_OBJ)){

			//pega a qtd do produto em estoque para poder realizar a subtracao
			$sql = "SELECT * FROM produto WHERE idproduto = :idproduto";
			$stmt1 = $oConexao->prepare($sql);  
			$stmt1->bindParam('idproduto', $row->idproduto);
			$stmt1->execute();
			$row2 = $stmt1->fetchAll(PDO::FETCH_OBJ);

			//echo "QTD ATUAL: "+$row2->qtdatual;
			//echo "QTD SOL: "+$row->qtd;
			//faz a subtracao
			//$novoTotal = (int) $row2->qtdatual - (int) $row->qtd;

			//faz o update com a nova qtd qtdordem = (qtd - ?)
			$sql = "UPDATE produto SET qtdatual = (qtdatual - :qtd) WHERE idproduto = :idproduto";
			$stmt2 = $oConexao->prepare($sql);  
			$stmt2->bindParam('qtd', $row->qtd);
			$stmt2->bindParam('idproduto', $row->idproduto);
			$stmt2->execute();
		}
	}

	//faz o update com a nova qtd
	$sql = "UPDATE solicitacao SET deferido = 'sim' WHERE idsolicitacao = :idsolicitacao";
	$stmt3 = $oConexao->prepare($sql);  
	$stmt3->bindParam('idsolicitacao', $params->idsolicitacao);
	$stmt3->execute();

	$oConexao->commit();

	$oConexao = null;

	$msg['msg']         = 'success';
    $msg['msg_success'] = 'Solicitação deferida com sucesso.';
    echo json_encode($msg);

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar deferir a solicitação.';
    echo json_encode($msg);
}*/

try{
	$oConexao->beginTransaction(); 
	//$sql = "SELECT s.idsolicitacao, DATE_FORMAT(s.datasolicitacao, '%d/%m/%Y') as datasolicitacao, u.idusuario, u.nome, se.idsetor, se.sigla FROM solicitacao s, usuario u, setor se WHERE s.idusuario = u.idusuario AND u.idsetor = se.idsetor AND s.idusuario = :idusuario ORDER BY s.datasolicitacao desc LIMIT 0, $limit";
	/*$sql = "SELECT * FROM solicitacao_produto WHERE idsolicitacao = :idsolicitacao AND idproduto = :idproduto";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idsolicitacao', $params->idsolicitacao);
	$stmt->bindParam('idproduto', $params->idproduto);
	$stmt->execute();
	$row = $stmt->fetchAll(PDO::FETCH_OBJ);*/

	$sql = "SELECT * FROM produto WHERE idproduto = :idproduto";
	$stmt1 = $oConexao->prepare($sql);  
	$stmt1->bindParam('idproduto', $params->idproduto);
	$stmt1->execute();
	$row1 = $stmt1->fetch(PDO::FETCH_OBJ);

	if(intval($params->qtd) <= intval($row1->qtdatual)){

		$sql = "UPDATE produto SET qtdatual = (qtdatual - :qtd) WHERE idproduto = :idproduto";
		$stmt2 = $oConexao->prepare($sql);  
		$stmt2->bindParam('qtd', $params->qtd);
		$stmt2->bindParam('idproduto', $params->idproduto);
		$stmt2->execute();

		//faz o update com a nova qtd
		$sql = "UPDATE solicitacao_produto SET status = 1 WHERE idsolicitacao = :idsolicitacao AND idproduto = :idproduto";
		$stmt3 = $oConexao->prepare($sql);  
		$stmt3->bindParam('idsolicitacao', $params->idsolicitacao);
		$stmt3->bindParam('idproduto', $params->idproduto);
		$stmt3->execute();

		$oConexao->commit();

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Solicitação do produto foi deferida com sucesso.';
    	echo json_encode($msg);

	}else{

		$oConexao->rollBack();
		$msg['msg']         = 'error1';
    	$msg['msg_success'] = 'A quantidade solicitada é maior que o estoque atual.';
	    echo json_encode($msg);

	}

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_success'] = 'Ocorreu um erro ao tentar deferir a solicitação.';
    echo json_encode($msg);
}
?>