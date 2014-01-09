Feature: Evaluate Template

  As a user
  I want to evaluate a template
  In order to generate a file

  Scenario: Existing file
    Given a file named "template.erb" with:
    """
    Hello World!
    """
    When I successfully run `filegen template.erb`
    Then the output should contain:
    """
    Hello World!
    """

  Scenario: Uses env variables in template
    Given a file named "template.erb" with:
    """
    Hello <%= name %>!
    """
    And I set the environment variables to:
      | variable | value |
      | NAME     | Karl  |
    When I successfully run `filegen template.erb`
    Then the output should contain:
    """
    Hello Karl
    """

  Scenario: Non existing file
    When I run `filegen template1.erb`
    Then the stderr should contain:
    """
    File "template1.erb" does not exist
    """

    @wip
  Scenario: Non erb file
    Given an empty file named "template1.abc"
    When I run `filegen template1.abc`
    Then the stderr should contain:
    """
    File "template1.abc" is not a valid erb template: file ending erb
    """
