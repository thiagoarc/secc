'use strict';

app
	.controller('contratoAditivoEmpenhoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.aditivoItens 		= {};
				$scope.aditivoItens.idempenho_aditivo 		= 0;
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
			    $scope.mostraBotao			= true;
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
						url: '/controller/contrato/aditivoempenhos',
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

				$scope.pegaAditivo = function(itemid){
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivo',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.aditivo = data;
						$scope.aditivoItens.idaditivo = $scope.aditivo.idaditivo;
					});
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
					//$scope.mostraBotao = false;
					
					/*$http.get('/controller/contrato/contraofornecedores' )
						.success(function(data){
							$scope.fornecedores = data;
						});*/
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivoempenhos',
						data: { id: itemid.idempenho_aditivo } 
					}).success(function(data){
						//console.log(data);
						// $scope.contratoItens 		= null;
						$scope.aditivoItens = data[0];
						// console.log(data);
						// $scope.contratoItens.descricao = data.descricao;
						// console.log($scope.contratoItens);
					});

				};

				$scope.mudaBotao = function(){
					console.log("OI");
					if($scope.aditivoItens.idempenho_aditivo == 0){
						$scope.mostraBotao = true;
					}else{
						$scope.mostraBotao = false;
					}
					// if($scope.mostraBotao == true){
					// 	$scope.mostraBotao = false;
					// }else{
					// 	$scope.mostraBotao = true;
					// }
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
						$scope.totalgeral += parseFloat(item.valor);
					});
				}

				$scope.calculaTotalGeralParaEdicao = function(id){
					//for(var i = 0; i < $scope.itenscadastrados.length; i++){
					var totalEdicao = 0;
					angular.forEach($scope.itenscadastrados, function(item) {
						//console.log(item.total);
						if(id != item.idempenho_aditivo)
							totalEdicao += parseFloat(item.valor);
					});
					return totalEdicao;
				}


				$scope.additens = function(){
						$scope.mostraBotao = true;
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//$scope.pegaContrato(itemid);
						//console.log($scope.aditivoItens.iditens_aditivo);
						//console.log($scope.calculaTotalGeralParaEdicao($scope.aditivoItens.iditens_aditivo));
						var totalTMP = 0;

						$scope.aditivoItens.idaditivo = itemid;
						//verifica se o total de itens e igual ou inferior ao total do contrato
						if($scope.aditivoItens.idempenho_aditivo > 0)
							totalTMP = $scope.calculaTotalGeralParaEdicao($scope.aditivoItens.idempenho_aditivo) + parseFloat($scope.aditivoItens.valor);
						else
							totalTMP = $scope.totalgeral + $scope.aditivoItens.valor;
						//console.log(totalTMP);
						if(totalTMP <= $scope.aditivo.valor){
							//via http
							$http.post('/controller/contrato/saveaditivoempenho', $scope.aditivoItens )
							.success(function(data){
								//saving set false
								$scope.submitting = false;
								//hide loading
								$scope.isloading = false;
								//success
								//$location.path('/contrato');
								$scope.loadaditivoitens($scope.aditivoItens.itemid);
								//show message
								if(data.msg == 'success'){
									//show message
									appMessages.addMessage(data.msg_success, true, 'success');
									$scope.aditivoItens 				= {};
									$scope.aditivoItens.idempenho_aditivo = 0;
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
						}else{
							appMessages.addMessage("O valor da adição/edição deste produto/serviço é superior ao valor total do aditivo.", true, 'danger');
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							$scope.aditivoItens = {};
							$scope.aditivoItens.idempenho_aditivo = 0;
							//$scope.mudaBotao();
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
						}
				};

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(aditivoItensdelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, aditivoItenss) {
				      	
					      	$scope.aditivoItens = aditivoItenss;
					      	$scope.modalItem =  aditivoItenss.numero;
					      	
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
				      $scope.deleteitem( aditivoItens.idempenho_aditivo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.deleteitem = function(itemid){
					var itemaditivo = $resource('/controller/contrato/deleteaditivoempenho' , {id: itemid});
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
	

	