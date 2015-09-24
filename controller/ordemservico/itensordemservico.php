<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idos != '' ){

		$stmt = $oConexao->prepare("SELECT osi.iditens_ordem_servico as iditem, osi.idordem_servico as idos, osi.descricao, osi.qtd, osi.valorunitario, und.sigla, und.idunidade_medida 
									FROM itens_ordem_servico osi
										INNER JOIN unidade_medida und ON(osi.idunidade_medida = und.idunidade_medida)
									WHERE osi.idordem_servico = :ios ORDER by osi.descricao");  
		$stmt->bindParam('ios', $params->idos);
		$stmt->execute();
		$osItem = $stmt->fetchAll(PDO::FETCH_OBJ);

		if( $osItem && $stmt->rowCount() > 0 ){
			echo json_encode($osItem);
		}else{
			echo '{ "message": "noresults" }';
		}

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>