'use strict';

app
	.controller('contratoFornecedorCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contratoFornecedor 				= {};
				$scope.contrato 				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.fornecedorescadastrados = [];

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    $scope.loadcontratosfornecedores = function(idcontrato){
					
					$scope.contratoFornecedor.idcontrato = idcontrato;
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontratofornecedor',
						data: { id: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.fornecedorescadastrados = data;
						$scope.currentPage = 1; //current page
						$scope.entryLimit = 20; //max no of items to display in a page
						$scope.filteredItems = $scope.fornecedorescadastrados.length; //Initially for no filter
						$scope.totalItems = $scope.fornecedorescadastrados.length;
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
					$scope.loadcontratosfornecedores(itemid);
				}

				

				
				$scope.loadfornecedores = function(){
					
					$http.get('/controller/fornecedor/fornecedores')
						.success(function(data){
							$scope.fornecedores = data;
						});

				};

				$scope.addfornecedor = function(){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/contrato/savecontratofornecedor', $scope.contratoFornecedor )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							//$location.path('/contrato');
							$scope.loadcontratosfornecedores($scope.contratoFornecedor.idcontrato);
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
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
				$scope.deleteconfirm = function(contratoFornecedordelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratoFornecedors) {
				      	
					      	$scope.contratoFornecedor = contratoFornecedors;
					      	$scope.modalItem =  contratoFornecedors.razaosocial;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.contratoFornecedor);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	contratoFornecedors: function () {
				          		return contratoFornecedordelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (contratoFornecedor) {
				      $scope.deleteitem( contratoFornecedor.idfornecedor_contrato );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletecontratofornecedor' , {id: itemid});
					itemcontrato.delete(
						function(data){
							//success
							$scope.loadcontratosfornecedores(itemid);
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
	

	