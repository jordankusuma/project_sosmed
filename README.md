# Gojek_Project_Sosmed

### Introduction

Developing a social media application that can be used to share information with other people. This application will only be used by people that work for certain company so we have to use our own social media. Using Sinatra

### Installation

1. Fork and clone repo to your local machine
2. Install MySQL 
3. Create Database in MySQL, type `CREATE DATABASE {your preferred database name}` and type exit
4. Import Database Schema, type `mysql -u {your MySQL username} {your database name} < db_export.sql`
5. Use `bundle install` to install dependencies.
6. Create `.env` file based on `.env.example`
7. `source .env` file
8. Create a folder first, etc mkdir public and mkdir project insides public
9. Run the app with ruby main.rb or rackup -p 4567

### Running Linter

`rubocop -a` or `rubocop --auto-correct-all`

### Commit Guidelines

Using [Red], [Green] for showing Red Green Commit 

Commit types: 
1. `[TEST]` : commit a test
2. `[FEATURE]` : commit changes from feature 
3. `[DEPENDENCIES]` : commit for adding dependencies such as Collection , Schema or etc..

### Run Unit Testing
1. run rspec -f d should run all test

### Postman API Doc
1. Go check this link for JSON export [here](https://www.postman.com/collections/1ff4ca59a4ae3bed6acc) or check collection file [this link](https://github.com/jordankusuma/project_sosmed/blob/main/project_sosmed.postman_collection.json)

### Schema Design

![alt text](https://github.com/jordankusuma/project_sosmed/blob/main/twitter.jpg)

### Production Link
You can access here the production on [Production Link](http://34.131.29.50:4567/api/v1)

