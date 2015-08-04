'use strict';

app
	.controller('authenticationCtrl',
		['$scope', 'authenticationSrv', 'sessionSrv',
			function($scope , authenticationSrv, sessionSrv ){

				$scope.msgErrorAuthentication 	= false;
				$scope.msgcredentials 			= '';
				$scope.usuarioLogin 			= {};
				$scope.isloading 				= false;
				$scope.submitting 				= false;

				$scope.login = function( data ){
					authenticationSrv.login( data, $scope );
				}

			}
		]
	);