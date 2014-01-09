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

    @wip
  Scenario: Uses env variables in template
    Given a file named "template.erb" with:
    """
    Hello <%= name %>!
    """
    And I set the environment variables to:
      | variable | value |
      | NAME     | Karl  |
    #Then then environment contains the following variables
    When I successfully run `filegen template.erb`
    Then the output should contain:
    """
    Hello Karl
    """
