'use strict';

app
	.controller('authenticationCtrl',
		['$scope', 'authenticationSrv', 'sessionSrv', '$location', '$modal', '$http', '$timeout',
			function($scope , authenticationSrv, sessionSrv, $location, $modal, $http, $timeout){

				$scope.msgErrorAuthentication 	= false;
				$scope.msgcredentials 			= '';
				$scope.usuarioLogin 			= {};
				$scope.isloading 				= false;
				$scope.submitting 				= false;

				if( $location.path() == '/' || $location.path() == '/login' ){
					/* aplication background body */
					jQuery('body').addClass('bg-image');
	        		jQuery('body').css('background-image', 'url("/assets/img/photos/photo1@2x.jpg")');
				}else{
					var $lHtml              = jQuery('html');
			        var $lBody              = jQuery('body');
			        var $lPage              = jQuery('#page-container');
			        var $lSidebar           = jQuery('#sidebar');
			        var $lSidebarScroll     = jQuery('#sidebar-scroll');
			        var $lSideOverlay       = jQuery('#side-overlay');
			        var $lSideOverlayScroll = jQuery('#side-overlay-scroll');
			        var $lHeader            = jQuery('#header-navbar');
			        var $lMain              = jQuery('#main-container');
			        var $lFooter            = jQuery('#page-footer');

					// Initialize Tooltips
			        jQuery('[data-toggle="tooltip"], .js-tooltip').tooltip({
			            container: 'body',
			            animation: false
			        });

			        // Initialize Popovers
			        jQuery('[data-toggle="popover"], .js-popover').popover({
			            container: 'body',
			            animation: true,
			            trigger: 'hover'
			        });

			        // Initialize Tabs
			        jQuery('[data-toggle="tabs"] a, .js-tabs a').click(function(e){
			            e.preventDefault();
			            jQuery(this).tab('show');
			        });

			        // Init form placeholder (for IE9)
			        jQuery('.form-control').placeholder();

					/* enable menu */
					jQuery('[data-toggle="nav-submenu"]').on('click', function(e){
			            // Stop default behaviour
			            e.stopPropagation();
			            // Get link
			            var $link = jQuery(this);
			            // Get link's parent
			            var $parentLi = $link.parent('li');
			            if ($parentLi.hasClass('open')) { // If submenu is open, close it..
			                $parentLi.removeClass('open');
			            } else { // .. else if submenu is closed, close all other (same level) submenus first before open it
			                $link
			                    .closest('ul')
			                    .find('> li')
			                    .removeClass('open');
			                $parentLi
			                    .addClass('open');
			            }
			            // Remove focus from submenu link
			            if ($lHtml.hasClass('no-focus')) {
			                $link.blur();
			            }
			        });
			        /* enable menu mobile */
			        // Call layout API on button click
			        jQuery('[data-toggle="layout"]').on('click', function(){
			        	var $btn = jQuery(this);
			            var $windowW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

			            if ($windowW > 991) {
		                    $lPage.toggleClass('sidebar-o');
		                } else {
		                    $lPage.toggleClass('sidebar-o-xs');
		                }

			            if ($lHtml.hasClass('no-focus')) {
			                $btn.blur();
			            }
			        });

				}

				$scope.login = function( data ){
					authenticationSrv.login( data, $scope );
				}

				$scope.logout = function(){
					authenticationSrv.logout();
				}

				$scope.redefinirsenha = function(){
					var modalInstance = $modal.open({
						templateUrl: 'views/usuario/redefinirsenha-logado.html',
						controller: function( $scope, $modalInstance, $http, $timeout){

							$scope.usuario 						= {};
							$scope.notificationModal			= {}; /* modal notification */
						    $scope.notificationModal.typeAlert 	= 'success';
						    $scope.notificationModal.show 		= false;
						    $scope.notificationModal.msg 		= '';
						    $scope.isloading 					= false;

							$scope.ok = function(){
								if( $scope.RedifinePasswordForm.$valid ){	
									$scope.isloading 	= true;
									/* verification password current */
									$http.post('/controller/usuario/redefinirsenha-logado', $scope.usuario)
									.success(function( data ){
										/* verification result */
										if( data.message == 'success' ){
											/* message */
											$scope.notificationModal.typeAlert 	= 'success';
										    $scope.notificationModal.show 		= true;
										    $scope.notificationModal.msg 		= 'Senha alterada com sucesso.';
										    /* show message in 5 seconds */
											$timeout(function(){
												$scope.notificationModal.show = false;
												$modalInstance.close( $scope.usuario );
											}, 2500);
											/* clear form */
											$scope.usuario.senha 			= '';
											$scope.usuario.confirmasenha 	= '';
										}
										/* disabled loading and submitting after check password current */
										$scope.isloading 	= false;
									})
									.error(function( error ){
										console.log( error );
									});
									
								}
							}

							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						}
					}); 
				};

			}
		]
	);