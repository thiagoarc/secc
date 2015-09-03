<?php 

$oConexao = Conexao::getInstance();

$params = json_decode(file_get_contents('php://input'));

try{

	$sql = "SELECT ic.iditens_contrato, ic.idcontrato, ic.descricao, ic.qtd, ic.valorunitario, (ic.qtd*ic.valorunitario) as total, um.sigla, um.idunidade_medida, f.razaosocial, f.idfornecedor FROM itens_contrato ic, unidade_medida um, fornecedor f WHERE  f.idfornecedor = ic.idfornecedor AND um.idunidade_medida = ic.idunidade_medida AND ic.idcontrato = :id ORDER BY ic.descricao asc";
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