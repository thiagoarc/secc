'use strict';

app
	.controller('contratoItensAditivoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.aditivoItens 		= {};
				$scope.totalgeral 			= 0; 	
				$scope.aditivo 				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.itenscadastrados 	= [];
			    $scope.mostraBotao			= false;
			    $scope.idcontrato			= 0;			

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    $scope.loadaditivoitens = function(idaditivo){
					
					$scope.aditivoItens.idaditivo = idaditivo;
					$http({
						method: 'POST',
						url: '/controller/contrato/aditivoitens',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.itenscadastrados = data;
						$scope.calculaTotalGeral();
						$scope.currentPage = 1; //current page
						$scope.entryLimit = 20; //max no of items to display in a page
						$scope.filteredItems = $scope.itenscadastrados.length; //Initially for no filter
						$scope.totalItems = $scope.itenscadastrados.length;
  						$scope.numPerPage = 20;
					});

				};




				var itemid = $routeParams.idaditivo || 0;
				//$scope.loadcontratosfornecedores(itemid);
				if( itemid && itemid > 0){
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivo',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.aditivo = data;
						console.log($scope.aditivo);
						$scope.idcontrato = $scope.aditivo.idcontrato;
						$scope.loadfornecedores($scope.aditivo.idcontrato);
					});
					$scope.loadaditivoitens(itemid);
				}

				

				
				$scope.loadfornecedores = function(idcontrato){
					//console.log(idcontrato);
					$http({
						method: 'POST',
						url: '/controller/contrato/contratofornecedores',
						data: { id: idcontrato } 
					}).success(function(data){
						//console.log(data);
						$scope.fornecedores = data;
					});

				};

				$scope.editar = function(itemid){
					
					/*$http.get('/controller/contrato/contraofornecedores' )
						.success(function(data){
							$scope.fornecedores = data;
						});*/
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivoitens',
						data: { id: itemid.iditens_aditivo } 
					}).success(function(data){
						//console.log(data);
						// $scope.contratoItens 		= null;
						$scope.aditivoItens = data;
						// console.log(data);
						// $scope.contratoItens.descricao = data.descricao;
						// console.log($scope.contratoItens);
					});

				};


				$scope.mudaBotao = function(){
					if($scope.mostraBotao == true){
						$scope.mostraBotao = false;
					}else{
						$scope.mostraBotao = true;
					}
				}

				$scope.loadunidademedida = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidadesmedida = data;
						});

				};

				$scope.calculaTotalGeral = function(){
					//for(var i = 0; i < $scope.itenscadastrados.length; i++){
					$scope.totalgeral 			= 0; 
					angular.forEach($scope.itenscadastrados, function(item) {
						//console.log(item.total);
						$scope.totalgeral += parseFloat(item.total);
					});
				}


				$scope.additens = function(){
						$scope.mostraBotao = false;
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/contrato/saveaditivoitens', $scope.aditivoItens )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							//$location.path('/contrato');
							$scope.loadaditivoitens($scope.aditivoItens.idaditivo);
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								$scope.aditivoItens 				= {};
							}else if(data.msg == 'error_existe'){
								appMessages.addMessage(data.msg_success, true, 'danger');
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
				};

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(aditivoItensdelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, aditivoItenss) {
				      	
					      	$scope.aditivoItens = aditivoItenss;
					      	$scope.modalItem =  aditivoItenss.descricao;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.aditivoItens);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	aditivoItenss: function () {
				          		return aditivoItensdelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (aditivoItens) {
				      $scope.deleteitem( aditivoItens.iditens_aditivo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.deleteitem = function(itemid){
					var itemaditivo = $resource('/controller/aditivo/deleteaditivoitens' , {id: itemid});
					itemaditivo.delete(
						function(data){
							//success
							$scope.loadaditivoitens(itemid);
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
	

	