'use strict';

angular.module('ClientsApp')
    .controller('ClientsIndexCtrl',
        ['$scope',
         '$sce',
         'Client',
         function ($scope, $sce, Client) {

             Client.query(function (data) {
                 $scope.clients = data.clients;
             });

         }]);
