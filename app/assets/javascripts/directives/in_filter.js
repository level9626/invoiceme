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
                      <i class="glyphicon glyphicon-chevron-down filter_glyph"></i> \
                    </span> \
                  </div> \
                  <div class="panel-body dropdown_panel"> \
                    <form ng-submit="filter()"> \
                      <ng-transclude></ng-transclude> \
                      <button class="btn btn-round btn-primary" type="submit">Filter</button> \
                    </form> \
                  </div> \
                </div>',
      link: function(scope, element){
        // Initialize and pre-populate filter form
        var form = element.find('form').serializeObject()

        for (var k in form) {
          element.find("[name='"+k+"']").val($location.search()[k]);
        }

        scope.filter = function () {
          $location.search($.param(element.find('form').serializeObject()));
        };
      }
    };
  }]);