# Hashop

[![Build Status](https://travis-ci.org/vinhnglx/hashop.svg?branch=develop)](https://travis-ci.org/vinhnglx/hashop) [![Coverage Status](https://coveralls.io/repos/github/vinhnglx/hashop/badge.svg?branch=develop)](https://coveralls.io/github/vinhnglx/hashop?branch=develop)

Hashop is a simple API application for Happy Shop - an e-commerce retailer specializing in beauty products. The Hashop REST API allows you to query data about products.

## Getting started

### How to run

- Install ruby 2.3.1 by rvm or rbenv.

- Clone and setup gem dependencies for project:

    ```
      gem install bundler
      bundle install
    ```

- Setup environment variables

    ```
      cp config/application.yml.sample config/application.yml
    ```

- Setup database.

    ```
      rake db:create
      rake db:migrate
    ```

- Create some sample products

    ```
      rake db:seed
    ```

- Run server by `rails s`

### Project management

All tasks available on Trello: https://trello.com/b/Rwz1PY4s

## API documentation

The API documentation available on http://docs.hashop.apiary.io/

## Live example on Postman

Interact with Hashop API by Postman: https://www.getpostman.com/collections/7bf06aec67822434bb36
