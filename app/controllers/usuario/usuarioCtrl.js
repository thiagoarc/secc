'use strict';

app
	.controller('usuarioCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.usuario 				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'nome'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.setor				= {};

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				var itemid = $routeParams.id || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/usuario/getusuario',
						data: { id: itemid } 
					}).success(function(data){
						$scope.usuario = data;
					});
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(usuariodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, usuarios) {
				      	
					      	$scope.usuario 		= usuarios;
					      	$scope.modalItem 	= usuarios.nome;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.usuario);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	usuarios: function () {
				          		return usuariodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (usuario) {
				      $scope.deleteitem( usuario.idusuario );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.redefinirsenha = function(usuarioredefinirsenha){
					var modalInstance = $modal.open({
						templateUrl: 'views/usuario/redefinirsenha.html',
						controller: function( $scope, $modalInstance, usuarioRS ){

							$scope.usuario = usuarioRS;
							$scope.usuario.senha = null;
							$scope.usuario.confirmasenha = null;

							$scope.notificationModal			= {}; // modal notification
						    $scope.notificationModal.typeAlert 	= 'success';
						    $scope.notificationModal.show 		= false;
						    $scope.notificationModal.msg 		= '';

							$scope.ok = function(){

								if( $scope.usuario.senha != $scope.usuario.confirmasenha ){
									$scope.RedifinePasswordForm.$valid = false;
									//show message
									$scope.notificationModal.typeAlert = 'danger';
									$scope.notificationModal.show = true;
									$scope.notificationModal.msg = 'Senhas não coincidem, favor verifique.';
									//show message in 5 seconds
									$timeout(function(){
										$scope.notificationModal.show = false;
									}, 5000);
								}
								if($scope.RedifinePasswordForm.$valid){
									$modalInstance.close($scope.usuario);
								}

							};

							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							usuarioRS: function(){
								return usuarioredefinirsenha;
							}
						}
					});

					modalInstance.result.then(function( usuario ){
						/* funcao ao salvar */
						$scope.saveredefinepassword( usuario );
					}, function(){
						/* funcao ao cancelar ou fechar o modal */
					});
				}

				$scope.saveredefinepassword = function( usuario ){
					$http.post('/controller/usuario/redefinirsenha', usuario)
					.success( function(data){
						//show message
						appMessages.addMessage(data.msg_success, true, 'success');
						//show message in 5 seconds
						$timeout(function(){
							appMessages.show = false;
						}, 5000);
					})
					.error( function(error){
						console.log(error);
					});
				}

				$scope.load = function(){
					
					$http.get('/controller/usuario/usuarios')
						.success(function(data){
							$scope.usuarios = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.usuarios.length; //Initially for no filter
							$scope.totalItems = $scope.usuarios.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.usuarios.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.loadsetor = function(){
					
					$http.get('/controller/usuario/getsetor')
						.success(function(data){
							$scope.setor = data;
						});

				};

				$scope.saveitem = function(){
					//validate password and confirm password
					if( $scope.usuario.senha != $scope.usuario.confirmasenha ){
						$scope.createForm.$valid = false;	
						//show message
						appMessages.addMessage('Senhas não coincidem, favor verifique.', true, 'danger');
						//show message in 5 seconds
						$timeout(function(){
							appMessages.show = false;
						}, 5000);
					}
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/usuario/saveusuario', $scope.usuario )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/usuario');
							//show message
							appMessages.addMessage(data.msg_success, true, 'success');
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);

						})
						.error(function(error){
							console.log(error);
						});

					}
				};

				$scope.deleteitem = function(itemid){
					var itemusuario = $resource('/controller/usuario/deleteusuario' , {id: itemid});
					itemusuario.delete(
						function(data){
							//success
							$scope.load();
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
							}else{
								appMessages.addMessage(data.msg_success, true, 'danger');
							}
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
						},
						function(error){
							console.log(error);
						}
					);
				};

			}
		]
	);
	

	