
$(document).ready( function() {
    $('#invoice').on('change', '.hours_or_tasks, .rate', function() {
        var parrent        = $(this).closest('.nested-fields'),
            rate           = parrent.find('.rate').val() || 0,
            hoursOrTasks   = parrent.find('.hours_or_tasks').val() || 0,
            subTotal       = 0,
            item_value     = parseFloat( rate*hoursOrTasks ).round(2);


        parrent.find('.amount')
               .text( item_value );

        parrent.find('.hidden input')
               .val( item_value );


        $('#invoice').find('.amount').each(function(){
            subTotal += parseFloat( $(this).text() ).round(2);
        });

        $('#subtotal span').text(subTotal);
        $('#subtotal .hidden input').val(subTotal);
    });

    $('.hours_or_tasks, .rate').trigger('change');
});