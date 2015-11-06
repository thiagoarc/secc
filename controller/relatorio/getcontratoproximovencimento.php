<?php 

$oConexao = Conexao::getInstance();

try{

	$sql = "SELECT a.numerocontrato, a.tipo, a.objeto, DATE_FORMAT(a.validade, '%d%m%Y') as validade, a.valor, b.nome as orgao
				FROM contrato a
				LEFT JOIN orgao b ON(a.idorgao = b.idorgao)
					WHERE 
					a.validade >= now() 
					AND
					TIMESTAMPDIFF(DAY, now(), validade) > 30
					ORDER BY 
					a.validade asc";
	$stmt = $oConexao->query($sql);  
	$contratoativos = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($contratoativos);

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_error'] 	= $e->getMessage()." - Por favor entre em contato com o adimistrador do sistema e informe o erro.";
	die();
}

?>