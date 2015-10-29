'use strict';

app
	.controller('saidaCtrl', 
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
			    $scope.resultados 			= {};
				$scope.totalresultados		= 0;
				$scope.ibusca				= {};
				$scope.isloading 			= false;
				$scope.autocomplete			= false;
				$scope.totalItems			= 0;
				$scope.produtoed			= {};
				$scope.qtdestoque			= 0;

				$scope.produtossolicitacao	= [];

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    var itemid = $routeParams.idsaida || 0;

				console.log(itemid);

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/saida/produtossolicitacao',
						data: { idsaida: itemid } 
					}).success(function(data){
						console.log(data);
						$scope.produtossolicitacao = data;
						$scope.totalItemsP = $scope.produtossolicitacao.length;
					});

					//$scope.tipo = $scope.contrato.tipo;
				}

			    /* pesquisar numero de contrato e aditivo */
				$scope.searchcontratoaditivo = function( descricao ){
					if( descricao != undefined && descricao.length >= 3 ){
						$http.post('/controller/saida/checkprodutos', {nome: descricao})
						.success(function( data ){
							if( data && data.message != 'noresults' ){
								$scope.resultados = data;
								$scope.totalresultados = 1;
								$scope.autocomplete = true;
							}else if( data.message == 'noresults' ){
								$scope.resultados = null;
								$scope.totalresultados = 0;
							}else{
								$scope.autocomplete = false;
							}
						})
						.error(function(error){
							console.log(error);
						});
					}else{
						$scope.resultados = null;
						$scope.autocomplete = false;
					}
				}


				/* setar o item ao selecionar da busca */
				$scope.selectedcontratoaditivo = function( ibusca ){
					$scope.isproduto = true;
					$scope.ibusca = ibusca;
					$scope.produto = ibusca;
					$scope.nome = $scope.produto.descricao;
					$scope.qtdestoque = $scope.produto.qtdatual;
					$scope.autocomplete = false;
					$scope.resultados = null;
				}

				$scope.removeTagOnBackspace = function (event) {
    				if (event.keyCode === 8) {
        				//console.log('here!');
        				$scope.nome = "";
    				}
				};


				

				/* confirmação modal para excluir item */
				// $scope.deleteconfirm = function(contratodelete){
				// 	var modalInstance = $modal.open({
				//       	templateUrl: 'views/confirm.html',
				//       	controller: function ($scope, $modalInstance, contratos) {
				      	
				// 	      	$scope.contrato = contratos;
				// 	      	$scope.modalItem =  "de número de contrato: "+contratos.numerocontrato;
					      	
				// 	      	$scope.ok = function () {
				// 			    $modalInstance.close($scope.contrato);
				// 			};

				// 			$scope.cancel = function () {
				// 			    $modalInstance.dismiss('cancel');
				// 			};

				//       	},
				//       	resolve: {
				//         	contratos: function () {
				//           		return contratodelete;
				//         	}
				//       	}
				//   	});

				//   	modalInstance.result.then(function (contrato) {
				//       $scope.deleteitem( contrato.idcontrato );
				//     }, function () {
				//     	/* funcao ao cancelar ou fechar o modal */
				//     });

				// };


				//modal detahes
				$scope.detalhes = function(solicitacao){

					console.log(solicitacao);

					$scope.solicitacao = solicitacao;

					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/saida/detalhes.html',
						controller: function( $scope, $modalInstance, solicitacaoRS ){

							$scope.solicitacao = solicitacaoRS;

							$http({
								method: 'POST',
								url: '/controller/saida/produtossolicitacao',
								data: { idsaida: $scope.solicitacao.idsaida } 
							}).success(function(data){
								$scope.produtossolicitacao = data;
								$scope.totalItemsP = $scope.produtossolicitacao.length;
								//console.log($scope.totalItemsP);
							});

							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							solicitacaoRS: function(){
								return solicitacao;
							}
						}
					});
				}

				

				$scope.load = function(){
					
					$http.get('/controller/saida/solicitacoes')
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
						url: '/controller/saida/produtossolicitacao',
						data: { idsolicitacao: itemid } 
					}).success(function(data){
						$scope.produtossolicitacao = data;
						$scope.totalItemsP = $scope.produtossolicitacao.length;
						console.log($scope.totalItemsP);
					});
					
					// $http.get('/controller/solicitacaouser/produtossolicitacao')
					// 	.success(function(data){
					// 		$scope.solicitacoes = data;
					// 		console.log($scope.solicitacoes);
					// 		$scope.currentPage = 1; //current page
					// 		$scope.entryLimit = 5; //max no of items to display in a page
					// 		$scope.filteredItems = $scope.solicitacoes.length; //Initially for no filter
					// 		$scope.totalItems = $scope.solicitacoes.length;
  			// 				$scope.numPerPage = 5;
					// 	});

				};


				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.solicitacoes.indexOf(value);
    				return (begin <= index && index < end);
  				};

  				$scope.additem = function(){
  					var ver = true;
  					angular.forEach($scope.produtossolicitacao, function(value, key){
         				if(value.nome == $scope.nome){
         					alert("Este produto já existe na lista de produtos.");
         					ver = false;
         					return false;
         				}	
         			});
  					if(ver){
  						if(parseInt($scope.produto.qtd) <= parseInt($scope.qtdestoque)){
	         				$scope.produtossolicitacao.push({
	      						id: $scope.produto.idproduto,
	      						nome: $scope.nome,
	      						qtd: $scope.produto.qtd,
	      						qtdestoque: $scope.qtdestoque
	    					});
	    					appMessages.addMessage("Material adicionado com sucesso.", true, 'success');
	    				}else{
	    					appMessages.addMessage("A quantidade solicitada não existe no estoque. No estoque existe apenas "+$scope.qtdestoque, true, 'danger');
	    				}
  					}
  					$timeout(function(){
						appMessages.show = false;
					}, 5000);
					$scope.totalItemsP = $scope.produtossolicitacao.length;
  					console.log($scope.totalItemsP);
  					$scope.nome = "";
    				$scope.produto = {};

    				console.log($scope.produtossolicitacao);
         				
  				}


  				$scope.removeRow = function(name){				
					var index = -1;		
					var comArr = eval( $scope.produtossolicitacao );
					for( var i = 0; i < comArr.length; i++ ) {
						if( comArr[i].nome === name ) {
							index = i;
							break;
						}
					}
					if( index === -1 ) {
						alert( "Something gone wrong" );
					}
					$scope.produtossolicitacao.splice( index, 1 );	
					$scope.totalItemsP = $scope.produtossolicitacao.length;	
				};


				$scope.retirarMaterial = function(){
					//if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/saida/savesolicitacao', $scope.produtossolicitacao )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/saida');
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

					//}
				};



			}
		]
	);
	

	