# Imports all admin primary templates for a given model.
# User can have a separate template, based on default one.
# Any updates in model templates should not cause issues for
# primary admin templates.
# TODO: need to be tested

module Modules
  module TemplateImportable
    def self.included(klass)
      klass.has_many :mail_templates, as: :email_templatable, \
                                      class_name: InvoiceEmailTemplate

      klass.after_create :_import_primary_invoice_templates
    end

    private

    def _import_primary_invoice_templates
      return if self.is_a?(User) and !user? # !user? - means with admin role

      InvoiceEmailTemplate.primary.each do |invoice_template|
        mail_templates << invoice_template.dup
      end
    end
  end
end
