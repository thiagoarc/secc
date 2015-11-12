<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->numero != '' ){

		$stmt = $oConexao->prepare("SELECT ic.iditens_contrato as iditem, ic.idcontrato as contrato, ic.descricao, ic.qtd, (ic.qtd - ic.qtdordem) as qtdos, 
										   ic.valorunitario, und.sigla, und.idunidade_medida, fnc.idfornecedor, fnc.razaosocial 
										FROM itens_contrato ic
											INNER JOIN unidade_medida und ON(ic.idunidade_medida = und.idunidade_medida)
											INNER JOIN fornecedor fnc ON(ic.idfornecedor = fnc.idfornecedor)
											LEFT JOIN contrato c ON(ic.idcontrato = c.idcontrato)
											WHERE c.numerocontrato = :numero ORDER by ic.descricao");  
		$stmt->bindParam('numero', $params->numero, PDO::PARAM_STR);
		$stmt->execute();
		$contrato = $stmt->fetchAll(PDO::FETCH_OBJ);

		if( $contrato && $stmt->rowCount() > 0 ){
			echo json_encode($contrato);
		}else{

			$stmt = $oConexao->prepare("SELECT iad.iditens_aditivo as iditem, iad.idaditivo as contrato, iad.descricao, iad.qtd, (iad.qtd - iad.qtdordem) as qtdos, 
											   iad.valorunitario, und.sigla, und.idunidade_medida, fnc.idfornecedor, fnc.razaosocial 
											FROM itens_aditivo iad
												INNER JOIN unidade_medida und ON(iad.idunidade_medida = und.idunidade_medida)
												INNER JOIN fornecedor fnc ON(iad.idfornecedor = fnc.idfornecedor)
												LEFT JOIN aditivo a ON(iad.idaditivo = a.idaditivo)
												WHERE a.numero = 889988 ORDER by iad.descricao");
			$stmt->bindParam('numero', $params->numero, PDO::PARAM_STR);
			$stmt->execute();
			$aditivo = $stmt->fetchAll(PDO::FETCH_OBJ);

			if( $aditivo && $stmt->rowCount() > 0 ){
				echo json_encode($aditivo);
			}else if( $stmt->rowCount() == 0 ){
				echo '{ "message": "noresults" }';
			}else{
				echo '{ "message": "noresults" }';
			}

		}

	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>