'use strict';

angular.module('ClientsApp')
  .controller('ClientShowCtrl',
  ['$scope',
   '$routeParams',
   '$location',
   'Client',
   function ($scope, $routeParams, $location, Client) {

    Client.get({id: $routeParams['id']}, function (client) {
      $scope.client = client;
    });

    $scope.destoryClient = function (client_id) {
      Client.remove({id: client_id});
      $location.path('/clients')
    }

  }]);

