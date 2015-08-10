'use strict';

function ClientNewCtrl ($scope, $mdDialog, Client) {
  $scope.client = {
    name: '',
    email: '',
    address: ''
  };

  $scope.cancel = function() {
    $mdDialog.cancel();
  };

  $scope.saveClient = function () {
    Client.save($scope.client, function (client) {
      $mdDialog.hide();
    }, function (responce) {
      $scope.errors = responce.data.errors;
    });
  };
}