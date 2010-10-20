Feature: Controller Jumps
  In order to quickly open a controller
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"


  Scenario: From model
    When I visit "app/models/book.rb"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  Scenario: From view
    When I visit "app/views/books/show.html.erb"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  Scenario: From helper
    When I visit "app/helpers/books_helper.rb"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  # Scenario: From migration
  # Scenario: From spec model
  # Scenario: From spec controller
  # Scenario: From spec view
  # Scenario: From spec fixture

  Scenario: From functional test
    When I visit "test/functional/books_controller_test.rb"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  Scenario: From unit test
    When I visit "test/unit/book_test.rb"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  Scenario: From fixture
    When I visit "test/fixtures/books.yml"
    And I press "C-c ; f c"
    Then I should be in file "app/controllers/books_controller.rb"

  # Scenario: From controller to controller
