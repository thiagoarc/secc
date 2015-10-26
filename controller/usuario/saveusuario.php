<?php 
	
$oConexao = Conexao::getInstance();

//params
$params = json_decode(file_get_contents('php://input'));

try{

	if( $params->idusuario != '' ){

		$stmt = $oConexao->prepare("UPDATE usuario SET nome = :nome, email = :email,  perfil = :perfil WHERE idusuario = :idusuario");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('perfil', $params->perfil);
		$stmt->bindParam('idusuario', $params->idusuario);
		$stmt->execute();

        //deletar o perfil do usuário
        $stmtUsuarioPerfil = $oConexao->prepare('DELETE FROM usuario_permissao WHERE idusuario = ?');
        $stmtUsuarioPerfil->bindParam(1, $params->idusuario);
        $stmtUsuarioPerfil->execute();

        //adicionar permissão do usuário
        if( $params->perfil == 1 ){ //adminstrador
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/usuario", :usuario),
                                            ("/usuario/add", :usuario),
                                            ("/usuario/edit", :usuario),
                                            ("/unidademedida", :usuario),
                                            ("/unidademedida/add", :usuario),
                                            ("/unidademedida/edit", :usuario),
                                            ("/fornecedor", :usuario),
                                            ("/fornecedor/add", :usuario),
                                            ("/fornecedor/edit", :usuario),
                                            ("/produto", :usuario),
                                            ("/produto/add", :usuario),
                                            ("/produto/edit", :usuario),
                                            ("/contrato", :usuario),
                                            ("/contrato/add", :usuario),
                                            ("/contrato/edit", :usuario),
                                            ("/contrato/fornecedor", :usuario),
                                            ("/contrato/aditivos", :usuario),
                                            ("/contrato/aditivo/add", :usuario),
                                            ("/contrato/aditivo/edit", :usuario),
                                            ("/contrato/aditivos/itens", :usuario),
                                            ("/contrato/itens", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/estoque", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)

                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 2 ){ // gestor de contrato
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/unidademedida", :usuario),
                                            ("/unidademedida/add", :usuario),
                                            ("/unidademedida/edit", :usuario),
                                            ("/fornecedor", :usuario),
                                            ("/fornecedor/add", :usuario),
                                            ("/fornecedor/edit", :usuario),
                                            ("/produto", :usuario),
                                            ("/produto/add", :usuario),
                                            ("/produto/edit", :usuario),
                                            ("/contrato", :usuario),
                                            ("/contrato/add", :usuario),
                                            ("/contrato/edit", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 3 ){ //gestor de compras
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
         }else if( $params->perfil == 4 ){ //gestor de estoque
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 5 ){ //gestor de compras/estoque
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/relatorio", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 6 ){ //observador
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $params->idusuario);
            $stmtPerfil->execute();
        }

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Alteração realizada com sucesso.';
    	echo json_encode($msg);

	}else{
 
		$stmt = $oConexao->prepare("INSERT INTO usuario (nome, email, senha, perfil, liberado) VALUES(:nome, :email, :senha, :perfil, 1)");  
		$stmt->bindParam('nome', $params->nome);
		$stmt->bindParam('email', $params->email);
		$stmt->bindParam('senha', sha1( SALT. $params->senha ) );
		$stmt->bindParam('perfil', $params->perfil);
		$stmt->execute();
		$usuario = $oConexao->lastInsertId('idusuario');

		//adicionar permissão do usuário
        if( $params->perfil == 1 ){ //adminstrador
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/usuario", :usuario),
                                            ("/usuario/add", :usuario),
                                            ("/usuario/edit", :usuario),
                                            ("/unidademedida", :usuario),
                                            ("/unidademedida/add", :usuario),
                                            ("/unidademedida/edit", :usuario),
                                            ("/fornecedor", :usuario),
                                            ("/fornecedor/add", :usuario),
                                            ("/fornecedor/edit", :usuario),
                                            ("/produto", :usuario),
                                            ("/produto/add", :usuario),
                                            ("/produto/edit", :usuario),
                                            ("/contrato", :usuario),
                                            ("/contrato/add", :usuario),
                                            ("/contrato/edit", :usuario),
                                            ("/contrato/fornecedor", :usuario),
                                            ("/contrato/aditivos", :usuario),
                                            ("/contrato/aditivo/add", :usuario),
                                            ("/contrato/aditivo/edit", :usuario),
                                            ("/contrato/aditivos/itens", :usuario),
                                            ("/contrato/itens", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/estoque", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)

                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 2 ){ // gestor de contrato
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/unidademedida", :usuario),
                                            ("/unidademedida/add", :usuario),
                                            ("/unidademedida/edit", :usuario),
                                            ("/fornecedor", :usuario),
                                            ("/fornecedor/add", :usuario),
                                            ("/fornecedor/edit", :usuario),
                                            ("/produto", :usuario),
                                            ("/produto/add", :usuario),
                                            ("/produto/edit", :usuario),
                                            ("/contrato", :usuario),
                                            ("/contrato/add", :usuario),
                                            ("/contrato/edit", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 3 ){ //gestor de compras
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
         }else if( $params->perfil == 4 ){ //gestor de estoque
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 5 ){ //gestor de compras/estoque
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/ordemservico", :usuario),
                                            ("/ordemservico/add", :usuario),
                                            ("/relatorio", :usuario),
                                            ("/entrada", :usuario),
                                            ("/solicitacao", :usuario),
                                            ("/solicitacao/detalhes", :usuario),
                                            ("/saida", :usuario),
                                            ("/saida/add", :usuario),
                                            ("/saida/detalhes", :usuario),
                                            ("/solicitacaouser", :usuario),
                                            ("/solicitacaouser/add", :usuario),
                                            ("/solicitacaouser/edit", :usuario),
                                            ("/solicitacaouser/detalhes", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
        }else if( $params->perfil == 6 ){ //observador
            $stmtPerfil = $oConexao->prepare('INSERT INTO usuario_permissao(roles, idusuario) 
                                        VALUES
                                            ("/app", :usuario),
                                            ("/relatorio", :usuario)
                                    ');
            $stmtPerfil->bindParam('usuario', $usuario);
            $stmtPerfil->execute();
        }

		$oConexao = null;

		$msg['msg']         = 'success';
    	$msg['msg_success'] = 'Cadastro realizado com sucesso.';
    	echo json_encode($msg);
	
	}

}catch (PDOException $e){
    $oConexao->rollBack();
   	$msg['msg']         = 'error';
    $msg['msg_error'] 	= $e->getMessage()." - Por favor entre em contato com o adimistrador do sistema e informe o erro.";
	die();
}

?>