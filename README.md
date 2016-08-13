# README

Purpose: To retrieve Patient and Appointment info from CareCloud.


Methods: Communicate with the Spark API through XML to generate indexes based on the required query sent from nimbus_front_end, then pull the data through SOLR. This app will then return the requested data back to nimbus_front_end in JSON format.

Steps:
1. Receive a JSON request from nimbus_front_end
2. Parse the request, and convert into an XML format to send to Spark to index the CareCloud DB appropriately
3. Pull the data using the new index through SOLR
4. Convert the data to JSON to send back to nimbus_front_end

* Ruby version
2.3.0
* System dependencies
Rails 4
* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
