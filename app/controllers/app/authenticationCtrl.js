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

				//aplication background body
				jQuery('body').addClass('bg-image');
        		jQuery('body').css('background-image', 'url("/assets/img/photos/photo1@2x.jpg")');

				$scope.login = function( data ){
					authenticationSrv.login( data, $scope );
				}

				$scope.logout = function(){
					authenticationSrv.logout();
				}

			}
		]
	);