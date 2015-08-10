'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',[
   '$scope',
   '$location',
   '$mdDialog',
   'Client',
   'Invoice',
   function ($scope, $location, $mdDialog, Client, Invoice) {

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
      Client.query($location.search(), function (data) {
        $scope.clients = data.clients;
      });

      // All clients for filters
      // $location.search() will contain Object {q[name_eq]: "HP"}
      // or an empty Object {}
      // If it is containing an empty object, it means, that we don't need
      // to do a separate call, in order to get all clients of the user.
      if(!_.isEmpty($location.search())){
        Client.query(function (data) {
          $scope.all_clients = data.clients;
        });
      }

      Invoice.states(function (states) {
        $scope.states = states
      })
    }
  }]);
