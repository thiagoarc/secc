'use strict';

app
	.controller('solicitacaoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.solicitacao 			= {};
				$scope.solicitacoes 		= [];
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
				$scope.isloading 			= false;
				$scope.totalItems			= 0;
				$scope.motivo				= '';

				$scope.produtossolicitacao	= [];

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    var itemid = $routeParams.idsolicitacao || 0;

				//console.log(itemid);

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/solicitacao/produtossolicitacao',
						data: { idsolicitacao: itemid } 
					}).success(function(data){
						//console.log(data);
						$scope.produtossolicitacao = data;
						$scope.totalItemsP = $scope.produtossolicitacao.length;
					});

					// var $promise = $http.post('/controller/dashboard/totaladitivos', { idsolicitacao: itemid });
					// $promise.then(function(data) {
					// 	$scope.solicitacao = data;
					// });

					$http({
						method: 'POST',
						url: '/controller/solicitacao/getsolicitacao',
						data: { idsolicitacao: itemid } 
					}).success(function(data){
						console.log(data);
						//$scope.solicitacao = data[0];
					});				

				}

				$scope.loadsolicitacao = function(){
					$http({
						method: 'POST',
						url: '/controller/solicitacao/getsolicitacao',
						data: { idsolicitacao: itemid } 
					}).success(function(data){
						console.log(data[0].datasolicitacao);
						$scope.solicitacao = data[0];
					});	
				}

			   
				//modal detahes
				$scope.detalhes = function(solicitacao){

					//console.log(solicitacao);

					$location.path('/solicitacao/detalhes/'+solicitacao.idsolicitacao);

					$scope.solicitacao = solicitacao;

				}


				$scope.deferir = function(produto){
					$http({
						method: 'POST',
						url: '/controller/solicitacao/deferirsolicitacao',
						data: { idsolicitacao: itemid, idproduto: produto.idproduto, qtd: produto.qtd } 
					}).success(function(data){
						//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/solicitacao/detalhes/'+produto.idsolicitacao);
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								$scope.loadprodutossolicitacao(itemid);
							}else {
								appMessages.addMessage(data.msg_success, true, 'danger');
							}
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
					});
				}

				$scope.indeferir = function(produto, motivo){
					$http({
						method: 'POST',
						url: '/controller/solicitacao/indeferirsolicitacao',
						data: { idsolicitacao: itemid, idproduto: produto.idproduto, motivo: motivo } 
					}).success(function(data){
						//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/solicitacao/detalhes/'+produto.idsolicitacao);
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								$scope.loadprodutossolicitacao(itemid);
							}else {
								appMessages.addMessage(data.msg_success, true, 'danger');
							}
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
					});
				}

				/* confirmação modal para excluir item */
				$scope.deferirconfirm = function(produtodeferir){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/solicitacaoconfirm.html',
				      	controller: function ($scope, $modalInstance, produtos) {
				      	
					      	$scope.produto = produtos;
					      	$scope.modalItem =  "Deseja realmente deferir a solicitação do produto: "+produtos.produto+"?";
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.produto);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	produtos: function () {
				          		return produtodeferir;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (unidade) {
				      $scope.deferir( unidade );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				/* confirmação modal para excluir item */
				$scope.indeferirconfirm = function(produtodeferir){
					var $motivo = '';
					var modalInstance = $modal.open({
				      	templateUrl: 'views/solicitacaoindeferirconfirm.html',
				      	controller: function ($scope, $modalInstance, produtos) {
				      	
					      	$scope.produto = produtos;
					      	$scope.modalItem =  "Deseja realmente indeferir a solicitação do produto: "+produtos.produto+"?";
					      	
					      	$scope.ok = function (motivo) {
					      		//console.log(motivo);
					      		$motivo = motivo;
							    $modalInstance.close($scope.produto);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	produtos: function () {
				          		return produtodeferir;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (unidade) {
				  		console.log($motivo);
				      $scope.indeferir( unidade, $motivo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};
				

				$scope.load = function(){
					
					$http.get('/controller/solicitacao/solicitacoes')
						.success(function(data){
							$scope.solicitacoes = data;
							console.log($scope.solicitacoes);
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.solicitacoes.length; //Initially for no filter
							$scope.totalItems = $scope.solicitacoes.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.loadprodutossolicitacao = function(itemid){

					$http({
						method: 'POST',
						url: '/controller/solicitacao/produtossolicitacao',
						data: { idsolicitacao: itemid } 
					}).success(function(data){
						$scope.produtossolicitacao = data;
						$scope.totalItemsP = $scope.produtossolicitacao.length;
						//console.log($scope.totalItemsP);
					});
					

				};


				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.solicitacoes.indexOf(value);
    				return (begin <= index && index < end);
  				};

  				$scope.finalizar = function(){

					$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/solicitacao/finalizarsolicitacao', {id: itemid} )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							//show message
							if(data.msg == 'success'){
								//show message
								$location.path('/solicitacao');
								appMessages.addMessage(data.msg_success, true, 'success');
								$scope.load();
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

			}
		]
	);
	

	