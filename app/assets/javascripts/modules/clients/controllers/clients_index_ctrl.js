'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',
  ['$scope',
   '$location',
   'Client',
   function ($scope, $location, Client) {

    Client.query(function (data) {
      $scope.clients = data.clients;
    });

    $scope.destoryClient = function (client_id) {
      Client.remove({id: client_id});
       $location.path('/clients')
    }

  }]);
