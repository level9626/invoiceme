'use strict';

angular.module('ClientsApp')
  .controller('ClientsIndexCtrl',[
  '$scope',
  '$location',
  '$mdDialog',
  'Client',
  'Invoice',
  function ($scope, $location, $mdDialog, Client, Invoice) {

    $scope.data = {};
    $scope.methods = {};

    _init();

    $scope.methods.new_client = function (ev) {
      $mdDialog.show({
        controller: ClientNewCtrl,
        templateUrl: 'clients/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    $scope.methods.edit_client = function (ev, id) {
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

    $scope.methods.remove_client = function (id) {
      Client.remove({id: id}, function () {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Client successfully removed.'
        });
      });
      _init();
    };

    function _init() {

      Client.query($location.search(), function (data) {
        $scope.data.clients = data.clients;
        $scope.data.pagination = data.pagination
        _get_colors ();
      });

      // All clients for filters
      // $location.search() will contain Object {q[name_eq]: "HP"}
      // or an empty Object {}
      // If it is containing an empty object, it means, that we don't need
      // to do a separate call, in order to get all clients of the user.
      if(!_.isEmpty($location.search())){
        Client.query(function (data) {
          $scope.data.all_clients = data.clients;
        });
      }

      Invoice.states(function (states) {
        $scope.data.states = states
      })
    }

    // Private Scope
    function _get_colors () {
      var colors = {
        draft: '#999',
        open: '#999',
        unpaid: '#d22f2f',
        partly: '#ff8e00',
        paid: '#00bd22',
        overdue: '#8d0404',
        bad_debt: '#333'
      };

      _.each($scope.data.clients, function(client) {
        client.statistics['colors'] = [];
        _.each(client.statistics.percent_by_state, function(el) {
          client.statistics.colors.push(colors[el.label]);
        });
      });
    }
  }]);
