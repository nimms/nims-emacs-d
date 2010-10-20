Feature: Rinari
  In order to develop Ruby on Rails app
  As an Emacs user
  I need Rinari

  Background:
    Given rails application "app"

  Scenario: Should activate Rinari
    Given Rinari is inactive
    When I visit "config/environment.rb"
    Then Rinari should be active

  Scenario: Should start web server
    Given Rinari is active 
    When I press "C-c ; w"
    Then I should be in buffer "*rails*"
 
  Scenario: Should start SQL console
    Given Rinari is active
    When I press "C-c ; c"
    Then I should be in buffer "*ruby*"

  Scenario: Should visit a log file
    Given Rinari is active
    When I start an action chain
    And I press "C-c ; f o"
    And I type "development.log"
    And I execute the action chain
    Then I should be in file "app/log/development.log"
