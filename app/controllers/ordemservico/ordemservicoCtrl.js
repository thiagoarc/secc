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
			    $scope.totalprod			= 0; //set the default total itens products

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });

			    $scope.load = function(){
					
					$http.get('/controller/ordemservico/ordemservico')
						.success(function(data){
							$scope.ordem = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.ordem.length; //Initially for no filter
							$scope.totalItems = $scope.ordem.length;
  							$scope.numPerPage = 5;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.ordem.indexOf(value);
    				return (begin <= index && index < end);
  				};

  				/* salvar ordem de serviço */
				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						//via http
						$http.post('/controller/ordemservico/saveordemservico', {ordem: $scope.ordem, produtos: $scope.produtosca})
						.success(function(data){
							if( data.message == 'success' ){
								//saving set false
								$scope.submitting = false;
								//hide loading
								$scope.isloading = false;
								//success
								$location.path('/ordemservico');
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								//show message in 5 seconds
								$timeout(function(){
									appMessages.show = false;
								}, 5000);
							}
						})
						.error(function(error){
							console.log(error);
						});
					}
				};

				/* detahes da OS */
				$scope.detalhes = function(os){
					var modalInstance = $modal.open({
						templateUrl: 'views/ordemservico/detalhes.html',
						controller: function( $scope, $modalInstance, $http, osModal  ){

							$scope.ordem = osModal;
							$scope.isloadingmodal = true;
							$http.post('/controller/ordemservico/itensordemservico', {idos: $scope.ordem.idos})
							.success(function( data ){
								$scope.itensOSTotal = data.length;
								if( $scope.itensOSTotal == undefined )
									$scope.itensOSTotal = 0;
								$scope.itensOS = data[0];
								$scope.calcTotalValor = 0;
								for( var i = 0; i < data[0].item.length; i++){
									$scope.calcTotalValor += data[0].item[i].qtd * data[0].item[i].valorunitario;
								}
								$scope.isloadingmodal = false;
							});

							$scope.print = function( div ){
								$modalInstance.close( div );
							}

							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							osModal: function(){
								return os;
							}
						}
					});

					modalInstance.result.then(function ( div ) {
				      $scope.imprimir( div );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });
				}

				/* imprimir bloco */
				$scope.imprimir = function( divName ){
					var printContents = document.getElementById(divName).innerHTML;
				    var originalContents = document.body.innerHTML;      

				    if (navigator.userAgent.toLowerCase().indexOf('chrome') > -1) {
				        var popupWin = window.open('', '_blank', 'width=600,height=600,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
				        popupWin.window.focus();
				        popupWin.document.write('<!DOCTYPE html><html><head>' +
				            '<link rel="stylesheet" type="text/css" href="assets/css/oneui.css" />' +
				            '<style>body{padding:20px 30px}</style>' +
				            '</head><body onload="window.print()"><div class="reward-body">' + printContents + '</div></html>');
				        popupWin.onbeforeunload = function (event) {
				            popupWin.close();
				            return '.\n';
				        };
				        popupWin.onabort = function (event) {
				            popupWin.document.close();
				            popupWin.close();
				        }
				    } else {
				        var popupWin = window.open('', '_blank', 'width=800,height=600');
				        popupWin.document.open();
				        popupWin.document.write('<html><head><link rel="stylesheet" type="text/css" href="assets/css/oneui.css" /></head><body onload="window.print()">' + printContents + '</html>');
				        popupWin.document.close();
				    }
				    popupWin.document.close();

				    return true;
				}

				/* cancelamento da OS */
				$scope.cancelarOS = function(os){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/cancel.html',
				      	controller: function ($scope, $modalInstance, osModal) {
				      	
					      	$scope.ordem = osModal;
					      	$scope.modalItem =  'OS '+osModal.idos;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.ordem);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	osModal: function () {
				          		return os;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (unidade) {
				      $scope.deleteitem( unidade );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });
				}

				/* cancelar e deletar a ordem de serviço */
				$scope.deleteitem = function(item){
					$http.post('/controller/ordemservico/deleteordemservico', item )
						.success(function(data){
							if( data.message == 'success' ){
								//saving set false
								$scope.submitting = false;
								//hide loading
								$scope.isloading = false;
								//clear object
								$scope.ordem.splice( $scope.ordem.indexOf(item), 1 );
								// $location.path('/ordemservico');
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
								//show message in 5 seconds
								$timeout(function(){
									appMessages.show = false;
								}, 5000);
							}
						})
						.error(function(error){
							console.log(error);
						});
				}


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
						$scope.ordem.contratoaditivo = ibusca.contrato;
						$scope.ordem.tipo	= 2; //aditivo
					}else{
						$scope.ordem.contratoaditivo = ibusca.contrato;
						$scope.ordem.tipo	= 1; //contrato
					}

					/* carregar produtos do contrato ou aditivos */
					$scope.isloadingitens = true;
					$http.post('/controller/ordemservico/produtoscontratoaditivo', {numero: $scope.ordem.contratoaditivo})
					.success(function(data){
						$scope.isloadingitens = false;
						$scope.isprodutoscontratoaditivo = true;
						$scope.produtosca = data;
						$scope.totalprod = data.length;
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

			}
		]
	);
	

	