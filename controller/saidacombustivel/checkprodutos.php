<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->nome != '' ){

		$keysearch = "%{$params->nome}%";

		$stmt = $oConexao->prepare("SELECT p.*, f.idfornecedor, f.razaosocial as fornecedor, un.idunidade_medida, un.sigla FROM produto p, fornecedor f, unidade_medida un WHERE p.idfornecedor = f.idfornecedor AND p.idunidade_medida = un.idunidade_medida AND p.descricao LIKE :nome  LIMIT 0,10");  
		$stmt->bindParam('nome', $keysearch, PDO::PARAM_STR);
		$stmt->execute();
		$produto = $stmt->fetchAll(PDO::FETCH_OBJ);

		if( $produto ){
			echo json_encode($produto);
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