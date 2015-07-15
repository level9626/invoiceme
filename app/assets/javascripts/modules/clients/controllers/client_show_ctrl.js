'use strict';

angular.module('ClientsApp')
       .controller('ClientsShowCtrl',
        ['$scope',
         '$routeParams',
         'Client',
             function ($scope, $routeParams, Client) {

                 Client.get({id: $routeParams['id']}, function (client) {
                     $scope.client = client;
                 });

         }]);
