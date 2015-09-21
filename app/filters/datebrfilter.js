'use strict';

app
  .filter('datebr', function($filter) {
    return function(input) {
      if (input == null) {
        return "";
      }

      var day = input.substring(0, 2);
      var month = input.substring(2, 4);
      var year = input.substring(4, 9);

      var _date = $filter('date')(new Date(year, (month - 1), day), 'dd/MM/yyyy');
      return _date.toUpperCase();
    };
  });
