'use strict';

app
	.controller('contratoEmpenhoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contratoItens 		= {};
				$scope.contratoItens.idempenho_contrato 		= 0;
				$scope.totalgeral 			= 0; 	
				$scope.contrato 			= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.itenscadastrados 	= [];
			    $scope.mostraBotao			= false;			

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    $scope.loadcontratositens = function(idcontrato){
					
					$scope.contratoItens.idcontrato = idcontrato;
					$http({
						method: 'POST',
						url: '/controller/contrato/contratoempenhos',
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




				var itemid = $routeParams.idcontrato || 0;
				//$scope.loadcontratosfornecedores(itemid);
				if( itemid && itemid > 0){
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.contrato = data;
					});
					$scope.loadcontratositens(itemid);
				}


				$scope.pegaContrato = function(itemid){
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.contrato = data;
						$scope.contratoItens.idcontrato = $scope.contrato.idcontrato;
					});
				}

				

				
				$scope.loadfornecedores = function(){
					
					/*$http.get('/controller/contrato/contraofornecedores' )
						.success(function(data){
							$scope.fornecedores = data;
						});*/
					$http({
						method: 'POST',
						url: '/controller/contrato/contratofornecedores',
						data: { id: itemid } 
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
						url: '/controller/contrato/getcontratoempenhos',
						data: { id: itemid.idempenho_contrato } 
					}).success(function(data){
						//console.log(data);
						// $scope.contratoItens 		= null;
						$scope.contratoItens = data[0];
						//console.log(data);
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
						//console.log(item.valor);
						$scope.totalgeral += parseFloat(item.valor);
					});
				}

				$scope.calculaTotalGeralParaEdicao = function(id){
					//for(var i = 0; i < $scope.itenscadastrados.length; i++){
					var totalEdicao = 0;
					angular.forEach($scope.itenscadastrados, function(item) {
						//console.log(item.total);
						if(id != item.idempenho_contrato)
							totalEdicao += parseFloat(item.valor);
					});
					return totalEdicao;
				}


				$scope.additens = function(){
						$scope.mostraBotao = false;
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//$scope.pegaContrato(itemid);
						//console.log($scope.contratoItens.iditens_contrato);
						//console.log($scope.calculaTotalGeralParaEdicao($scope.contratoItens.iditens_contrato));
						var totalTMP = 0;
						//verifica se o total de itens e igual ou inferior ao total do contrato
						if($scope.contratoItens.idempenho_contrato > 0)
							totalTMP = $scope.calculaTotalGeralParaEdicao($scope.contratoItens.idempenho_contrato) + parseFloat($scope.contratoItens.valor);
						else{
							console.log("GERAL: "+$scope.totalgeral);
							console.log("VALOR: "+$scope.contratoItens.valor);
							console.log("Contrato: "+$scope.contrato.valor);
							totalTMP = $scope.totalgeral + $scope.contratoItens.valor;
						}
						console.log(totalTMP);
						if(totalTMP <= $scope.contrato.valor){
							//console.log($scope.contratoItens.iditens_contrato);
							//via http
							$http.post('/controller/contrato/savecontratoempenho', $scope.contratoItens )
							.success(function(data){
								//saving set false
								$scope.submitting = false;
								//hide loading
								$scope.isloading = false;
								//success
								//$location.path('/contrato');
								$scope.loadcontratositens(itemid);
								//show message
								if(data.msg == 'success'){
									//show message
									appMessages.addMessage(data.msg_success, true, 'success');
									$scope.contratoItens 				= {};
									$scope.contratoItens.idempenho_contrato 		= 0;
									$scope.pegaContrato(itemid);
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
							appMessages.addMessage("O valor da adição/edição deste empenho é superior ao valor total do contrato.", true, 'danger');
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							$scope.contratoItens = {};
							$scope.contratoItens.idempenho_contrato 		= 0;
							//$scope.mudaBotao();
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
						}
				};

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(contratoItensdelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratoItenss) {
				      	
					      	$scope.contratoItens = contratoItenss;
					      	$scope.modalItem =  contratoItenss.numero;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.contratoItens);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	contratoItenss: function () {
				          		return contratoItensdelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (contratoItens) {
				      $scope.deleteitem( contratoItens.idempenho_contrato );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletecontratoempenho' , {id: itemid});
					itemcontrato.delete(
						function(data){
							//success
							$scope.loadcontratositens(itemid);
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
	

	