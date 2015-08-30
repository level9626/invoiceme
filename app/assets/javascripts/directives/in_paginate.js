angular.module('InvMe')
  .directive('inPaginate',[
  'Search',
  function(Search) {
    return {
      restrict: 'E',
      replace: true,
      template:  '<div id="in-pagination" \
                       layout="row" \
                       ng-show="pagination && pagination.total_pages > 1" \
                       layout-sm="column" \
                       layout-align="{{align}}" \
                       layout-wrap> \
                    <md-button ng-disabled="!pagination.previous_page" \
                               ng-click="previous_page()" \
                               ng-class="{light: light}"><</md-button> \
                    <md-button ng-show="light" \
                               ng-class="{light: light}" \
                               class="page-info" \
                               ng-disabled="true"> \
                               Page: {{pagination.current_page}} \
                               </md-button> \
                    <md-button ng-hide="light" \
                               ng-repeat="page in pages track by $index" \
                               ng-disabled="is_stub(page)" \
                               ng-class="{active: active(page), stub: is_stub(page)}" \
                               ng-click="go_to(page)">{{page}}</md-button> \
                    <md-button ng-disabled="!pagination.next_page" \
                               ng-click="next_page()" \
                               ng-class="{light: light}">></md-button> \
                  </div>',
      scope: {
        pagination: '=inPagination',
        light: '=',
        align: '@'
      },
      link: function(scope) {
        var _show_pages = 3;
        scope.pages = [];
        scope.align = scope.align || 'end center';

        scope.$watch('pagination.current_page', function (new_data) {
          if (!new_data)
            return;
          _init();
        });

        function _init () {
          scope.pages = [];

          // Insert link to the first page, if we paginated further.
          if (_show_first()) {
            scope.pages.push(1);
            scope.pages.push('...');
          }
          // Insert range
          scope.pages = scope.pages.concat(_get_range());
          
          // Insert link to the last page, if we have a lot of pages
          if (_show_last())
            scope.pages = scope.pages.concat(['...', scope.pagination.total_pages]);
        }

        scope.active = function (page) {
          return scope.pagination.current_page === page;
        }

        scope.is_stub = function (page) {
          return page === '...'
        }

        scope.go_to = function (page) {
          Search.search({page: page});
        }

        scope.next_page = function () {
          Search.search({page: scope.pagination.next_page});
        }

        scope.previous_page = function () {
          Search.search({page: scope.pagination.previous_page});
        }

        // Private Scope

        // Means that in the collection we have less than or equal
        // to 5, ammount of pages. In this case we don't need format
        // like: < 1 2 3 4 5 ... 30 >
        // or: < 1 ... 6 7 8 9 10 ... 30
        function _show_five () {
          return scope.pagination.total_pages <= _show_pages;
        }
  
        function _show_last () {
          if (_near_end())
            return false
          return scope.pagination.total_pages >= _show_pages;
        }
        
        function _show_first () {
          if (_show_five())
            return false;
          return scope.pagination.current_page > 1;
        }
  
        function _near_end() {
          var total_pages = scope.pagination.total_pages,
              current_page = scope.pagination.current_page;
          return (total_pages - current_page) <= _show_pages;
        }

        // Adds the necessary amount of pages to the end;
        function _range_end() {
          var current_page = scope.pagination.current_page,
              total_pages  = scope.pagination.total_pages;
              
          if ((current_page + _show_pages) > total_pages)
            return total_pages;
          
          return current_page + _show_pages
        }
  
        function _get_range() {
          var current_page = scope.pagination.current_page,
              total_pages  = scope.pagination.total_pages;
          
          if (_show_five()){
            return _.range(1, total_pages + 1);
          }

          if (_near_end())
            return _.range(total_pages - _show_pages, total_pages + 1);
          
          return _.range(current_page, _range_end());
        }
      }
    };
  }]);