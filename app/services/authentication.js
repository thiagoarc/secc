'use strict';

app
	.factory('authenticationSrv', [ '$http', '$location', 'sessionSrv' , function( $http, $location, sessionSrv ){

		return {

			login: function( data, scope ){
				//enable loading and submitting before authentication
				scope.isloading 	= true;
				scope.submitting	= true;
				/* send data to authentication login */
				$http.post('/controller/authentication/login', data)
				.success(function( data ){
					if( data.email ){
						console.log( data );
						// sessionSrv.set('ang_secc_uid', data.email);
						// sessionSrv.set('ang_secc_profile', data.email);
						// $location.path('/app');
					}else if( data.credentials ){
						scope.msgcredentials = 'Favor verifique, credenciais está incorreta.';
						//clear model usuarioLogin
						scope.usuarioLogin.email 	= null;
						scope.usuarioLogin.password = null;
						//enable message error authentication
						scope.msgErrorAuthentication = true;
					}
					//disabled loading and submitting after authentication
					scope.isloading 	= false;
					scope.submitting 	= false;
				})
				.error(function( error ){
					console.log( error );
				});
			},

			logout: function(){
				sessionSrv.destroy('ang_secc_uid');
				$location.path('/login');
			},

			isLogged: function(){
				if( sessionSrv.get('ang_secc_uid') ){
					return true;
				}else{
					return false;
				}
			}

		}

	}]);