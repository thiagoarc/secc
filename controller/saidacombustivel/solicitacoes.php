<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$idusuario = $_SESSION['ang_secc_uid'];

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	$sql = "SELECT s.idsaida, DATE_FORMAT(s.datasaida, '%d/%m/%Y') as datasaida, s.idusuario, se.sigla, se.nome, v.placa, v.motorista, v.modelo FROM saida s, setor se, veiculo v WHERE s.idveiculo = v.idveiculo AND s.idsetor = se.idsetor AND s.idusuario = :idusuario ORDER BY s.datasaida desc LIMIT 0, $limit";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('idusuario', $idusuario);
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