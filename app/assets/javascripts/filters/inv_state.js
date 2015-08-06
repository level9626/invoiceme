'use strict';

angular.module('InvMe')
  .filter('invState', function() {
    return function (input) {
      var states = {
         draft:    'Draft',
         new:      'Draft',
         unpaid:   'Unpaid',
         partly:   'Partly',
         paid:     'Paid',
         overdue:  'Overdue',
         bad_dept: 'Bad Dept'
      };

      return states[input];
    };
  });