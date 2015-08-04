'use strict'; 

var app = angular.module('app', [
		    'ng',
			'ngResource',
			'ngRoute',
			'ui.bootstrap',
		    'oc.lazyLoad',
		    'ui.utils.masks',
		    'idf.br-filters'
		  ]);


/* configuration and routs */
app.config( function($routeProvider, $locationProvider){

	$routeProvider
		// .when('/produto', { templateUrl: 'views/produto/index.php', controller: 'produtoCtrl', title: 'Lista de Produto' })
		.when('/', 
			{ 
				templateUrl: 'views/login.html',
				title: 'authentication',
				controller: 'authenticationCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/app/authenticationCtrl.js', 'app/services/authentication.js', 'app/services/authenticationsession.js']
                    	});
					}]
				}
			}
		)

		.when('/login', 
			{ 
				templateUrl: 'views/login.html',
				title: 'authentication',
				controller: 'authenticationCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/app/authenticationCtrl.js', 'app/services/authentication.js', 'app/services/authenticationsession.js']
                    	});
					}]
				}
			}
		)

		.when('/app', 
			{ 
				templateUrl: 'views/app.html',  
				title: 'application' 
			}
		)
		
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

		.when('/fornecedor/edit/:idfornecedor',
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

		.when('/usuario',
			{ 
				templateUrl: 'views/usuario/index.html',
				controller: 'usuarioCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/usuario/usuarioCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/usuario/add',
			{ 
				templateUrl: 'views/usuario/formulario.html',
				controller: 'usuarioCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/usuario/usuarioCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/usuario/edit/:id',
			{ 
				templateUrl: 'views/usuario/formulario.html',
				controller: 'usuarioCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/usuario/usuarioCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/404', { templateUrl: '404.html',  title: 'error application' })
		.otherwise({ redirectTo: '/404' });

	//remove the # in URLs
	// $locationProvider.html5Mode(true);	
 	$locationProvider.hashPrefix('!');

});

app.config(['$resourceProvider', function($resourceProvider) {
  // Don't strip trailing slashes from calculated URLs
  $resourceProvider.defaults.stripTrailingSlashes = false;
}]);


app.directive('messageList', function(){
	return {
		restrict: 'E',
		scope: false,
		templateUrl: 'views/messages.html'
	}
}); 

/* directive template */
app.directive('mdSide', function(){
	return {
		restrict: 'E',
		scope: true,
		templateUrl: 'template/aside.html'
	}
});

app.directive('mdSidebar', function(){
	return {
		restrict: 'E',
		scope: true,
		templateUrl: 'template/sidebar.html'
	}
});

app.directive('mdHeader', function(){
	return {
		restrict: 'E',
		scope: true,
		templateUrl: 'template/header.html'
	}
});

app.directive('mdFooter', function(){
	return {
		restrict: 'E',
		scope: true,
		templateUrl: 'template/footer.html'
	}
});

//run
// app.run(function($rootScope, $route, applicationName){
// 	$rootScope.applicationName = applicationName;
// 	$rootScope.$on('$routeChangeSuccess', function (event, current, previous){
// 		$rootScope.title = $route.current.title;
// 	});
// });