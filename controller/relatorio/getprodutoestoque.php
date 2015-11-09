<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	$stmt = $oConexao->prepare("SELECT p.descricao, p.qtdminima, p.qtdatual, p.valorunitario, und.sigla, und.idunidade_medida, f.idfornecedor, f.razaosocial
								FROM produto p
									INNER JOIN unidade_medida und ON(p.idunidade_medida = und.idunidade_medida)
									INNER JOIN fornecedor f ON(p.idfornecedor = f.idfornecedor)
								ORDER by p.descricao");  
	$stmt->execute();
	$produtos = $stmt->fetchAll(PDO::FETCH_OBJ);

	if( $produtos && $stmt->rowCount() > 0 ){
		echo json_encode($produtos);
	}else{
		echo '{ "message": "noresults" }';
	}

	$oConexao = null;

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>