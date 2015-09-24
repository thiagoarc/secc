'use strict';

app
	.controller('dashboardCtrl',
		['$scope', '$location', '$http', '$q',
			function($scope, $location, $http, $q){

				$scope.totalpurchases = 0;
				$scope.totalcontract = 0;
				$scope.totaladditions = 0;

				$scope.nivelestoqueprodutos = function(){
					$http.post('/controller/dashboard/nivelestoqueprodutos')
					.success(function(data){
						$scope.nivelproduto = data;
						$scope.totalnivelproduto = data.length;
					})
					.error(function(error){
						console.log(error);
					});
				}

				$scope.totalCompras = function(){
					var $promise = $http.post('/controller/dashboard/totalcompras');
					$promise.then(function(data) {
						$scope.totalpurchases = data.data[0].total;
					});
				}

				$scope.totalContratoAtivo = function(){
					var $promise = $http.post('/controller/dashboard/totalcontratos');
					$promise.then(function(data) {
						$scope.totalcontract = data.data[0].total;
					});
				}

				$scope.totalAditivosAtivo = function(){
					var $promise = $http.post('/controller/dashboard/totaladitivos');
					$promise.then(function(data) {
						$scope.totaladditions = data.data[0].total;
					});
				}

			}
		]
	);