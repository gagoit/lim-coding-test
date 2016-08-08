# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.3.1

* Rails version
5.0

* Api documentation
http://petstore.swagger.io/?baseUrl=http%3A%2F%2Flocalhost%3A3000%2Fapi%2Fv1%2Fswagger_doc.json#/
	+ Api Version will be set in headers['Accept'] = "application/vnd.lim-coding-test-v#{version}"
	+ User Authorization token will be set in headers['Authorization']
	+ currently API has version 1

* Note:
  + Grabbed HTML tags will be defined in app/models/html_element.rb
  + When define a new HTML tags, plz add the category of this tag in CATEGORIES hash, and define the method to grab this category (if is new category) in app/services/html_element_service.rb (refer to get_header_tags and get_links method for more detail)

* How to run the test suite
rspec spec/api

* Services (job queues, cache servers, search engines, etc.)
  
* Deployment instructions

* ...
