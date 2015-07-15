'use strict';

angular.module('ClientsApp')
       .controller('ClientsIndexCtrl',
        ['$scope',
         'Client',
         function ($scope, Client) {

             Client.query(function (data) {
                 $scope.clients = data.clients;
             });

         }]);
