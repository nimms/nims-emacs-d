Feature: Test Jumps
  In order to quickly open a test
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From model
    When I visit "app/models/book.rb"
    And I press "C-c ; f t"
    Then I should be in file "test/unit/book_test.rb"

  Scenario: From controller
    When I visit "app/controllers/books_controller.rb"
    And I press "C-c ; f t"
    Then I should be in file "test/functional/books_controller_test.rb"

  Scenario: From view
    When I visit "app/views/books/show.html.erb"
    And I press "C-c ; f t"
    Then I should be in file "test/functional/books_controller_test.rb"

  Scenario: From helper
    When I visit "app/helpers/books_helper.rb"
    And I press "C-c ; f t"
    Then I should be in file "test/functional/books_controller_test.rb"

  # Scenario: From migration

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    And I press "C-c ; f t"
    Then I should be in file "test/unit/book_test.rb"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    And I press "C-c ; f t"
    Then I should be in file "test/functional/books_controller_test.rb"
