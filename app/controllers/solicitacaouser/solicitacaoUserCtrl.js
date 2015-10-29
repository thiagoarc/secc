'use strict';

app
	.controller('solicitacaoUserCtrl', 
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
				$scope.hoje					= (new Date()).getDate();

				$scope.produtossolicitacao	= [];

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    var itemid = $routeParams.idsolicitacao || 0;

				console.log(itemid);

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/solicitacaouser/produtossolicitacao',
						data: { idsolicitacao: itemid } 
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
						$http.post('/controller/entrada/checkprodutos', {nome: descricao})
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

				/* pesquisar numero de contrato e aditivo */
				$scope.searchcontratoaditivoed = function( descricao ){
					if( descricao != undefined && descricao.length >= 3 ){
						$http.post('/controller/entrada/checkprodutos', {nome: descricao})
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
					$scope.autocomplete = false;
					$scope.resultados = null;
				}

				/* setar o item ao selecionar da busca */
				$scope.selectedcontratoaditivoed = function( ibusca ){
					$scope.isproduto = true;
					$scope.ibusca = ibusca;
					$scope.produto = ibusca;
					$scope.produto.idsolicitacao = itemid;
					$scope.nome = $scope.produto.descricao;
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

					

					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/solicitacaouser/detalhes.html',
						controller: function( $scope, $modalInstance, solicitacaoRS ){

							$scope.solicitacao = solicitacaoRS;

							$http({
								method: 'POST',
								url: '/controller/solicitacaouser/produtossolicitacao',
								data: { idsolicitacao: $scope.solicitacao.idsolicitacao } 
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
					
					$http.get('/controller/solicitacaouser/solicitacoes')
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
						url: '/controller/solicitacaouser/produtossolicitacao',
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
         				$scope.produtossolicitacao.push({
      						id: $scope.produto.idproduto,
      						nome: $scope.nome,
      						qtd: $scope.produto.qtd
    					});
  					}
					$scope.totalItemsP = $scope.produtossolicitacao.length;
  					console.log($scope.totalItemsP);
  					$scope.nome = "";
    				$scope.produto = {};

    				console.log($scope.produtossolicitacao);
         				
  				}

  				$scope.addeditem = function(){

  					var ver = true;
  					angular.forEach($scope.produtossolicitacao, function(value, key){
         				if(value.produto == $scope.nome){
         					alert("Este produto já existe na lista de produtos.");
         					ver = false;
         					return false;
         				}	
         			});
  					if(ver){
  					//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/solicitacaouser/saveprodutossolicitacao', $scope.produto )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							//$location.path('/solicitacaouser/edit/'+itemid);
							//show message
							if(data.msg == 'success'){
								//show message
								//appMessages.addMessage(data.msg_success, true, 'success');
								$scope.loadprodutossolicitacao($scope.produto.idsolicitacao);
								$scope.nome = "";
    							$scope.produto = {};
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

				$scope.removeRowEd = function(id){				
					var itemcontrato = $resource('/controller/solicitacaouser/deleteprodutosolicitacao' , {id: id});
					itemcontrato.delete(
						function(data){
							//success
							$scope.load();
							if(data.msg == 'success'){
								//show message
								//appMessages.addMessage(data.msg_success, true, 'success');
								$scope.loadprodutossolicitacao(itemid);
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
					$scope.totalItemsP = $scope.produtossolicitacao.length;
				};

				$scope.enviarSolicitacao = function(){
					//if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/solicitacaouser/savesolicitacao', $scope.produtossolicitacao )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/solicitacaouser');
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

				$scope.enviarSolicitacaoAlteracao = function(){
					//success
					$location.path('/solicitacaouser');
					//show message
					appMessages.addMessage("Solicitação alterada com sucesso!", true, 'success');
					//show message in 5 seconds
					$timeout(function(){
						appMessages.show = false;
					}, 5000);
				};

				// $scope.formataData = function(data){
				// 	var dataFormatada = "";
				// 	if(data != null){
				// 		dataFormatada = data.substring(4, 8).toString()+"-"+data.substring(2, 4).toString()+"-"+data.substring(0, 2).toString();
				// 		console.log(dataFormatada);
				// 		return dataFormatada;
				// 	}else{
				// 		return "0000-00-00";
				// 	}
				// };

				$scope.cancelar = function(itemid){

					$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/solicitacaouser/cancelarsolicitacao', {id: itemid} )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/solicitacaouser');
							//show message
							if(data.msg == 'success'){
								//show message
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
	

	