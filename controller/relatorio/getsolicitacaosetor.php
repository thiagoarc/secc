<?php 

$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	//return JSON
	$solicitacao = array();

	if( $params->setor == null ){

		$stmt = $oConexao->prepare("SELECT a.idsolicitacao, DATE_FORMAT(a.datasolicitacao, '%d%m%Y') as datasolicitacao, DATE_FORMAT(a.datasolicitacao, '%H\h%y') as horasolicitacao, a.idusuario, a.status, a.motivo, b.nome, c.nome as setor
										FROM solicitacao a
										LEFT JOIN usuario b ON(a.idusuario = b.idusuario)
										LEFT JOIN setor c ON(b.idsetor = c.idsetor)
										ORDER BY a.idsolicitacao DESC");  
		$stmt->execute();

	}else{

		$stmt = $oConexao->prepare("SELECT a.idsolicitacao, DATE_FORMAT(a.datasolicitacao, '%d%m%Y') as datasolicitacao, DATE_FORMAT(a.datasolicitacao, '%H\h%y') as horasolicitacao, a.idusuario, a.status, a.motivo, b.nome, c.nome as setor
										FROM solicitacao a
										LEFT JOIN usuario b ON(a.idusuario = b.idusuario)
										LEFT JOIN setor c ON(b.idsetor = c.idsetor)
											WHERE
												c.idsetor = :setor
											ORDER BY a.idsolicitacao DESC");  
		$stmt->bindParam('setor',  $params->setor);
		$stmt->execute();

	}

	$item = $stmt->fetchAll(PDO::FETCH_ASSOC);

	if( $item ){
		$i = 0;
		foreach( $item as $row ){

			//informações comuns
			$solicitacao[$i]['idsolicitacao'] = $row['idsolicitacao'];
			$solicitacao[$i]['datasolicitacao'] = $row['datasolicitacao'];
			$solicitacao[$i]['horasolicitacao'] = $row['horasolicitacao'];
			$solicitacao[$i]['status'] = $row['status'];
			$solicitacao[$i]['solicitante'] = $row['nome'];
			$solicitacao[$i]['motivo'] = $row['motivo'];

			$i++;
		}

		echo json_encode($solicitacao);

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