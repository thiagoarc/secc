'use strict';

app
	.controller('relatorioCtrl', 
		['$scope', '$http', 'appMessages', '$timeout',
			function($scope, $http, appMessages, $timeout) {

				$scope.contratoativos 		= [];
				$scope.contratoproximovencimento 		= [];
				$scope.contratovencidos 	= [];
				$scope.aditivoativo 		= [];
				$scope.aditivoproximovencimento 		= [];
				$scope.aditivovencidos 		= [];
				$scope.osinicio				= undefined;
				$scope.osfinal				= undefined;
				$scope.ordemservico			= [];
				$scope.produtoestoque		= [];
				$scope.produtoestoqueminimo		= [];
				$scope.isloading 			= false;
				$scope.sortType     		= 'nome'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application

			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			    });

				$scope.getContratoAtivos = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getcontratoativos'
					}).success(function(data){
						$scope.contratoativos = data;
					});
				};

				$scope.getContratoProximoVencimento = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getcontratoproximovencimento'
					}).success(function(data){
						$scope.contratoproximovencimento = data;
					});
				};

				$scope.getContratoVencidos = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getcontratovencidos'
					}).success(function(data){
						$scope.contratovencidos = data;
					});
				};

				$scope.getAditivoAtivo = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getaditivoativos'
					}).success(function(data){
						$scope.aditivoativo = data;
					});
				};

				$scope.getAditivoProximoVencimento = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getaditivoproximovencimento'
					}).success(function(data){
						$scope.aditivoproximovencimento = data;
					});
				};

				$scope.getAditivoVencidos = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getaditivovencidos'
					}).success(function(data){
						$scope.aditivovencidos = data;
					});
				};

				$scope.getOrdemServico = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getordemservico'
					}).success(function(data){
						$scope.ordemservico = data;
					});
				};

				$scope.actOrdemServico = function(){
					if( $scope.osinicio != undefined && $scope.osfinal != undefined ){
						//via http
						$http({
							method: 'POST',
							url: '/controller/relatorio/getordemservico',
							data: { osinicio: $scope.osinicio, osfinal: $scope.osfinal }
						}).success(function(data){
							$scope.ordemservico = [];
							$scope.ordemservico = data;
						});
					}else{
						//show message
						appMessages.addMessage('Favor informe uma data válida para efetuar o filtro', true, 'info');
						//show message in 5 seconds
						$timeout(function(){
							appMessages.show = false;
						}, 3000);
					}
				};

				$scope.getProdutoEstoque = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getprodutoestoque'
					}).success(function(data){
						$scope.produtoestoque = data;
					});
				};

				$scope.getProdutoEstoqueMinimo = function(){
					//via http
					$http({
						method: 'POST',
						url: '/controller/relatorio/getprodutoestoqueminimo'
					}).success(function(data){
						$scope.produtoestoqueminimo = data;
					});
				};

				/* imprimir bloco */
				$scope.imprimir = function( divName ){
					var printContents = document.getElementById(divName).innerHTML;
				    var originalContents = document.body.innerHTML;      

				    if (navigator.userAgent.toLowerCase().indexOf('chrome') > -1) {
				        var popupWin = window.open('', '_blank', 'width=600,height=600,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
				        popupWin.window.focus();
				        popupWin.document.write('<!DOCTYPE html><html><head>' +
				            '<link rel="stylesheet" type="text/css" href="assets/css/oneui.css" />' +
				            '<style>body{padding:20px 30px}.hidden{display:block !important}</style>' +
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
				};


			}
		]
	);
	

	