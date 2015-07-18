'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',
  ['$scope',
   'Client',
   function ($scope, Client) {

    _init();

    $scope.destoryClient = function (client_id) {
      Client.remove({id: client_id});
      _init();
    }

    function _init() {
      Client.query(function (data) {
        $scope.clients = data.clients;
      });
    }

  }]);
