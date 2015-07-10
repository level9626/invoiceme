'use strict';

angular.module('ClientsApp')
    .controller('ClientsIndexCtrl',
        ['$scope',
         '$sce',
         'Client',
         function ($scope, $sce, Client) {

             Client.query(function (data, client) {
                 $scope.clients = data.clients;

                 $scope.client = client;
                 $scope.client.address = $sce.trustAsHtml(client.address);
             });

         }]);
