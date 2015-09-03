'use strict';

app
	.controller('contratoItensCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contratoItens 		= {};
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
						url: '/controller/contrato/contratoitens',
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

				$scope.loadunidademedida = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidadesmedida = data;
						});

				};

				$scope.calculaTotalGeral = function(){
					//for(var i = 0; i < $scope.itenscadastrados.length; i++){
					angular.forEach($scope.itenscadastrados, function(item) {
						console.log(item.total);
						$scope.totalgeral += parseFloat(item.total);
					});
				}


				$scope.additens = function(){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/contrato/savecontratoitens', $scope.contratoItens )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							//$location.path('/contrato');
							$scope.loadcontratositens($scope.contratoItens.idcontrato);
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								$scope.contratoItens 				= {};
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
				$scope.deleteconfirm = function(contratoItensdelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratoItenss) {
				      	
					      	$scope.contratoItens = contratoItenss;
					      	$scope.modalItem =  contratoItenss.descricao;
					      	
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
				      $scope.deleteitem( contratoItens.iditens_contrato );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletecontratoitens' , {id: itemid});
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
	

	