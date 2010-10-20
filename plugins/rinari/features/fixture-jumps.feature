Feature: Fixture Jumps
  In order to quickly open a fixture
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From model
    When I visit "app/models/book.rb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"

  Scenario: From controller
    When I visit "app/controllers/books_controller.rb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"

  Scenario: From view
    When I visit "app/views/books/show.html.erb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"

  Scenario: From helper
    When I visit "app/helpers/books_helper.rb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"

  # Scenario: From migration
  # Scenario: From spec model
  # Scenario: From spec controller
  # Scenario: From spec view

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    And I press "C-c ; f x"
    Then I should be in file "test/fixtures/books.yml"
