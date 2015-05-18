ActiveAdmin.register InvoiceEmailTemplate do
  permit_params :template_subject, :template_body, :email_templatable_id,\
                :email_templatable_type, :to, :cc, :from, :name

  index do
    selectable_column
    column :template_subject
    column(:template_body) { |obj| obj.template_body.html_safe }
    column :email_templatable_id
    column :email_templatable_type
    column :to
    column :cc
    column :from
    column :name
    column :created_at
  end

  form do |f|
    f.inputs "InvoiceEmailTemplate" do
      f.input :name
      f.input :template_subject
      f.input :to
      f.input :cc
      f.input :from
      f.input :template_body
    end
    actions
  end
end