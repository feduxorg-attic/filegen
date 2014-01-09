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
