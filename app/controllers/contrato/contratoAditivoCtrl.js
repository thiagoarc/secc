'use strict';

app
	.controller('contratoAditivoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contratoAditivo 		= {};
				$scope.contrato 			= {};
				$scope.arquivos 			= [];
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.newcontrato			= null;
			    $scope.idcontrato			= null;
			    $scope.itenscadastrados 	= [];
			    $scope.totalgeral 			= 0;
			    $scope.totalItemsD			= 0;
			    $scope.qtdAditivos			= 0;
			    $scope.totalItemsA			= 0;

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


			    $scope.idcontrato 	= $routeParams.idcontrato || 0;

				if( $scope.idcontrato && $scope.idcontrato > 0){
					console.log($scope.idcontrato);
					$scope.newcontrato = $scope.idcontrato;
					console.log($scope.newcontrato);
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: $scope.idcontrato } 
					}).success(function(data){
						$scope.contrato = data;
					});
					
				}


				$scope.newcontrato 	= $routeParams.newcontrato || 0;

				if( $scope.newcontrato && $scope.newcontrato > 0){
					//via http
					$scope.contratoAditivo.idcontrato = $scope.newcontrato;
					$scope.idcontrato = $scope.newcontrato;
				}

				var itemidaditivo = $routeParams.idaditivo || 0;

				if( itemidaditivo && itemidaditivo > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivo',
						data: { id: itemidaditivo } 
					}).success(function(data){
						$scope.contratoAditivo = data;
					});
					
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(contratodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratos) {
				      	
					      	$scope.contrato = contratos;
					      	$scope.modalItem =  "de número: "+contratos.numero;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.contrato);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	contratos: function () {
				          		return contratodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (contratoAditivo) {
				      $scope.deleteitem( contratoAditivo.idaditivo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.aditivaritens = function(contratoAditivo){
					//alert(contratoAditivo.idcontrato);
					$http({
						method: 'POST',
						url: '/controller/contrato/copiaitens',
						data: { idcontrato: contratoAditivo.idcontrato, idaditivo: contratoAditivo.idaditivo } 
					}).success(function(data){
						//$scope.contratoAditivo = data;
						if(data.msg == 'success'){
							$location.path('/contrato/aditivo/itens/'+contratoAditivo.idaditivo);
							appMessages.addMessage(data.msg_success, true, 'success');
						}else if(data.msg == 'success1'){	
							$location.path('/contrato/aditivo/itens/'+contratoAditivo.idaditivo);
						}else if(data.msg == 'warning'){
								$location.path('/contrato/aditivo/itens/'+contratoAditivo.idaditivo);
								//appMessages.addMessage("O contrato não possui itens cadastrados", true, 'warning');
							}else{
								appMessages.addMessage("Ocorreu um erro: "+data.msg_success, true, 'danger');
							}
						
					});
				};

				//modal detahes
				// $scope.detalhes = function(contratoAditivo){

				// 	var modalInstance = $modal.open({
				// 		size: 'lg',
				// 		templateUrl: 'views/contrato/detalhesaditivo.html',
				// 		controller: function( $scope, $modalInstance, contratoRS ){

				// 			$scope.contratoAditivo = contratoAditivo;
				// 			$scope.cancel = function(){
				// 				$modalInstance.dismiss('cancel');
				// 			}

				// 		},
				// 		resolve: {
				// 			contratoAditivo: function(){
				// 				return contratoAditivo;
				// 			}
				// 		}
				// 	});
				// }

				//modal detahes
				$scope.detalhes = function(contrato){

					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/contrato/detalhesaditivo.html',
						controller: function( $scope, $modalInstance, contratoRS ){

							$scope.contratoAditivo = contratoRS;
							//busca os itens cadastrados neste contrato
							$http({
								method: 'POST',
								url: '/controller/contrato/aditivoitens',
								data: { id: $scope.contratoAditivo.idaditivo } 
							}).success(function(data){
								$scope.itenscadastrados = data;
								//$scope.calculaTotalGeral();
								$scope.totalItemsD = $scope.itenscadastrados.length;
								//faz o somatorio do total geral
								$scope.totalgeral 			= 0; 
								angular.forEach($scope.itenscadastrados, function(item) {
									$scope.totalgeral += parseFloat(item.total);
								});
							});

							//pega os arquivos
							//$scope.loadarquivos($scope.contrato.idcontrato);
							$http({
								method: 'POST',
								url: '/controller/contrato/arquivosaditivo',
								data: { id: $scope.contratoAditivo.idaditivo } 
							}).success(function(data){
								$scope.arquivos = data;
								$scope.currentPage = 1; //current page
								$scope.entryLimit = 50; //max no of items to display in a page
								$scope.filteredItems = $scope.arquivos.length; //Initially for no filter
								$scope.totalItemsA = $scope.arquivos.length;
  								$scope.numPerPage = 50;
							});

							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							contratoRS: function(){
								return contrato;
							}
						}
					});
				}

				

				$scope.load = function(){

					$http({
						method: 'POST',
						url: '/controller/contrato/aditivos',
						data: { id: $scope.idcontrato } 
					}).success(function(data){
						$scope.contratoAditivos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.contratoAditivos.length; //Initially for no filter
							$scope.totalItems = $scope.contratoAditivos.length;
  							$scope.numPerPage = 5;
					});

				};


				$scope.loadfornecedores = function(){
					
					$http.get('/controller/fornecedor/fornecedores')
						.success(function(data){
							$scope.fornecedores = data;
						});

				};

				$scope.novo = function(contrato){
					$scope.contrato = contrato;
					$scope.contratoAditivo.idcontrato = contrato.idcontrato;
					
					//$location.path('/contrato/aditivo/add');
				};

				

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.contratoAditivos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//$scope.contratoAditivo.idcontrato = $scope.newcontrato;
						//$scope.contratoAditivo.validade = $scope.formataData($scope.contratoAditivo.validade);

						//via http
						$http.post('/controller/contrato/saveaditivo', $scope.contratoAditivo )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/contrato/aditivos/'+$scope.contratoAditivo.idcontrato);
							//show message
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

						})
						.error(function(error){
							console.log(error);
						});

					}
				};

				$scope.formataData = function(data){
					if(data != null){
						var dataFormatada = data.substring(4, 8).toString()+"-"+data.substring(2, 4).toString()+"-"+data.substring(0, 2).toString();
						//alert(dataFormatada);
						return dataFormatada;
					}else{
						return "0000-00-00";
					}
				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deleteaditivo' , {id: itemid});
					itemcontrato.delete(
						function(data){
							//success
							$scope.load();
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
							}else if(data.msg == 'error1'){
								appMessages.addMessage(data.msg_success, true, 'danger');
							}else if(data.msg == 'error2'){
								appMessages.addMessage(data.msg_success, true, 'danger');
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
	

	