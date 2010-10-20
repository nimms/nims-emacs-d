Feature: Model Jumps
  In order to quickly open a model
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From view
    When I visit "app/views/books/show.html.erb"
    And I press "C-c ; f m"
    Then I should be in file "app/models/book.rb"

  Scenario: From helper
    When I visit "app/helpers/books_helper.rb"
    And I press "C-c ; f m"
    Then I should be in file "app/models/book.rb"

  # Scenario: From migration
  # Scenario: From spec model
  # Scenario: From spec controller
  # Scenario: From spec view
  # Scenario: From spec fixture

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    And I press "C-c ; f m"
    Then I should be in file "app/models/book.rb"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    And I press "C-c ; f m"
    Then I should be in file "app/models/book.rb"

  Scenario: From fixture
    When I visit "test/fixtures/books.yml"
    And I press "C-c ; f m"
    Then I should be in file "app/models/book.rb"

  # Scenario: From model to model
