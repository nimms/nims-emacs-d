Feature: Other Jumps
  In order to quickly open a Rails file
  As a Rinari user
  I want to jump to it

  Background:
    Given rails application "app"
    And I generate scaffold for "Book"
    When I visit "config/environment.rb"


  Scenario: To an environment
    Given I start an action chain
    When I press "C-c ; f e"
    And I type "development.rb"
    And I press "RET"
    And I execute the action chain
    Then I should be in file "config/environments/development.rb"

  # @rails3 (Ecukes does not have tags support, yet)
  # Scenario: To application

  Scenario: To configuration
    Given I start an action chain
    When I press "C-c ; f n"
    And I type "routes.rb"
    And I press "RET"
    And I execute the action chain
    Then I should be in file "config/routes.rb"

  # @rails2 (Ecukes does not have tags support, yet)
  # Scenario: To script

  # Scenario: To lib

  Scenario: To log
    Given I start an action chain
    When I press "C-c ; f o"
    And I type "development.log"
    And I press "RET"
    And I execute the action chain
    Then I should be in file "log/development.log"

  # Scenario: To worker

  Scenario: To public
    Given I start an action chain
    When I press "C-c ; f p"
    And I type "index.html"
    And I press "RET"
    And I execute the action chain
    Then I should be in file "public/index.html"

  # Scenario: To stylesheet
  # Scenario: To sass

  Scenario: To javascript
    Given I start an action chain
    When I press "C-c ; f j"
    And I type "application.js"
    And I press "RET"
    And I execute the action chain
    Then I should be in file "public/javascripts/application.js"

  # Scenario: To plugin

  # @rails3 (Ecukes does not have tags support, yet)
  # Scenario: To mailer
