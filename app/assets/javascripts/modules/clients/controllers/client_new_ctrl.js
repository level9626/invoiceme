'use strict';

angular.module('ClientsApp')
  .controller('ClientNewCtrl',
  ['$scope',
   '$location',
   'Client',
   function ($scope, $location, Client) {

    $scope.saveClient = function () {
      Client.save($scope.client, function (client) {
        $location.path('/clients/'+client.id);
      });
    };

  }]);
