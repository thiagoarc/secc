'use strict';

app
	.controller('entradaCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.produto 				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'nome'; // set the default sort type
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


				var itemid = $routeParams.idproduto || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/produto/getproduto',
						data: { id: itemid } 
					}).success(function(data){
						$scope.produto = data;
					});
				}

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(produtodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, produtos) {
				      	
					      	$scope.produto = produtos;
					      	$scope.modalItem =  produtos.nome;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.produto);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	produtos: function () {
				          		return produtodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (unidade) {
				      $scope.deleteitem( unidade.idproduto );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				//modal detahes
				$scope.detalhes = function(produto){
					var modalInstance = $modal.open({
						templateUrl: 'views/produto/detalhes.html',
						controller: function( $scope, $modalInstance, produtoRS ){

							$scope.produto = produtoRS;
							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							produtoRS: function(){
								return produto;
							}
						}
					});
				}

				/*$scope.load = function(){
					
					$http.get('/controller/produto/produtos')
						.success(function(data){
							$scope.produtos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.produtos.length; //Initially for no filter
							$scope.totalItems = $scope.produtos.length;
  							$scope.numPerPage = 5;
						});

				};*/

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.produtos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.loadunidademedidas = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidademedidas = data;
						});

				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/produto/saveproduto', $scope.produto )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/produto');
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
					var itemproduto = $resource('/controller/produto/deleteproduto' , {id: itemid});
					itemproduto.delete(
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
	

	