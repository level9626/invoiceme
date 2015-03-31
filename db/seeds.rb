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

IvTemplateElementType.where(name: 'logo').first_or_create
IvTemplateElementType.where(name: 'table').first_or_create
IvTemplateElementType.where(name: 'styled_text').first_or_create
IvTemplateElementType.where(name: 'label').first_or_create


iv_template = IvTemplate.create(name: 'Test Name')


['logo', 'table', 'styled_text', 'label'].each do |type|
  IvTemplateElement.create iv_template_id: iv_template.id,
                           position: {
                               cube: [
                                {x: 10,  y: 10},
                                {x: 100, y: 10},
                                {x: 10,  y: 100},
                                {x: 100, y: 100}
                               ]
                           },
                           iv_template_element_type_id: IvTemplateElementType.send(type)
end