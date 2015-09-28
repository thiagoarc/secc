'use strict'; 

var app = angular.module('app', [
		    'ng',
			'ngResource',
			'ngRoute',
			'ui.bootstrap',
		    'oc.lazyLoad',
		    'ui.utils.masks',
		    'ui.mask',
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
                        	files: ['app/controllers/app/authenticationCtrl.js']
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
                        	files: ['app/controllers/app/authenticationCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/app', 
			{ 
				templateUrl: 'views/app.html',  
				title: 'application',
				controller: 'dashboardCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/app/dashboardCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/entrada',
			{ 
				templateUrl: 'views/entrada/index.html',
				controller: 'entradaCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/entrada/entradaCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/solicitacaouser',
			{ 
				templateUrl: 'views/solicitacaouser/index.html',
				controller: 'solicitacaoUserCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/solicitacaouser/solicitacaoUserCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/solicitacaouser/add',
			{ 
				templateUrl: 'views/solicitacaouser/formulario.html',
				controller: 'solicitacaoUserCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/solicitacaouser/solicitacaoUserCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/solicitacaouser/edit/:idsolicitacao',
			{ 
				templateUrl: 'views/solicitacaouser/formularioed.html',
				controller: 'solicitacaoUserCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/solicitacaouser/solicitacaoUserCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/solicitacaouser/detalhes/:idsolicitacao',
			{ 
				templateUrl: 'views/solicitacaouser/detalhes.html',
				controller: 'solicitacaoUserCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/solicitacaouser/solicitacaoUserCtrl.js']
                    	});
					}]
				}
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

		.when('/contrato',
			{ 
				templateUrl: 'views/contrato/index.html',
				controller: 'contratoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/add',
			{ 
				templateUrl: 'views/contrato/formulario.html',
				controller: 'contratoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/edit/:idcontrato',
			{ 
				templateUrl: 'views/contrato/formulario.html',
				controller: 'contratoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/fornecedor/:idcontrato',
			{ 
				templateUrl: 'views/contrato/fornecedor.html',
				controller: 'contratoFornecedorCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoFornecedorCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/aditivos/:idcontrato',
			{ 
				templateUrl: 'views/contrato/aditivos.html',
				controller: 'contratoAditivoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoAditivoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/aditivo/add/:newcontrato',
			{ 
				templateUrl: 'views/contrato/formularioaditivo.html',
				controller: 'contratoAditivoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoAditivoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/aditivo/edit/:idaditivo',
			{ 
				templateUrl: 'views/contrato/formularioaditivo.html',
				controller: 'contratoAditivoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoAditivoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/aditivo/itens/:idaditivo',
			{ 
				templateUrl: 'views/contrato/itensaditivo.html',
				controller: 'contratoItensAditivoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoItensAditivoCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/contrato/itens/:idcontrato',
			{ 
				templateUrl: 'views/contrato/itens.html',
				controller: 'contratoItensCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/contrato/contratoItensCtrl.js']
                    	});
					}]
				}
			}
		)

		.when('/os/',
			{ 
				templateUrl: 'views/ordemservico/index.html',
				controller: 'ordemservicoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/ordemservico/ordemservicoCtrl.js']
                    	});
					}]
				}
			}
		)
		
		.when('/os/add',
			{ 
				templateUrl: 'views/ordemservico/formulario.html',
				controller: 'ordemservicoCtrl',
				resolve: {
					lazyTestCtrl: ['$ocLazyLoad', function($ocLazyLoad){
						return $ocLazyLoad.load({
                        	name: 'app', /*name module(YourModuleApp)*/
                        	files: ['app/controllers/ordemservico/ordemservicoCtrl.js']
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

//run application
app.run(function($rootScope, $location, authenticationSrv){
	$rootScope.rolespermission = [];
	
	$rootScope.$on('$routeChangeStart', function (event, next, current){

		var $getrolespermission = authenticationSrv.rolesPermission();
		// $getrolespermission.then(function(data){
		// 	for( var i = 0; i < data.data.length; i++ ) {
		// 		$rootScope.rolespermission.push(data.data[i].roles);
		// 	}
		// 	// console.log( $rootScope.rolespermission.indexOf( $location.path() ) );
		// 	if( $rootScope.rolespermission.indexOf( $location.path() ) == -1 ){
		// 		var connectedsessionLogin = authenticationSrv.isLogged();
		// 		connectedsessionLogin.then(function(data){
		// 			if( data.data = 'notauthentified' ){
		// 				$location.path('/login');
		// 			}
		// 		});
		// 	}
		// });

	});
});