'use strict';

angular.module('InvoicesApp')
  .controller('InvoicesIndexCtrl',
    ['$scope',
    '$location',
    'Invoice',
    function ($scope, $location, Invoice) {

        Invoice.query($location.search(), function (data) {
            $scope.invoices = data.invoices;
        });


        $scope.sortType     = 'invoice_number'; // set the default sort type
        $scope.sortReverse  = false;  // set the default sort order



    }]);
