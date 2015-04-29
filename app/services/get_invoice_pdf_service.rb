class GetInvoicePdfService
  # TODO: test this
  def call(invoice)
    ac = ActionController::Base.new
    @invoice = invoice

    template = Rails.root.join('app', 'views', 'invoices', \
                               '_show_content.html.slim').to_s
    layout = 'pdf_layout'
    params = { layout: layout, zoom: 0.9, locals: { :'@invoice' => @invoice } }

    WickedPdf.new.pdf_from_string ac.render_to_string(template, params)
  end
end
