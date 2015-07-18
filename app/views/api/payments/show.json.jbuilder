json.extract! @payment, :id, :invoice_id, :amount, :created_at, :updated_at, \
                        :currency, :banking_overhead
json.invoice @payment.invoice
json.client @payment.client
json.company @payment.company
json.comments @payment.comments
json.attachments @payment.attachments
