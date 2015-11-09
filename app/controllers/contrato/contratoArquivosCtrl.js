'use strict';

app
	.controller('contratoArquivosCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages', 'FileUploader',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages, FileUploader) {

				$scope.contrato 			= {};
				$scope.contratos 			= [];
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.totalgeral 			= 0;


			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				var itemid = $routeParams.idcontrato || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getcontrato',
						data: { id: itemid } 
					}).success(function(data){
						$scope.contrato = data;
					});

					$scope.tipo = $scope.contrato.tipo;
				}


				//FILE UPLOAD

			    var uploader = $scope.uploader = new FileUploader({
            		url: '/controller/contrato/uploadarquivoscontrato.php?idcontrato='+itemid
        		});

        		// FILTERS
        		uploader.filters.push({
            		name: 'customFilter',
            		fn: function(item /*{File|FileLikeObject}*/, options) {
                		return this.queue.length < 10;
            		}
        		});

        		// CALLBACKS

        		uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
            		console.info('onWhenAddingFileFailed', item, filter, options);
        		};
        		uploader.onAfterAddingFile = function(fileItem) {
            		console.info('onAfterAddingFile', fileItem);
        		};
        		uploader.onAfterAddingAll = function(addedFileItems) {
            		console.info('onAfterAddingAll', addedFileItems);
        		};
        		uploader.onBeforeUploadItem = function(item) {
            		console.info('onBeforeUploadItem', item);
        		};
        		uploader.onProgressItem = function(fileItem, progress) {
            		console.info('onProgressItem', fileItem, progress);
        		};
        		uploader.onProgressAll = function(progress) {
            		console.info('onProgressAll', progress);
        		};
        		uploader.onSuccessItem = function(fileItem, response, status, headers) {
            		console.info('onSuccessItem', fileItem, response, status, headers);
        		};
        		uploader.onErrorItem = function(fileItem, response, status, headers) {
            		console.info('onErrorItem', fileItem, response, status, headers);
        		};
        		uploader.onCancelItem = function(fileItem, response, status, headers) {
            		console.info('onCancelItem', fileItem, response, status, headers);
        		};
        		uploader.onCompleteItem = function(fileItem, response, status, headers) {
            		console.info('onCompleteItem', fileItem, response, status, headers);
        		};
        		uploader.onCompleteAll = function() {
            		console.info('onCompleteAll');
        		};
        		uploader.onCancelAll = function(fileItem, response, status, headers) {
            		console.info('onCancelAll', fileItem, response, status, headers);
        		};

        		console.info('uploader', uploader);

			    //FIM FILE UPLOAD

				

				$scope.load = function(){
					
					$http.get('/controller/contrato/contratos')
						.success(function(data){
							$scope.contratos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 5; //max no of items to display in a page
							$scope.filteredItems = $scope.contratos.length; //Initially for no filter
							$scope.totalItems = $scope.contratos.length;
  							$scope.numPerPage = 5;
						});
					// angular.forEach($scope.contratos, function(item) {
					// 	$scope.totalgeral += parseFloat(item.total);
					// });
				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.contratos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				// $scope.saveitem = function(){
				// 	if($scope.createForm.$valid){
				// 		//saving set true
				// 		$scope.submitting = true;
				// 		//show loading
				// 		$scope.isloading = true;
				// 		// $scope.contrato.dataassinaturatali = $scope.formataData($scope.contrato.dataassinaturatali);
				// 		// $scope.contrato.validadeata = $scope.formataData($scope.contrato.validadeata);
				// 		// $scope.contrato.datacompra = $scope.formataData($scope.contrato.datacompra);
				// 		// $scope.contrato.validade = $scope.formataData($scope.contrato.validade);
				// 		// $scope.contrato.dataassinatura = $scope.formataData($scope.contrato.dataassinatura);
				// 		// console.log("DataAssinatura: "+$scope.contrato.dataassinatura);

				// 		//via http
				// 		$http.post('/controller/contrato/savecontrato', $scope.contrato )
				// 		.success(function(data){
				// 			//saving set false
				// 			$scope.submitting = false;
				// 			//hide loading
				// 			$scope.isloading = false;
				// 			//success
				// 			$location.path('/contrato');
				// 			//show message
				// 			if(data.msg == 'success'){
				// 				//show message
				// 				appMessages.addMessage(data.msg_success, true, 'success');
				// 			}else{
				// 				appMessages.addMessage(data.msg_success, true, 'danger');
				// 			}
				// 			//show message in 5 seconds
				// 			$timeout(function(){
				// 				appMessages.show = false;
				// 			}, 5000);

				// 		})
				// 		.error(function(error){
				// 			console.log(error);
				// 			$scope.submitting = false;
				// 			//hide loading
				// 			$scope.isloading = false;
				// 		});

				// 	}
				// };


				// $scope.deleteitem = function(itemid){
				// 	var itemcontrato = $resource('/controller/contrato/deletecontrato' , {id: itemid});
				// 	itemcontrato.delete(
				// 		function(data){
				// 			//success
				// 			$scope.load();
				// 			if(data.msg == 'success'){
				// 				//show message
				// 				appMessages.addMessage(data.msg_success, true, 'success');
				// 			}else if(data.msg == 'error1'){
				// 				appMessages.addMessage(data.msg_success, true, 'danger');
				// 			}else if(data.msg == 'error2'){
				// 				appMessages.addMessage(data.msg_success, true, 'danger');
				// 			}else{
				// 				appMessages.addMessage(data.msg_success, true, 'danger');
				// 			}
				// 			//show message in 5 seconds
				// 			$timeout(function(){
				// 				appMessages.show = false;
				// 			}, 5000);
				// 		},
				// 		function(error){
				// 			console.log(error);
				// 		}
				// 	);
				// };

			}
		]
	);
	

	