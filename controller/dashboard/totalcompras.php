<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	$stmt = $oConexao->prepare("SELECT sum(valorunitario) as total FROM itens_ordem_servico");  
	$stmt->execute();
	$total = $stmt->fetchAll(PDO::FETCH_OBJ);

	if( $total && $stmt->rowCount() > 0 ){
		echo json_encode($total);
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