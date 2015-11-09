<?php 

  ob_start();
  session_start();

  //ADICIONAR A CONEXAO E URL AMIGAVEL
  include_once "../conn/Url.php";
  include_once "../conn/config.php";

  //FUNCOES
  include_once "../conn/functions.php";
  
  //INSTANCIA A CONEXAO
  $oConexao = Conexao::getInstance();

?>

<?php   

    $folder                 = Url::getURL( 0 );
    $file                   = Url::getURL( 1 );
    $params                 = Url::getURL( 2 );

    if( $folder != NULL && file_exists( $folder.".php" ) ){
      include_once $folder.".php";
      exit();
    }else if( $file != NULL && file_exists( $folder.'/'.$file.".php" ) ){
      include_once $folder.'/'.$file.".php";
      exit();
    }

?>