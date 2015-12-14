<?php 	
$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT *, CASE WHEN v.tipocombustivel = 1 THEN 'Gasolina' WHEN v.tipocombustivel = 2 THEN 'Álcool'  WHEN v.tipocombustivel = 3 THEN 'Diesel' WHEN v.tipocombustivel = 4 THEN 'Diesel S10' end AS combustivel FROM veiculo v, setor s WHERE v.idsetor = s.idsetor AND v.idveiculo = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$veiculo = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($veiculo);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>