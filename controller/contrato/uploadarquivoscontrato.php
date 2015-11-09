<?php
//include_once('../../conn/config.php');
//$oConexao = Conexao::getInstance();


if ( !empty( $_FILES ) ) {

	//try{
		$idcontrato = $_GET["idcontrato"];
	    $tempPath = $_FILES[ 'file' ][ 'tmp_name' ];
	    $extensao = strtolower(end(explode('.', $_FILES[ 'file' ][ 'name' ])));
	    $nomearquivo = md5(uniqid(time())).".".$extensao;
	    //$uploadPath = dirname( __FILE__ ) . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . $_FILES[ 'file' ][ 'name' ];
	    $uploadPath = dirname( __FILE__ ) . DIRECTORY_SEPARATOR . $nomearquivo;
	    echo $uploadPath;
	    //$uploadPath = dirname('/secc/upload/' . $nomearquivo);
	    //$uploadPath = '/secc/upload/' . $nomearquivo;
	    //echo $uploadPath;

	     //if(move_uploaded_file( $tempPath, $uploadPath )){

	  //   	$stmt = $oConexao->prepare("INSERT INTO arquivos_contrato (idcontrato, nome, arquivo) VALUES (:idcontrato, :nome, :arquivo)";
	  //   	$stmt->bindParam('idcontrato', $idcontrato);
	  //   	$stmt->bindParam('nome', $_FILES[ 'file' ][ 'name' ]);
	  //   	$stmt->bindParam('arquivo', $nomearquivo);
	  //   	$stmt->execute();
			// $oConexao = null;

	    // 	$answer = array( 'answer' => 'File transfer completed' );
	    // 	$json = json_encode( $answer );
	    // }else{
	    // 	$answer = array( 'answer' => 'error' );
	    // 	$json = json_encode( $answer );
	    // }
	    // echo $json;
	// }catch (PDOException $e){
	// 	$oConexao->rollBack();
 //    	echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	// 	die();
	// }

} else {

    echo 'No files';

}
?>