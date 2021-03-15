<div align="center">
  <br>
  <h1>Salesforce Retail 👨‍💻</h1>
</div>
<br>

## Summary

Hey! This project helps managing your salesforce account by adding your customers and retails to your database, filtering them based on distance, and more future features that will allow getting the best out of the data you have

## Start the Project

If you have a Docker and docker compose . That's a good start. If not, here're the links to install them

Docker: https://docs.docker.com/get-docker/
Docker Compose: https://docs.docker.com/compose/install/

## Clone the project

`$ git clone git@github.com:amrdruid/Salesforce-Retail.git`

### Run docker build

`$ docker build .`

### Run docker compose to start the container

`$ docker-compose up`

### Run migrations

`$ docker-compose exec web bundle exec rake db:migrate`

### Add your salesforce credentials and secrets

Create an `application.yml` file using `docker-compose exec web bundle exec figaro install`

you can find a sample file in `application.yml.sample`


### Run the test suite (Tests WIP)

$ `rspec spec`

--- 

## Walkthrough

- From `dealers_controller.rb` we have two main APIs, `add_point_of_sales_dealers` and `dealers_within_range`

- `add_point_of_sales_dealers` allows adding retails to the database by internal employees

- `dealers_within_range` returns the retails around your current lng and lat in form of JSON

- We have a rake task that does what `add_point_of_sales_dealers` does. We can execute it through `docker-compose exec web bundle exec rake dealers:generate_and_save_to_db`

- We use `Sentry` for tracking errors 

- We use `Figaro` gem to manage secrets

--- 

Areas for improvement: (Section WIP)

---
