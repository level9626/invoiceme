'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',[
  '$scope',
  '$location',
  '$mdDialog',
  'Company',
  'Invoice',
  function ($scope, $location, $mdDialog, Company, Invoice) {

    $scope.data = {};
    $scope.methods = {};

    _init();

    $scope.methods.new_company = function (ev) {
      $mdDialog.show({
        controller: CompanyNewCtrl,
        templateUrl: 'companies/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    $scope.methods.edit_company = function (ev, id) {
      $mdDialog.show({
        controller: CompanyEditCtrl,
        templateUrl: 'companies/edit.html',
        targetEvent: ev,
        locals: {
          id: id
        }
      }).then(function(answer) {
        _init();
      });
    };

    $scope.methods.remove_company = function (id) {
      Company.remove({id: id}, function () {
        $scope.$emit('notify', {
          type: 'primary',
          text: 'Company successfully removed.'
        });
        $scope.$emit('companies.remove', true);
        _init();
      });
    };

    function _init() {
      // filtered
      Company.query($location.search(), function (data) {
        $scope.data.companies = data.companies;
        $scope.data.pagination = data.pagination
      });

      // All companies for filters
      // $location.search() will contain Object {q[name_eq]: "HP"}
      // or an empty Object {}
      // If it is containing an empty object, it means, that we don't need
      // to do a separate call, in order to get all companies of the user.
      if(!_.isEmpty($location.search())){
        Company.query(function (data) {
          $scope.data.all_companies = data.companies;
        });
      }

      Invoice.states(function (states) {
        $scope.data.states = states
      })
    }
  }]);
