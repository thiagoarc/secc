<?php 

$oConexao = Conexao::getInstance();

try{

	$sql = "SELECT a.numero, DATE_FORMAT(a.validade, '%d%m%Y') as validade, a.valor, a.obs
				FROM aditivo a
					WHERE 
					a.validade < now() 
					ORDER BY 
					a.validade asc";
	$stmt = $oConexao->query($sql);  
	$aditivov = $stmt->fetchAll(PDO::FETCH_OBJ);
	$oConexao = null;
	echo json_encode($aditivov);

}catch (PDOException $e){
    $oConexao->rollBack();
    $msg['msg']         = 'error';
    $msg['msg_error'] 	= $e->getMessage()." - Por favor entre em contato com o adimistrador do sistema e informe o erro.";
	die();
}

?>