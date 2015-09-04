'use strict';

angular.module('InvoicesApp')
  .controller('JournalIndexCtrl',[
    '$scope',
    '$routeParams',
    'Search',
    'Journal',
    function ($scope, $routeParams, Search, Journal) {

      $scope.data = {};

      var _invoice_params = {invoice_id: $routeParams['invoice_id']},
          _params         = _.extend(Search.q_params(), _invoice_params);

      Journal.query(_params, function (data) {
        $scope.data.journals = data.journals;
        $scope.data.pagination = data.pagination;
      });

      Journal.get({invoice_id: $routeParams['invoice_id']}, function (journal) {
        $scope.journal = journal;
      });

    }]);
