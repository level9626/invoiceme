$(document).ready( function() {

  $('[data-content-toggle]').click(function() {
    var el        = $(this),
        vals      = el.attr('data-content-toggle').split(','),
        texts     = el.attr('data-button-values').split(','),
        text_from = texts[0],
        text_to   = texts[1],
        from      = $(vals[0]),
        to        = $(vals[1]);

    // By default 'from' DOM element will be shown.
    $(to).addClass('hidden');
    el.find('a').text(text_from);

    if (from.hasClass('hidden')) {
      from.removeClass('hidden');
      to.addClass('hidden');
      el.find('a').text(text_from);
    } else {
      to.removeClass('hidden');
      from.addClass('hidden');
      el.find('a').text(text_to);
    }

  });
});
