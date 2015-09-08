'use strict';

app
	.controller('contratoCtrl', 
		['$scope', '$timeout', '$resource', '$routeParams', '$location', '$modal', '$http', 'appMessages',  
			function($scope, $timeout, $resource, $routeParams, $location, $modal, $http, appMessages) {

				$scope.contrato 			= {};
				$scope.isloading 			= false;
				$scope.sortType     		= 'tipo'; // set the default sort type
			  	$scope.sortReverse  		= false;  // set the default sort order
			  	$scope.searchItem   		= '';     // set the default search/filter term
			  	$scope.submitting 			= false;	// set label btn for false then save
			    $scope.notification 		= appMessages; // factory notification feedback application
			    $scope.modalItem			= '';
			    $scope.tipoDetalhe1			= false;
			    $scope.tipoDetalhe2			= false;

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

				/* confirmação modal para excluir item */
				$scope.deleteconfirm = function(contratodelete){
					var modalInstance = $modal.open({
				      	templateUrl: 'views/confirm.html',
				      	controller: function ($scope, $modalInstance, contratos) {
				      	
					      	$scope.contrato = contratos;
					      	$scope.modalItem =  "de número de contrato: "+contratos.numerocontrato;
					      	
					      	$scope.ok = function () {
							    $modalInstance.close($scope.contrato);
							};

							$scope.cancel = function () {
							    $modalInstance.dismiss('cancel');
							};

				      	},
				      	resolve: {
				        	contratos: function () {
				          		return contratodelete;
				        	}
				      	}
				  	});

				  	modalInstance.result.then(function (contrato) {
				      $scope.deleteitem( contrato.idcontrato );
				    }, function () {
				    	/* funcao ao cancelar ou fechar o modal */
				    });

				};

				//modal detahes
				$scope.detalhes = function(contrato){
					if(contrato.tipo == 1 || contrato.tipo == 2){
						$scope.tipoDetalhe1			= true;
			    		$scope.tipoDetalhe2			= false;
			    		console.log("1 - "+$scope.tipoDetalhe1);
					}else{
						$scope.tipoDetalhe1			= false;
			    		$scope.tipoDetalhe2			= true;
			    		console.log("2 - "+$scope.tipoDetalhe2);
					}

					var modalInstance = $modal.open({
						size: 'lg',
						templateUrl: 'views/contrato/detalhes.html',
						controller: function( $scope, $modalInstance, contratoRS ){

							$scope.contrato = contratoRS;
							$scope.cancel = function(){
								$modalInstance.dismiss('cancel');
							}

						},
						resolve: {
							contratoRS: function(){
								return contrato;
							}
						}
					});
				}

				

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

				};

				$scope.loadorgaos = function(){
					
					$http.get('/controller/contrato/orgaos')
						.success(function(data){
							$scope.orgaos = data;
						});

				};

				$scope.loadfornecedores = function(){
					
					$http.get('/controller/fornecedor/fornecedores')
						.success(function(data){
							$scope.fornecedores = data;
						});

				};

				$scope.paginate = function(value) {
    				var begin, end, index;
    				begin = ($scope.currentPage - 1) * $scope.numPerPage;
    				end = begin + $scope.numPerPage;
    				index = $scope.contratos.indexOf(value);
    				return (begin <= index && index < end);
  				};

				$scope.saveitem = function(){
					if($scope.createForm.$valid){
						//saving set true
						$scope.submitting = true;
						//show loading
						$scope.isloading = true;
						$scope.contrato.dataassinaturatali = $scope.formataData($scope.contrato.dataassinaturatali);
						$scope.contrato.validadeata = $scope.formataData($scope.contrato.validadeata);
						$scope.contrato.datacompra = $scope.formataData($scope.contrato.datacompra);
						$scope.contrato.validade = $scope.formataData($scope.contrato.validade);
						$scope.contrato.dataassinatura = $scope.formataData($scope.contrato.dataassinatura);

						//via http
						$http.post('/controller/contrato/savecontrato', $scope.contrato )
						.success(function(data){
							//saving set false
							$scope.submitting = false;
							//hide loading
							$scope.isloading = false;
							//success
							$location.path('/contrato');
							//show message
							if(data.msg == 'success'){
								//show message
								appMessages.addMessage(data.msg_success, true, 'success');
							}else{
								appMessages.addMessage(data.msg_success, true, 'danger');
							}
							//show message in 5 seconds
							$timeout(function(){
								appMessages.show = false;
							}, 5000);

						})
						.error(function(error){
							console.log(error);
						});

					}
				};

				$scope.formataData = function(data){
					if(data != null){
						var dataFormatada = data.substring(4, 8)+"-"+data.substring(3, 4)+"-"+data.substring(1, 2);
						alert(dataFormatada);
						return dataFormatada;
					}else{
						return "0000-00-00";
					}
				};

				$scope.deleteitem = function(itemid){
					var itemcontrato = $resource('/controller/contrato/deletecontrato' , {id: itemid});
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


				/////////////////////////
				//scopos do datapicker
				/*$scope.today = function() {
    $scope.dt = new Date();
  };
  $scope.today();

  $scope.clear = function () {
    $scope.dt = null;
  };

  // Disable weekend selection
  $scope.disabled = function(date, mode) {
    return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
  };

  $scope.toggleMin = function() {
    $scope.minDate = $scope.minDate ? null : new Date();
  };
  $scope.toggleMin();

  $scope.open = function($event) {
    $scope.status.opened = true;
  };

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1
  };

  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
  $scope.format = $scope.formats[0];

  $scope.status = {
    opened: false
  };

  var tomorrow = new Date();
  tomorrow.setDate(tomorrow.getDate() + 1);
  var afterTomorrow = new Date();
  afterTomorrow.setDate(tomorrow.getDate() + 2);
  $scope.events =
    [
      {
        date: tomorrow,
        status: 'full'
      },
      {
        date: afterTomorrow,
        status: 'partially'
      }
    ];

  $scope.getDayClass = function(date, mode) {
    if (mode === 'day') {
      var dayToCheck = new Date(date).setHours(0,0,0,0);

      for (var i=0;i<$scope.events.length;i++){
        var currentDay = new Date($scope.events[i].date).setHours(0,0,0,0);

        if (dayToCheck === currentDay) {
          return $scope.events[i].status;
        }
      }
    }

    return '';
  };*/
				////////////////////////


			}
		]
	);
	

	