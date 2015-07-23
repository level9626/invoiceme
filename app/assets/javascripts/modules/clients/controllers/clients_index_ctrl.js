'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',
  ['$scope',
   'Client',
   function ($scope, Client) {

    _ini();

    $scope.destoryClient = function (client_id) {
      Client.remove({id: client_id});
      _ini();
    }

    function _ini(){
      Client.query(function (data) {
        $scope.clients = data.clients;
      });
    }

  }]);
