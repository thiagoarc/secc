'use strict';

app
	.controller('aditivoArquivosCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages', 'FileUploader',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages, FileUploader) {

				$scope.aditivo 				= {};
				$scope.arquivo 				= {};
				$scope.arquivos 			= [];
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.totalgeral 			= 0;
			    $scope.modalItem			= '';


			    $scope.handleClick = function(msg) {
			        appMessages.addMessage(msg);
			    };			        
			    $scope.$on('handleBroadcast', function() {
			        $scope.message = $scope.notification.msg;
			        // console.log( 'Mensagem do scope: '+ $scope.message );
			    });


				var itemid = $routeParams.idaditivo || 0;

				if( itemid && itemid > 0){
					//via http
					$http({
						method: 'POST',
						url: '/controller/contrato/getaditivo',
						data: { id: itemid } 
					}).success(function(data){
						$scope.aditivo = data;
					});
				}


				//FILE UPLOAD

			    var uploader = $scope.uploader = new FileUploader({
            		url: '/upload/uploadarquivosaditivo.php?idaditivo='+itemid
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
            		console.log("Sucesso: "+fileItem.name);
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
					appMessages.addMessage("O(s) arquivo(s) foram enviados com sucesso.", true, 'success');
					$scope.load();
					//show message in 5 seconds
					$timeout(function(){
						appMessages.show = false;
					}, 5000);
        			uploader.clearQueue();
            		//console.info('onCompleteAll');
        		};
        		uploader.onCancelAll = function(fileItem, response, status, headers) {
            		console.info('onCancelAll', fileItem, response, status, headers);
        		};

        		console.info('uploader', uploader);

			    //FIM FILE UPLOAD

				

				$scope.load = function(){
					
					$http({
						method: 'POST',
						url: '/controller/contrato/arquivosaditivo',
						data: { id: itemid } 
					}).success(function(data){
							$scope.arquivos = data;
							$scope.currentPage = 1; //current page
							$scope.entryLimit = 50; //max no of items to display in a page
							$scope.filteredItems = $scope.arquivos.length; //Initially for no filter
							$scope.totalItems = $scope.arquivos.length;
  							$scope.numPerPage = 50;
					});
				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.arquivos.indexOf(value);
    				return (begin <= index && index < end);
  				};


				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(arquivodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, arquivos) {
				      	
					      	$scope.arquivo = arquivos;
					      	$scope.modalItem =  arquivos.nome;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.arquivo);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	arquivos: function () {
				          		return arquivodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (arquivo) {
				      $scope.deleteitem( arquivo.idarquivos_aditivo );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};


				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletearquivoaditivo' , {id: itemid});
					itemcontrato.delete(
						function(data){
							//success
							$scope.load();
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
							}else if(data.msg == 'error1'){
								appMessages.addMessage(data.msg_success, true, 'danger');
							}else if(data.msg == 'error2'){
								appMessages.addMessage(data.msg_success, true, 'danger');
							}else{
								appMessages.addMessage(data.msg_success, true, 'danger');
							}
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);
						},
						function(error){
							console.log(error);
						}
					);
				};

			}
		]
	);
	

	