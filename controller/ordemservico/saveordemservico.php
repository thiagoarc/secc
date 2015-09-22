<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->numero != '' ){

		$stmt = $oConexao->prepare("SELECT ic.idcontrato as contrato, ic.descricao, ic.qtd, ic.valorunitario, und.sigla, fnc.razaosocial 
									FROM itens_contrato ic
										INNER JOIN unidade_medida und ON(ic.idunidade_medida = und.idunidade_medida)
										INNER JOIN fornecedor fnc ON(ic.idfornecedor = fnc.idfornecedor)
									WHERE ic.idcontrato = :numero ORDER by ic.descricao");  
		$stmt->bindParam('numero', $params->numero, PDO::PARAM_STR);
		$stmt->execute();
		$contrato = $stmt->fetchAll(PDO::FETCH_OBJ);

		if( $contrato ){
			echo json_encode($contrato);
		}else{

			$stmt = $oConexao->prepare("SELECT iad.idaditivo as contrato, iad.descricao, iad.qtd, iad.valorunitario, und.sigla, fnc.razaosocial 
										FROM itens_aditivo iad
											INNER JOIN unidade_medida und ON(iad.idunidade_medida = und.idunidade_medida)
											INNER JOIN fornecedor fnc ON(iad.idfornecedor = fnc.idfornecedor)
										WHERE iad.idaditivo = :numero ORDER by iad.descricao");
			$stmt->bindParam('numero', $params->numero, PDO::PARAM_STR);
			$stmt->execute();
			$aditivo = $stmt->fetchAll(PDO::FETCH_OBJ);

			if( $aditivo ){
				echo json_encode($aditivo);
			}else{
				
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