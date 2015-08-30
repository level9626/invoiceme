'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',[
  '$scope',
  '$mdDialog',
  'Search',
  'Invoice',
  function ($scope, $mdDialog, Search, Invoice) {

    $scope.data = {};
    $scope.methods = {};

    Invoice.query(Search.q_params(), function (data) {
      $scope.data.invoices = data.invoices;
      $scope.data.pagination = data.pagination;
    });

    Invoice.invoice_count( function (data) {
      $scope.data.invoice_count = data.invoice_count;
    });

    $scope.methods.clear_filters = function () {
      if (_table_filter_keys().length == 0)
        return;

      Search.clear_param('q[state_eq]');
    };

    $scope.methods.filter = function (filter_param, filter_value) {
      $(document).scrollTop(0);
      var params = {};
      params[filter_param] = filter_value;
      Search.search_q(params);
    };

    $scope.methods.selected = function (filter_param, filter_value) {
      if (filter_param == 'index' && _table_filter_keys().length == 0)
        return true;

      return Search.q_params()['q[' + filter_param + ']'] == filter_value;
    };

    // Private scope
    function _table_filter_keys () {
      return _.filter(Search.q_keys(), function (el) {
        return el.match(/q\[state_eq\]/);
      });
    }

  }]);
