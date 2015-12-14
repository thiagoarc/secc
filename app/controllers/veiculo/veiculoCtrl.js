'use strict';

app
	.controller('veiculoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.veiculo 	    		= {};
				$scope.veiculos	    		= {};
				$scope.setores	    		= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'placa'; // set the default sort type
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


				var itemid = $routeParams.id || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/veiculo/getveiculo',
						data: { id: itemid } 
					}).success(function(data){
						$scope.veiculo = data;
					});
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(veiculodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, veiculos) {
				      	
					      	$scope.veiculo = veiculos;
					      	$scope.modalItem =  veiculos.placa;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.veiculo);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	veiculos: function () {
				          		return veiculodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (veiculo) {
				      $scope.deleteitem( veiculo.idveiculo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				//modal detahes
				$scope.detalhes = function(veiculo){
					var modalInstance = $modal.open({
						templateUrl: 'views/veiculo/detalhes.html',
						size: 'lg',
						controller: function( $scope, $modalInstance, veiculoRS ){

							$scope.veiculo = veiculoRS;
							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							veiculoRS: function(){
								return veiculo;
							}
						}
					});
				}

				$scope.load = function(){
					
					$http.get('/controller/veiculo/veiculos')
						.success(function(data){
							$scope.veiculos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.veiculos.length; //Initially for no filter
							$scope.totalItems = $scope.veiculos.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.veiculos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.loadsetores = function(){
					
					$http.get('/controller/veiculo/setores')
						.success(function(data){
							$scope.setores = data;
						});

				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/veiculo/saveveiculo', $scope.veiculo )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/veiculo');
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
					var itemunidademedida = $resource('/controller/veiculo/deleteveiculo' , {id: itemid});
					itemunidademedida.delete(
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
	

	