Feature: Helper Jumps
  In order to quickly open a helper
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From model
    When I visit "app/models/book.rb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb"

  Scenario: From controller
    When I visit "app/controllers/books_controller.rb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb"

  Scenario: From view
    When I visit "app/views/books/show.html.erb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb"

  # Scenario: From helper # Huh? What does this do?

  Scenario: From migration
    When I visit migration "db/migrate/*_create_books.rb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb" 

  # Scenario: From spec model
  # Scenario: From spec controller
  # Scenario: From spec view

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    And I press "C-c ; f h"
    Then I should be in file "app/helpers/books_helper.rb"

  # Scenario: From helper to helper
