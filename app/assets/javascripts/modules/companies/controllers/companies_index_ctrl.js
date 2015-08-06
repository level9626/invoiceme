'use strict';

function DialogController($scope, $mdDialog, Company) {
  $scope.company = {
    name: '',
    email: '',
    address: ''
  };

  $scope.cancel = function() {
    $mdDialog.cancel();
  };

  $scope.saveCompany = function () {
    Company.save($scope.company, function (company) {
      $mdDialog.hide();
    }, function (responce) {
      console.log(responce.data.errors);
      $scope.errors = responce.data.errors;
    });
  };
}

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',
  ['$scope',
   '$mdDialog',
   'Company',
   'Invoice',
   function ($scope, $mdDialog, Company, Invoice) {

    _init();

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      _init();
    };

    $scope.newCompany = function (ev) {
      $mdDialog.show({
        controller: DialogController,
        templateUrl: 'companies/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    function _init() {
      Company.query(function (data) {
        $scope.companies = data.companies;
      });

      Invoice.states(function (states) {
        $scope.states = states
      })
    }
  }]);
