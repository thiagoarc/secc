'use strict';

app
	.controller('ordemservicoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.ordem 				= {};
				$scope.resultados 			= {};
				$scope.totalresultados		= 0;
				$scope.ibusca				= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'nome'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.autocomplete			= false; // set the autocomplete false;
			    $scope.produtosca			= {}; //set the default product in contract or additions

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				// var itemid = $routeParams.id || 0;

				// if( itemid && itemid > 0){
				// 	//via http
				// 	$http({
				// 		method: 'POST',
				// 		url: '/controller/usuario/getusuario',
				// 		data: { id: itemid } 
				// 	}).success(function(data){
				// 		$scope.usuario = data;
				// 	});
				// }

				// /* confirmação modal para excluir item */
				// $scope.deleteconfirm = function(usuariodelete){
				// 	var modalInstance = $modal.open({
				//       	templateUrl: 'views/confirm.html',
				//       	controller: function ($scope, $modalInstance, usuarios) {
				      	
				// 	      	$scope.usuario 		= usuarios;
				// 	      	$scope.modalItem 	= usuarios.nome;
					      	
				// 	      	$scope.ok = function () {
				// 			    $modalInstance.close($scope.usuario);
				// 			};

				// 			$scope.cancel = function () {
				// 			    $modalInstance.dismiss('cancel');
				// 			};

				//       	},
				//       	resolve: {
				//         	usuarios: function () {
				//           		return usuariodelete;
				//         	}
				//       	}
				//   	});

				//   	modalInstance.result.then(function (usuario) {
				//       $scope.deleteitem( usuario.idusuario );
				//     }, function () {
				//     	/* funcao ao cancelar ou fechar o modal */
				//     });

				// };

				/* pesquisar numero de contrato e aditivo */
				$scope.searchcontratoaditivo = function( numero ){
					if( numero != undefined && numero.length >= 3 ){
						$scope.iscontratoaditivo = false;
						$scope.isprodutoscontratoaditivo = false;
						$http.post('/controller/ordemservico/checkcontratoaditivo', {numero: numero})
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
					$scope.ibusca = ibusca;
					$scope.autocomplete = false;
					$scope.resultados = null;
					$scope.iscontratoaditivo = true;
					/* exibir dados do contrato */
					$scope.ordem.numero = ibusca.contrato;
					$scope.ordem.valor = ibusca.valor;
					$scope.ordem.validade = ibusca.validade;
					$scope.ordem.obs = ibusca.obs;
					if( ibusca.idaditivo ){
						$scope.ordem.contratoaditivo = ibusca.idaditivo;
					}else{
						$scope.ordem.contratoaditivo = ibusca.idcontrato;
					}

					/* carregar produtos do contrato ou aditivos */
					$scope.isloadingitens = true;
					$http.post('/controller/ordemservico/produtoscontratoaditivo', {numero: $scope.ordem.contratoaditivo})
					.success(function(data){
						$scope.isloadingitens = false;
						$scope.isprodutoscontratoaditivo = true;
						$scope.produtosca = data;
					})
					.error(function(error){
						$scope.isloadingitens = false;
						$scope.isprodutoscontratoaditivo = false;
						console.log(error);
					});
				}

				/* verificar a quantidade solicitada para apontar se o campo é obrigatório ou não  */
				$scope.checkshowmessage = function( qtddisponivel, qtdordem ){
					if ( parseInt(qtddisponivel) < parseInt(qtdordem) ){
						$scope.createForm.$invalid = true;
						return true;
					}else{
						return false;
					}
				}
				$scope.checkrequiredprod = function( qtddisponivel, qtdordem ){
					if ( parseInt(qtddisponivel) < parseInt(qtdordem) )
						$scope.createForm.$valid = false;
				}

				$scope.load = function(){
					
					$http.get('/controller/usuario/usuarios')
						.success(function(data){
							$scope.usuarios = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.usuarios.length; //Initially for no filter
							$scope.totalItems = $scope.usuarios.length;
  							$scope.numPerPage = 10;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.usuarios.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.loadunidademedidas = function(){
					
					$http.get('/controller/unidademedida/unidadesmedida')
						.success(function(data){
							$scope.unidademedidas = data;
						});

				};

				$scope.saveitem = function(){
					console.log($scope.ordem);
					console.log($scope.produtosca);
				};

				$scope.deleteitem = function(itemid){
					var itemusuario = $resource('/controller/usuario/deleteusuario' , {id: itemid});
					itemusuario.delete(
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
	

	