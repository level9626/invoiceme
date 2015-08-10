'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',
  ['$scope',
   '$mdDialog',
   'Client',
   'Invoice',
   function ($scope, $mdDialog, Client, Invoice) {

    _init();

    $scope.destoryClient = function (client_id) {
      Client.remove({id: client_id});
      _init();
    };

    $scope.newClient = function (ev) {
      $mdDialog.show({
        controller: ClientNewCtrl,
        templateUrl: 'clients/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    $scope.editClient = function (ev, id) {
      $mdDialog.show({
        controller: ClientEditCtrl,
        templateUrl: 'clients/edit.html',
        targetEvent: ev,
        locals: {
          id: id
        }
      }).then(function(answer) {
        _init();
      });
    };

    $scope.removeClient = function (id) {
      Client.remove({id: id});
      _init();
    };

    function _init() {
      Client.query(function (data) {
        $scope.clients = data.clients;
      });

      Invoice.states(function (states) {
        $scope.states = states
      })
    }
  }]);
