'use strict';

angular.module('InvMe')
  .directive('inFilter',
    ['$location',
    function($location){
    return {
      restrict: 'E',
      scope: {},
      transclude: true,
      template: '<div class="panel panel-default panel_invoice"> \
                  <div class="panel-heading"> \
                    <panel-title class="filter_text">Filters</panel-title> \
                    <span class="pull-right clickable"> \
                      <i class="glyphicon glyphicon-chevron-down filter_glyph" ng-click="toggleShow()"></i> \
                    </span> \
                  </div> \
                  <div class="panel-body dropdown_panel"> \
                    <form ng-submit="filter()"> \
                      <ng-transclude></ng-transclude> \
                      <button class="btn btn-round btn-primary" type="submit">Filter</button> \
                      <div class="pull-right"> \
                        <button class="btn btn-round btn-danger" ng-click="clearFilter()">Clear Filters</button> \
                    </form> \
                  </div> \
                </div>',
      link: function(scope, element){
        // Initialize and pre-populate filter form
        var form = element.find('form'),
            formData = form.serializeObject(),
            hiddable = element.find('.panel-body');

        hiddable.hide();

        for (var k in formData) {
          element.find("[name='"+k+"']").val($location.search()[k]);
        }
        // END init;

        scope.filter = function () {
          $location.search($.param(form.serializeObject()));
        };

        scope.clearFilter = function () {
          $location.search('');
        }

        scope.toggleShow = function () {
          if (hiddable.is(":visible")) {
            hiddable.hide();
          } else {
            hiddable.show();
          }
        }
      }
    };
  }]);