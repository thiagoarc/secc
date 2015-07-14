<!DOCTYPE html>

<html lang="pt-br" ng-app="app">

    <head>
    
        <meta charset="utf8">
        <base href="/">
        
        <!-- <title ng-bind="title | title"></title>         -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <link rel="stylesheet" href="lib/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    </head>

    <body>

        <div class="container">
            <div ng-view></div>
        </div>

        <!-- include script -->
        <script type="text/javascript" src="lib/jquery/jquery.js"></script>
        <script type="text/javascript">var $jQuery = jQuery.noConflict();</script>
        <script type="text/javascript" src="lib/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="lib/angular/angular.min.js"></script>
        <script type="text/javascript" src="lib/angular/angular-route.min.js"></script>
        <script type="text/javascript" src="lib/angular/angular-resource.min.js"></script>
        <script type="text/javascript" src="lib/ui-bootstrap/angular-ui-bootstrap.min.js"></script>
        <script type="text/javascript" src="app/app.js"></script>
        <script type="text/javascript" src="app/controllers/produto/produtoCtrl.js"></script>

    </body>

</html>