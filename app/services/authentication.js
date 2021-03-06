'use strict';

app
	.factory('authenticationSrv', [ '$http', '$location', 'sessionSrv' , function( $http, $location, sessionSrv ){

		return {

			login: function( data, scope ){
				/* enable loading and submitting before authentication */
				scope.isloading 	= true;
				scope.submitting	= true;
				/* send data to authentication login */
				$http.post('/controller/authentication/login', data)
				.success(function( data ){
					if( data.email ){
						sessionSrv.set('ang_secc_uid', data.idusuario);
						sessionSrv.set('ang_secc_email', data.email);
						sessionSrv.set('ang_secc_profile', data.perfil);
						switch( parseInt(data.perfil) ){
							case 1: //administrador
								$location.path('/app');
							break;
							case 2: //gestor de contrato
								$location.path('/contrato');
							break;
							case 3: //gestor de compras
								$location.path('/ordemservico');
							break;
							case 4: //gestor de estoque
								$location.path('/solicitacao');
							break;
							case 5: //gestor de compras/estoque
								$location.path('/ordemservico');
							break;
							case 6: //observador
								$location.path('/relatorio/contratoativos/');
							break;
							case 7: //gestor do sistema
								$location.path('/app');
							break;
							case 8: //gestor de contrato/compras
								$location.path('/contrato');
							break;
							case 9: //solicitante de material
								$location.path('/solicitacaouser');
							break;
							case 10: //gestor de combustivel
								$location.path('/saidacombustivel');
							break;
							default:
								$location.path('/app');
							break;
						}
						
					}else if( data.credentials ){
						scope.msgcredentials = 'Favor verifique os dados, credenciais informada está incorreta.';
						/* clear model usuarioLogin */
						scope.usuarioLogin.email 	= null;
						scope.usuarioLogin.password = null;
						/* enable message error authentication */
						scope.msgErrorAuthentication = true;
					}
					/* disabled loading and submitting after authentication */
					scope.isloading 	= false;
					scope.submitting 	= false;
				})
				.error(function( error ){
					console.log( error );
				});
			},

			logout: function(){
				sessionSrv.destroy('ang_secc_uid');
				sessionSrv.destroy('ang_secc_email');
				sessionSrv.destroy('ang_secc_profile');
				$location.path('/login');
			},

			isLogged: function(){
 				var $checkSessionLogin = $http.post('/controller/authentication/checksessionlogin');
 				return $checkSessionLogin;
			},

			rolesPermission: function(){
				var $getRolesPermission = $http.post('/controller/authentication/rolespermissionlogin');
				return $getRolesPermission;
			}
			
		}

	}]);