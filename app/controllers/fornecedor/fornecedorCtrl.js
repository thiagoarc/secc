'use strict';

app
	.controller('fornecedorCtrl', 
		['$scope', '$resource', '$routeParams', '$location', '$modal', '$http', 
			function($scope, $resource, $routeParams, $location, $modal, $http) {
				
				$scope.fornecedor 				= {};
				$scope.isloading 			= false;
				$scope.feedback				= false;
				$scope.feedbackMessage		= {};
				$scope.sortType     		= 'nome'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	

			  	$scope.submitting = false;	// set label btn for false then save

				var itemid = $routeParams.idproduto;

				if( itemid && itemid > 0){
					// via resource
					// var itemp = $resource('php/produto/getproduto.php', {id: itemid});
					// $scope.produto = itemp.get();

					//via http
					$http({
						method: 'POST',
						url: '/controller/fornecedor/getfornecedor',
						data: { id: itemid } 
					}).success(function(data){
						$scope.fornecedor = data;
					});
				}

				$scope.load = function(){
					// var listaproduto = $resource('php/produto/produtos.php'); 
					// $scope.produtos  = listaproduto.query();
					
					$http.get('/controller/fornecedor/fornecedores')
						.success(function(data){
							$scope.fornecedores = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.fornecedores.length; //Initially for no filter
							$scope.totalItems = $scope.fornecedores.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.fornecedores.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.saveitem = function(){
					// var itemproduto = $resource('php/produto/saveproduto.php');
					if($scope.createForm.$valid){

						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/fornecedor/savefornecedor', $scope.fornecedor )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/produto');
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
					var itemfornecedor = $resource('/controller/fornecedor/deletefornecedor' , {id: itemid});
					itemfornecedor.delete(
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