<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT *, CASE WHEN v.tipocombustivel = 1 THEN 'Gasolina' WHEN v.tipocombustivel = 2 THEN 'Álcool'  WHEN v.tipocombustivel = 3 THEN 'Diesel' WHEN v.tipocombustivel = 4 THEN 'Diesel S10' end AS combustivel FROM veiculo v, setor s WHERE v.idsetor = s.idsetor ORDER BY v.placa";
	$stmt = $oConexao->prepare($sql);  
	$stmt->execute();
	$solicitacao = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($solicitacao);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}

?>