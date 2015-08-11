'use strict';

app
	.controller('contratoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contrato 				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				var itemid = $routeParams.idcompra || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: itemid } 
					}).success(function(data){
						$scope.contrato = data;
					});
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(contratodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratos) {
				      	
					      	$scope.contrato = contratos;
					      	$scope.modalItem =  contratos.tipo;
					      	
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
				      $scope.deleteitem( contrato.idcompra );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				//modal detahes
				$scope.detalhes = function(fornecedor){
					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/contrato/detalhes.html',
						controller: function( $scope, $modalInstance, contratoRS ){

							$scope.contrato = contratoRS;
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
					
					$http.get('/controller/contrato/contratos')
						.success(function(data){
							$scope.contratos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.contratos.length; //Initially for no filter
							$scope.totalItems = $scope.contratos.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.loadorgaos = function(){
					
					$http.get('/controller/contrato/orgaos')
						.success(function(data){
							$scope.orgaos = data;
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
						});

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
	

	