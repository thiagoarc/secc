<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

$limit = $params->limit != '' ?  $params->limit : 10;

try{

	//codigo para mostrar a diferenca de datas
	//TIMESTAMPDIFF(DAY, now(), validade) AS Dias
	//o codigo resolve o lance do botão de aditivo e da legenda para mostrar a situação do contrato.


	//$stmt = $oConexao->prepare("SELECT idcontrato, idorgao, tipo, tipoobjetos, numerotali, DATE_FORMAT(dataassinaturatali, '%d/%m/%Y') as dataassinaturatali, numeroata, DATE_FORMAT(validadeata, '%d/%m/%Y') as validadeata, numeropregao, 
	//		numeroprocesso, numerocd, numeroparecerjuridico, DATE_FORMAT(datacompra, '%d/%m/%Y') as datacompra, numerocontrato, objeto, valor, DATE_FORMAT(validade, '%d/%m/%Y') as validade, DATE_FORMAT(dataassinatura, '%d/%m/%Y') as dataassinatura, numeroempenho FROM contrato WHERE idcontrato = :id");  
	//$sql = "SELECT idcontrato, idorgao, CASE WHEN tipo = 1 THEN 'Termo de Adesão' WHEN tipo = 2 THEN 'Licitação' WHEN tipo = 3 THEN 'Compra Direta' end AS tipo, numerocontrato, valor, DATE_FORMAT(validade, '%d/%m/%Y') as validade FROM contrato ORDER BY idcontrato desc LIMIT 0, $limit";
	$sql = "SELECT c.idcontrato, c.idorgao, CASE WHEN c.tipo = 1 THEN 'Termo de Adesão' WHEN c.tipo = 2 THEN 'Licitação' WHEN c.tipo = 3 THEN 'Compra Direta' WHEN c.tipo = 4 THEN 'Dispensa de Licitação' end AS tipo, CASE WHEN c.tipoobjetos = 1 THEN 'Material de Consumo' WHEN c.tipoobjetos = 2 THEN 'Bens' WHEN c.tipoobjetos = 3 THEN 'Serviços' WHEN c.tipoobjetos = 4 THEN 'Locação' end AS tipoobjetos, c.numerotali, DATE_FORMAT(c.dataassinaturatali, '%d/%m/%Y') as dataassinaturatali, c.numeroata, DATE_FORMAT(c.validadeata, '%d/%m/%Y') as validadeata, c.numeropregao, 
			c.numeroprocesso, c.numerocd, c.numeroparecerjuridico, DATE_FORMAT(c.datacompra, '%d/%m/%Y') as datacompra, c.numerocontrato, c.objeto, c.valor, DATE_FORMAT(c.validade, '%d/%m/%Y') as validade, DATE_FORMAT(c.dataassinatura, '%d/%m/%Y') as dataassinatura, c.numeroempenho, TIMESTAMPDIFF(DAY, now(), c.validade) AS diasrestantes, o.sigla, o.nome FROM contrato c LEFT JOIN orgao o ON c.idorgao=o.idorgao ORDER BY c.idcontrato desc LIMIT 0, $limit";
	$stmt = $oConexao->query($sql);  
	$fornecedores = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($fornecedores);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'.$e->getMessage().'}}'; 
	die();
}

?>