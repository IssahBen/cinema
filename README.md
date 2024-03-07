# README

Objective: I mainly developed  this application to test my understanding of ruby on rails After 1 month of studying 

About:This is the first version of a simple web Application written in Ruby on Rails  6.1.7.6.The name of this application  is Cinema .
      It's a simple web app that allows users to search for movies and stream via third party webisite.Visitors to the site can sign up which gives access to extra features .


..*FEATURES. 
* Users can search for the latest movies  and stream via a link to a third party website.
* Users can sign up for an account .
* Registered users can create something called a bucket .Every bucket has a title and description.
* Users can add movies to be watch later to their bucket 
* Users can delete their bucket and it associated movies
* Added movies can be removed from the bucket and there is a Stream link attached to every movie card which allows users to stream via a third party service
* Users can edit their account details such as password ,email and Username.
    * Web Application is accessible via mobile and other devices 


..*Features to be included in future versions.
* Allow users to stream movies on the website without redirecting to a third party service


..*Steps to Reproduce the code in  the development in Environment
* 1 Go to config/database.yml
* Replace 
...default: &default
...  adapter: postgresql
...  encoding: unicode
... pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
...  timeout: 5000    
* with
...    default: &default 
...     adapter: sqlite3
...  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
...  timeout: 5000 


