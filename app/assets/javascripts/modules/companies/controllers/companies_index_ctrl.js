'use strict';

angular.module('CompaniesApp')
  .controller('CompaniesIndexCtrl',[
   '$scope',
   '$location',
   '$mdDialog',
   'Company',
   'Invoice',
   function ($scope, $location, $mdDialog, Company, Invoice) {

    _init();

    $scope.destoryCompany = function (company_id) {
      Company.remove({id: company_id});
      _init();
    };

    $scope.newCompany = function (ev) {
      $mdDialog.show({
        controller: CompanyNewCtrl,
        templateUrl: 'companies/new.html',
        targetEvent: ev,
      }).then(function(answer) {
        _init();
      });
    };

    $scope.editCompany = function (ev, id) {
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

    $scope.removeCompany = function (id) {
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
        $scope.companies = data.companies;
      });

      // All companies for filters
      // $location.search() will contain Object {q[name_eq]: "HP"}
      // or an empty Object {}
      // If it is containing an empty object, it means, that we don't need
      // to do a separate call, in order to get all companies of the user.
      if(!_.isEmpty($location.search())){
        Company.query(function (data) {
          $scope.all_companies = data.companies;
        });
      }

      Invoice.states(function (states) {
        $scope.states = states
      })
    }
  }]);
