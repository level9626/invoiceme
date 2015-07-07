'use strict';

angular.module('PaymentsApp')
    .factory('Payment',
        ['$resource',
            function($resource) {

                return $resource('/api/payments/:id', { id: '@id' }, {
                    update: {
                        method: 'PUT'
                    },
                    query: {
                        method: 'GET',
                        isArray: true
                    }
                });

            }
        ]);
