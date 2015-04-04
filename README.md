Admin Panel
===============


Is implemented using https://github.com/upmin/upmin-admin-ruby

### Login

- Email: __user@example.com__
- Password: __changeme__

Invoice Template DB
===============
// Like a matrics with predefined item positions
###iv_templates
- __id__:integer
- __name__:string

// Defines an element, that will be rendered in a given matrics positions
###iv_template_elements
- __id__:integer
- __iv_template_id__:integer
- __position__:[{x: 'x'}, {x: 'x'}, {x: 'x'}, {x: 'x'}]
- __iv_template_element_type_id__:integer

// defines, what type of html template to render for a given element
###iv_template_element_types
- __id__:integer
- __name__:string

// users template contents
// For a given rendered html template for a template element, show corresponding
   iv content forms
###iv_element_contents
- __id__:integer
- __invoice_id__:intege
- __iv_template_element_id__:integer
- __iv_content_type__:string
- __iv_content_id__:integer

###iv_content_logos
-__id__:integer
- __content__:string

###iv_content_tables
- __id__:integer
- __content__:hstore

###iv_content_texts
- __id__:integer
- __content__:text

###iv_content_labels
- __id__:integer
- __content__:string


Invoice DB(scaffold)
===============
###invoices
- __id__:integer
- __title__:string
- __user_id__:integer

User, Profiles, Roles DB
===============