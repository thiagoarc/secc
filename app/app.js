'use strict'; 

var app = angular.module('app', [
		'ng',
		'ngResource',
		'ngRoute',
		'ui.bootstrap'
	]);

//configuration and routs
app.config(function($routeProvider, $locationProvider){

	$routeProvider
		.when('/', { templateUrl: 'template/aside.php',  title: 'Dasboard' })
		.when('/produto', { templateUrl: 'views/produto/index.php', controller: 'produtoCtrl', title: 'Lista de Produto' })
		.when('/produto/form', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Adicionar Produto' })
		.when('/produto/form/:id', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Editar Produto' })
		.otherwise({ redirectTo: '/' });

	//remove the # in URLs
	$locationProvider.html5Mode(true);	

});

app.config(['$resourceProvider', function($resourceProvider) {
  // Don't strip trailing slashes from calculated URLs
  $resourceProvider.defaults.stripTrailingSlashes = false;
}]);

//run
// app.run(function($rootScope, $route, applicationName){
// 	$rootScope.applicationName = applicationName;
// 	$rootScope.$on('$routeChangeSuccess', function (event, current, previous){
// 		$rootScope.title = $route.current.title;
// 	});
// });