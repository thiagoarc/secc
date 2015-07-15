'use strict'; 

var app = angular.module('app', [
		    'ng',
			'ngResource',
			'ngRoute',
			'ui.bootstrap',
		    'oc.lazyLoad'
		  ]);


/* configuration and routs */
app.config( function($routeProvider, $locationProvider){

	$routeProvider
		.when('/', { templateUrl: 'template/aside.php',  title: 'Dasboard' })
		// .when('/produto', { templateUrl: 'views/produto/index.php', controller: 'produtoCtrl', title: 'Lista de Produto' })
		// .when('/produto/form', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Adicionar Produto' })
		// .when('/produto/form/:id', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Editar Produto' })
		
		.when('/produto',
			{ 
				templateUrl: 'views/produto/index.html',
				controller: 'produtoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/produto/produtoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/produto/add',
			{ 
				templateUrl: 'views/produto/formulario.html',
				controller: 'produtoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/produto/produtoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/produto/edit/:idproduto',
			{ 
				templateUrl: 'views/produto/formulario.html',
				controller: 'produtoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/produto/produtoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/unidademedida',
			{ 
				templateUrl: 'views/unidademedida/index.html',
				controller: 'unidadeMedidaCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/unidademedida/unidadeMedidaCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/unidademedida/add',
			{ 
				templateUrl: 'views/unidademedida/formulario.html',
				controller: 'unidadeMedidaCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/unidademedida/unidadeMedidaCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/unidademedida/edit/:id',
			{ 
				templateUrl: 'views/unidademedida/formulario.html',
				controller: 'unidadeMedidaCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/unidademedida/unidadeMedidaCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/fornecedor',
			{ 
				templateUrl: 'views/fornecedor/index.html',
				controller: 'fornecedorCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/fornecedor/fornecedorCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/fornecedor/add',
			{ 
				templateUrl: 'views/fornecedor/formulario.html',
				controller: 'fornecedorCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/fornecedor/fornecedorCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/fornecedor/edit/:id',
			{ 
				templateUrl: 'views/fornecedor/formulario.html',
				controller: 'fornecedorCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/fornecedor/fornecedor	Ctrl.js']
                    	});
					}]
				}
			}
		)
		.otherwise({ redirectTo: '/' });

	//remove the # in URLs
	// $locationProvider.html5Mode(true);	
 	$locationProvider.hashPrefix('!');

});

app.config(['$resourceProvider', function($resourceProvider) {
  // Don't strip trailing slashes from calculated URLs
  $resourceProvider.defaults.stripTrailingSlashes = false;
}]);


// var app = angular.module('app', [
// 		'ng',
// 		'ngResource',
// 		'ngRoute',
// 		'ui.bootstrap'
// 	]);

// //configuration and routs
// app.config(function($routeProvider, $locationProvider){

// 	$routeProvider
// 		.when('/', { templateUrl: 'template/aside.php',  title: 'Dasboard' })
// 		.when('/produto', { templateUrl: 'views/produto/index.php', controller: 'produtoCtrl', title: 'Lista de Produto' })
// 		.when('/produto/form', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Adicionar Produto' })
// 		.when('/produto/form/:id', { templateUrl: 'views/produto/form.php', controller: 'produtoCtrl', title: 'Editar Produto' })
// 		.otherwise({ redirectTo: '/' });

// 	//remove the # in URLs
// 	$locationProvider.html5Mode(true);	
//  $locationProvider.hashPrefix('!');

// });

// app.config(['$resourceProvider', function($resourceProvider) {
//   // Don't strip trailing slashes from calculated URLs
//   $resourceProvider.defaults.stripTrailingSlashes = false;
// }]);

//run
// app.run(function($rootScope, $route, applicationName){
// 	$rootScope.applicationName = applicationName;
// 	$rootScope.$on('$routeChangeSuccess', function (event, current, previous){
// 		$rootScope.title = $route.current.title;
// 	});
// });