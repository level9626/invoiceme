#= require active_admin/base
#= require bootstrap-wysihtml5
$(document).ready ->
  $('.admin_wysihtml5').each (i, elem) ->
    $(elem).wysihtml5()