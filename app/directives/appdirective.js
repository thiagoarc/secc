'use strict'

app.directive('navsubmenu', function(){
	return {
		link: function(scope, elem, attrs){
			elem.on("click", function(){
	            // Get link's parent
	            var $lHtml              = jQuery('html');
	            var $parentLi = jQuery(elem);
	            if ($parentLi.hasClass('open')) { // If submenu is open, close it..
	                $parentLi.removeClass('open');
	            } else { // .. else if submenu is closed, close all other (same level) submenus first before open it
	                $parentLi
	                    .closest('ul')
	                    .find('> li')
	                    .removeClass('open');
	                $parentLi
	                    .addClass('open');
	            }
	            // Remove focus from submenu link
	            if ($lHtml.hasClass('no-focus')) {
	                $parentLi.blur();
	            }
			});
		}
	}
});