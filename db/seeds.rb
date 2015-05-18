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


InvoiceEmailTemplate.delete_all
# Create default primary templates for admin user
if user.mail_templates.empty?
  inv_et = InvoiceEmailTemplate.new
  inv_et2 = InvoiceEmailTemplate.new

  inv_et.name = 'Send Invoice'
  inv_et.template_body = '<h1>Test Template</h1><p>Will a little formatting</p>'
  inv_et.template_subject = 'Test Subject'
  inv_et.to = ['email1@example.com']
  inv_et.cc = ['email2@example.com']
  inv_et.from = 'email3@example.com'

  inv_et2.name = 'Receive Payment'
  inv_et2.template_body = '<h1>Test Template</h1><p>Will a little formatting</p>'
  inv_et2.template_subject = 'Test Subject'
  inv_et2.to = ['email1@example.com']
  inv_et2.cc = ['email2@example.com']
  inv_et2.from = 'email3@example.com'

  puts 'CREATING PRIMARY INVOICE TEMPLATES:'
  puts user.mail_templates << [inv_et, inv_et2]
end

# Import all invoice templates for all old users
User.all.each{|u| u.send(:_import_primary_invoice_templates)}