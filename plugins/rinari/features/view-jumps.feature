Feature: View Jumps
  In order to quickly open a view
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From model
    When I visit "app/models/book.rb"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "index.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/index.html.erb"

  Scenario: From controller
    When I visit "app/controllers/books_controller.rb"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "show.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/show.html.erb"

  # Scenario: From controller action

  Scenario: From helper
    When I visit "app/helpers/books_helper.rb"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "new.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/new.html.erb"

  # Scenario: From migration
  # Scenario: From spec model
  # Scenario: From spec controller
  # Scenario: From spec view
  # Scenario: From spec fixture

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "edit.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/edit.html.erb"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "edit.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/edit.html.erb"

  Scenario: From fixture
    When I visit "test/fixtures/books.yml"
    Given I start an action chain
    And I press "C-c ; f v"
    And I type "show.html.erb"
    And I execute the action chain
    Then I should be in file "app/views/books/show.html.erb"

  # Scenario: From view to view
