'use strict'; 
app.factory('appMessages', function($rootScope){

	var notification = {};
	notification.msg = '';
	notification.show = false;
	notification.type = 'success' || 'danger';

	notification.addMessage = function( message, show, type ){
		this.msg 	= message;
		this.show	= show;
		this.type 	= type;
		// console.log( 'mensagem: ' + message );
		this.broadcastItem();
	}

	notification.broadcastItem = function(){
		$rootScope.$broadcast('handleBroadcast');
	}

	return notification;

});