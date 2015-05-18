ActiveAdmin.register InvoiceEmailTemplate do
  permit_params :template_subject, :template_body, :email_templatable_id,\
                :email_templatable_type, :to, :cc, :from, :name

  form do |f|
    f.inputs "InvoiceEmailTemplate" do
      f.input :name
      f.input :template_subject
      f.input :to
      f.input :cc
      f.input :from
      f.input :template_body
    end
  end
end