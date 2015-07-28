'use strict';

app
	.controller('unidadeMedidaCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.unidademedida 	    = {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'sigla'; // set the default sort type
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
						url: '/controller/unidademedida/getunidademedida',
						data: { id: itemid } 
					}).success(function(data){
						$scope.unidademedida = data;
					});
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(unidademedidadelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, unidadesmedida) {
				      	
					      	$scope.unidademedida = unidadesmedida;
					      	$scope.modalItem =  unidadesmedida.sigla;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.unidademedida);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	unidadesmedida: function () {
				          		return unidademedidadelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (unidade) {
				      $scope.deleteitem( unidade.idunidade_medida );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				$scope.load = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidadesmedida = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.unidadesmedida.length; //Initially for no filter
							$scope.totalItems = $scope.unidadesmedida.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.unidadesmedida.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.loadunidademedidas = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidadesmedida = data;
						});

				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/unidademedida/saveunidademedida', $scope.unidademedida )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/unidademedida');
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
					var itemunidademedida = $resource('/controller/unidademedida/deleteunidademedida' , {id: itemid});
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
	

	