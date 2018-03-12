## What is This?

This is awesome Rails application for fun playing quizzes.


## Features

* Search quizzes with Full Text Search feature from PostgreSQL

* Latest quizzes

* Popular quizzes

* Share on Social Media

* User quiz playing history with the results

* User sign in and sign up

* User can change their profile and password

* Admin dashboard for manage: Quizzes, Questions, Users 

* Ordering position for questions

* Have user roles for easy manage users


## Requirements:

* Ruby 2.4.x

* Rails 5.1.x

* PostgreSQL

* Imagemagick


## How To Run:

* `bundle install`

* `rails db:create db:migrate db:seed`

* `rails s`

* to run all test `rspec spec`

* open browser and go to http://localhost:3000


## How to Access as Member:

* Go to Sign In page

* fill in email with `member@member.com`

* fill in password with `password`


## How to Access as Admin for Manage Quizzes:

* Go to Sign In page

* fill in email with `admin@admin.com`

* fill in password with `password`

* after success sign in, click to 'Administrator' on the top right corner then click 'Manage Quiz'. 
Or you can just go directly to http://localhost:3000/dashboard
