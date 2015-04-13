
$(document).ready( function() {
    $('#invoice').on('change', '.hours_or_tasks, .rate', function() {
        var parrent        = $(this).closest('.nested-fields'),
            rate           = parrent.find('.rate').val() || 0,
            hours_or_tasks = parrent.find('.hours_or_tasks').val() || 0;

        parrent.find('.amount').text(rate*hours_or_tasks)
    });
});