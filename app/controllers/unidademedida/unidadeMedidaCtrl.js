'use strict';

app
	.controller('unidadeMedidaCtrl', 
		['$scope', '$resource', '$routeParams', '$location', '$modal', '$http', 
			function($scope, $resource, $routeParams, $location, $modal, $http) {
				
				$scope.unidademedida 				= {};
				$scope.isloading 			= false;
				$scope.feedback				= false;
				$scope.feedbackMessage		= {};
				$scope.sortType     		= 'nome'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term

			  	$scope.submitting = false;	// set label btn for false then save

				var itemid = $routeParams.id;

				if( itemid && itemid > 0){
					// via resource
					// var itemp = $resource('php/produto/getproduto.php', {id: itemid});
					// $scope.produto = itemp.get();

					//via http
					$http({
						method: 'POST',
						url: '/controller/unidademedida/getUnidadeMedida',
						data: { id: itemid } 
					}).success(function(data){
						$scope.unidademedida = data;
					});
				}

				$scope.load = function(){
					// var listaproduto = $resource('php/produto/produtos.php'); 
					// $scope.produtos  = listaproduto.query();
					
					$http.get('/controller/unidademedida/allUnidadesMedida')
						.success(function(data){
							$scope.unidademedidas = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.unidademedidas.length; //Initially for no filter
							$scope.totalItems = $scope.unidademedidas.length;
						});

				};

				$scope.saveitem = function(){
					// var itemproduto = $resource('php/produto/saveproduto.php');
					if($scope.createForm.$valid){

						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/unidademedida/saveUnidadeMedida', $scope.unidademedida )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/unidademedida');
							//show message
							$scope.feedback = true;
							// $scope.feedbackType = 'success';
							// $scope.feedbackIcon = 'glyphicon glyphicon-ok';
							$scope.feedbackMessage = {msg : data.msg_success};

						})
						.error(function(error){
							console.log(error);
						});

					}
				};

				$scope.deleteitem = function(itemid){
					var itemunidademedida = $resource('/controller/unidademedida/deleteUnidadeMedida' , {id: itemid});
					itemunidademedida.delete(
						function(data){
							console.log(data.msg_success);
							//success
							$scope.load();
						},
						function(error){
							console.log(error);
						}
					);
				};

			}
		]
	);