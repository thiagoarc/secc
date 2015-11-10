'use strict';

app
	.controller('contratoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contrato 			= {};
				$scope.arquivos 			= [];
				$scope.contratoItens 		= {};
				$scope.contratoItensE 		= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.tipoDetalhe1			= false;
			    $scope.tipoDetalhe2			= false;
			    $scope.itenscadastrados 	= [];
			    $scope.totalgeral 			= 0;
			    $scope.totalgeralE 			= 0;
			    $scope.totalItemsD			= 0;
			    $scope.totalItemsE			= 0;
			    $scope.totalItemsA			= 0;
			    $scope.qtdAditivos			= 0;
			    $scope.hoje					= (new Date()).getDate();
			    $scope.mostraAditivo 		= false;

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				var itemid = $routeParams.idcontrato || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: itemid } 
					}).success(function(data){
						$scope.contrato = data;
						console.log("DataAssinatura: "+$scope.contrato.dataassinatura);
					});

					$scope.tipo = $scope.contrato.tipo;
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(contratodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratos) {
				      	
					      	$scope.contrato = contratos;
					      	$scope.modalItem =  "de número de contrato: "+contratos.numerocontrato;
					      	
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

				  	modalInstance.result.then(function (contrato) {
				      $scope.deleteitem( contrato.idcontrato );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.mostraDetalhes = function(){
					if($scope.contrato.tipo == 'Termo de Adesão' || $scope.contrato.tipo == 'Licitação'){
						$scope.tipoDetalhe1			= true;
			    		$scope.tipoDetalhe2			= false;
			    		console.log("1 - "+$scope.tipoDetalhe1);
					}else{
						$scope.tipoDetalhe1			= false;
			    		$scope.tipoDetalhe2			= true;
			    		console.log("2 - "+$scope.tipoDetalhe2);
					}
				};

				//modal detahes
				$scope.detalhes = function(contrato){
					if(contrato.tipo == 'Termo de Adesão' || contrato.tipo == 'Licitação'){
						$scope.tipoDetalhe1			= true;
			    		$scope.tipoDetalhe2			= false;
			    		console.log("1 - "+$scope.tipoDetalhe1);
					}else{
						$scope.tipoDetalhe1			= false;
			    		$scope.tipoDetalhe2			= true;
			    		console.log("2 - "+$scope.tipoDetalhe2);
					}
					//console.log(contrato.idcontrato);
					//$scope.loadcontratositens(contrato.idcontrato);

					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/contrato/detalhes.html',
						controller: function( $scope, $modalInstance, contratoRS ){

							$scope.contrato = contratoRS;
							//busca os itens cadastrados neste contrato
							$http({
								method: 'POST',
								url: '/controller/contrato/contratoitens',
								data: { id: $scope.contrato.idcontrato } 
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
							//pega os empenhos do contrato
							$http({
								method: 'POST',
								url: '/controller/contrato/contratoempenhos',
								data: { id: $scope.contrato.idcontrato } 
							}).success(function(data){
								//console.log(data);
								$scope.itenscadastradosE = data;
								//$scope.calculaTotalGeralE();
								//$scope.currentPage = 1; //current page
								//$scope.entryLimit = 20; //max no of items to display in a page
								//$scope.filteredItems = $scope.itenscadastrados.length; //Initially for no filter
								$scope.totalItemsE = $scope.itenscadastradosE.length;
								$scope.totalgeralE 			= 0; 
								angular.forEach($scope.itenscadastradosE, function(item) {
									//console.log(item.total);
									$scope.totalgeralE += parseFloat(item.valor);
								});
  								//$scope.numPerPage = 20;
							});

							//pega os arquivos
							//$scope.loadarquivos($scope.contrato.idcontrato);
							$http({
								method: 'POST',
								url: '/controller/contrato/arquivos',
								data: { id: $scope.contrato.idcontrato } 
							}).success(function(data){
								$scope.arquivos = data;
								$scope.currentPage = 1; //current page
								$scope.entryLimit = 50; //max no of items to display in a page
								$scope.filteredItems = $scope.arquivos.length; //Initially for no filter
								$scope.totalItemsA = $scope.arquivos.length;
  								$scope.numPerPage = 50;
							});

							//pega a qtd de aditivos do contrato
							$http({
								method: 'POST',
								url: '/controller/contrato/getQTDAditivos',
								data: { id: $scope.contrato.idcontrato } 
							}).success(function(data){
								$scope.qtdAditivos = data.qtd;
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

				$scope.loadcontratositens = function(idcontrato){
					
					//$scope.contratoItens.idcontrato = idcontrato;
					$http({
						method: 'POST',
						url: '/controller/contrato/contratoitens',
						data: { id: idcontrato } 
					}).success(function(data){
						//console.log(data);
						$scope.itenscadastrados = data;
						$scope.calculaTotalGeral();
						//$scope.currentPage = 1; //current page
						//$scope.entryLimit = 20; //max no of items to display in a page
						//$scope.filteredItems = $scope.itenscadastrados.length; //Initially for no filter
						$scope.totalItemsD = $scope.itenscadastrados.length;
						console.log($scope.totalItemsD);
  						//$scope.numPerPage = 20;
					});
					//console.log("OI");
					

				};


				$scope.loadarquivos = function(idcontrato){
					
					$http({
						method: 'POST',
						url: '/controller/contrato/arquivos',
						data: { id: idcontrato } 
					}).success(function(data){
							$scope.arquivos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 50; //max no of items to display in a page
							$scope.filteredItems = $scope.arquivos.length; //Initially for no filter
							$scope.totalItemsA = $scope.arquivos.length;
  							$scope.numPerPage = 50;
					});
					

				};

				$scope.loadcontratosempenhos = function(idcontrato){
					
					//$scope.contratoItens.idcontrato = idcontrato;
					$http({
						method: 'POST',
						url: '/controller/contrato/contratoempenhos',
						data: { id: idcontrato } 
					}).success(function(data){
						//console.log(data);
						$scope.itenscadastradosE = data;
						$scope.calculaTotalGeralE();
						//$scope.currentPage = 1; //current page
						//$scope.entryLimit = 20; //max no of items to display in a page
						//$scope.filteredItems = $scope.itenscadastrados.length; //Initially for no filter
						$scope.totalItemsE = $scope.itenscadastradosE.length;
						console.log($scope.totalItemsE);
  						//$scope.numPerPage = 20;
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
				$scope.calculaTotalGeralE = function(){
					//for(var i = 0; i < $scope.itenscadastrados.length; i++){
					$scope.totalgeralE 			= 0; 
					angular.forEach($scope.itenscadastradosE, function(item) {
						//console.log(item.total);
						$scope.totalgeralE += parseFloat(item.valor);
					});
				}

				

				$scope.load = function(){
					
					$http.get('/controller/contrato/contratos')
						.success(function(data){
							$scope.contratos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.contratos.length; //Initially for no filter
							$scope.totalItems = $scope.contratos.length;
  							$scope.numPerPage = 5;
						});
					// angular.forEach($scope.contratos, function(item) {
					// 	$scope.totalgeral += parseFloat(item.total);
					// });
				};

				$scope.loadorgaos = function(){
					
					$http.get('/controller/contrato/orgaos')
						.success(function(data){
							$scope.orgaos = data;
						});

				};

				$scope.loadfornecedores = function(){
					
					$http.get('/controller/fornecedor/fornecedores')
						.success(function(data){
							$scope.fornecedores = data;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.contratos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						// $scope.contrato.dataassinaturatali = $scope.formataData($scope.contrato.dataassinaturatali);
						// $scope.contrato.validadeata = $scope.formataData($scope.contrato.validadeata);
						// $scope.contrato.datacompra = $scope.formataData($scope.contrato.datacompra);
						// $scope.contrato.validade = $scope.formataData($scope.contrato.validade);
						// $scope.contrato.dataassinatura = $scope.formataData($scope.contrato.dataassinatura);
						// console.log("DataAssinatura: "+$scope.contrato.dataassinatura);

						//via http
						$http.post('/controller/contrato/savecontrato', $scope.contrato )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/contrato');
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
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
						});

					}
				};

				$scope.formataData = function(data){
					var dataFormatada = "";
					if(data != null){
						dataFormatada = data.substring(4, 8).toString()+"-"+data.substring(2, 4).toString()+"-"+data.substring(0, 2).toString();
						console.log(dataFormatada);
						return dataFormatada;
					}else{
						return "0000-00-00";
					}
				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletecontrato' , {id: itemid});
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
	

	