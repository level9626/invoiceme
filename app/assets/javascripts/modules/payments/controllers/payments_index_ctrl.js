'use strict';

angular.module('PaymentsApp')
    .controller('PaymentsIndexCtrl',
    ['$scope',
        '$sce',
        'Payment',
        function ($scope, $sce, Payment) {

            Payment.query(function (data) {
                $scope.payments = data.payments;
            });

        }]);
