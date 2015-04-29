# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

# Create default primary templates for admin user
params = {
    name: 'Test Template',
    template_body: '<h1>Test Template</h1><p>Will a little formatting</p>',
    template_subject: 'Test Subject'
}
user.invoice_email_templates << InvoiceEmailTemplate.where(params)
                                    .first_or_create

# Import all invoice templates for all old users
User.all.each{|u| u.send(:_import_primary_invoice_templates)}