'use strict';

app
	.factory('sessionSrv', ['$http', function( $http ){
		return {
			
			set: function(key, value){
				return sessionStorage.setItem(key, value);
			},

			get: function(key){
				return sessionStorage.getItem(key);
			},

			destroy: function(key){
				//vamos chamar o http para destruir a session
				$http.post('/controller/authentication/logout');
				return sessionStorage.remove(key);
			}

		};
	}]);