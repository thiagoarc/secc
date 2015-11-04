<?php 	
/*$oConexao = Conexao::getInstance();

//params json 
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->id > 0){
		$stmt = $oConexao->prepare("SELECT ic.iditens_contrato, ic.idcontrato, ic.descricao, ic.qtd, ic.valorunitario, um.sigla, um.idunidade_medida, f.razaosocial, f.idfornecedor FROM itens_contrato ic, unidade_medida um, fornecedor f WHERE  f.idfornecedor = ic.idfornecedor AND um.idunidade_medida = ic.idunidade_medida AND ic.iditens_contrato = :id");  
		$stmt->bindParam('id', $params->id);
		$stmt->execute();
		$fornecedores = $stmt->fetchObject();
		$oConexao = null;
		echo json_encode($fornecedores);
	}

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	die();
}*/

?>

<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT ec.idempenho_aditivo, ec.idaditivo, ec.idfornecedor, f.razaosocial, ec.valor, ec.numero, f.cnpj FROM empenho_aditivo ec, aditivo c, fornecedor f WHERE  f.idfornecedor = ec.idfornecedor AND ec.idaditivo = c.idaditivo AND ec.idempenho_aditivo = :id";
	$stmt = $oConexao->prepare($sql);  
	$stmt->bindParam('id', $params->id);
	$stmt->execute();
	$fornecedores = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($fornecedores);

}catch (PDOException $e){
    $oConexao->rollBack();
    echo '{"error":{"text":'.$e->getMessage().'}}'; 
	die();
}

?>