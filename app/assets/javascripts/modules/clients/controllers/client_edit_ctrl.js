'use strict';

angular.module('ClientsApp')
  .controller('ClientEditCtrl',
  ['$scope',
   '$routeParams',
   'Client',
   function ($scope, $routeParams, Client) {

    Client.get({id: $routeParams['id']}, function (client) {
      $scope.client = client;
    });

    $scope.saveClient = function () {
      Client.update($scope.client, function (client) {
        $location.path('/clients/'+client.id);
      });
    };

  }]);
