
// angular.module('app', [
// 		'ui.router',
// 		'oc.lazyLoad'
// 	])
// 	.config(
// 		['$stateProvider', '$urlRouterProvider', 
// 			function( $stateProvider, $urlRouterProvider ){
// 				$urlRouterProvider
// 					.otherwise('/');
// 				$stateProvider
// 					.state('categoria', {
// 						url: '/categories',
// 						templateUrl: 'views/categories/list.html',
// 						resolve: {
// 							myLoadService: ['$ocLazyLoad', function($ocLazyLoad){
// 								return $ocLazyLoad.load(
// 									'app/controllers/categories/categoriesCtrl.js'	
// 								);
// 							}]
// 						}
// 					}
// 				);
// 			}
// 		]
// 	);

'use strict';

angular.module('app')
  .run(
    [           '$rootScope', '$state', '$stateParams',
      function ( $rootScope,   $state,   $stateParams ) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
      }
    ]
  )
  .config(
    [          '$stateProvider', '$urlRouterProvider', 'MODULE_CONFIG',
      function ( $stateProvider,   $urlRouterProvider,  MODULE_CONFIG ) {
        $urlRouterProvider
          	.otherwise('/app');
        $stateProvider
	        .state('app', {
	          url: '/categoria',
	          templateUrl: 'views/categories/list.html',
	          data : { title: 'Dashboard' },
	          controller: 'TodoCtrl',
	          resolve: load(['app/controllers/categories/categoriesCtrl.js'])
	        });


          function load(srcs, callback) {
            return {
                deps: ['$ocLazyLoad', '$q',
                  function( $ocLazyLoad, $q ){
                    var deferred = $q.defer();
                    var promise  = false;
                    srcs = angular.isArray(srcs) ? srcs : srcs.split(/\s+/);
                    if(!promise){
                      promise = deferred.promise;
                    }
                    angular.forEach(srcs, function(src) {
                      promise = promise.then( function(){
                        angular.forEach(MODULE_CONFIG, function(module) {
                          if( module.name == src){
                            if(!module.module){
                              name = module.files;
                            }else{
                              name = module.name;
                            }
                          }else{
                            name = src;
                          }
                        });
                        return $ocLazyLoad.load(name);
                      } );
                    });
                    deferred.resolve();
                    return callback ? promise.then(function(){ return callback(); }) : promise;
                }]
            }
          }
      }
    ]
  );
