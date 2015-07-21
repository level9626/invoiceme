angular.module('InvMe')
  .directive('richTextEditor', function() {
    return {
      restrict: 'A',
      replace: true,
      require: '?ngModel',
      transclude: true,
      template: '<div><textarea></textarea></div>',
      link: function(scope, element, attrs, controller) {
        var editor, textarea;
        textarea = element.find('textarea').wysihtml5({
          toolbar: {
              "font-styles": false,
              "lists": false,
              "link": false,
              "image": false,
              "color": false,
              "blockquote": false,
              "size": 'xs'
          }
        });
        editor = textarea.data('wysihtml5').editor;
        editor.on('change', function() {
          return controller.$setViewValue(editor.getValue());
        });
        return scope.$watch(attrs.ngModel, function(newValue, oldValue) {
          textarea.html(newValue);
          return editor.setValue(newValue);
        });
      }
    };
  });