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
    Hello <%= lookup('NAME') %>!
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

  Scenario: Non erb file
    Given an empty file named "template1.abc"
    When I run `filegen template1.abc`
    Then the stderr should contain:
    """
    File "template1.abc" is not a valid erb template: file ending erb
    """

    @wip
  Scenario: YAML file as input (short)
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('name') %>!
    """
    And a file named "input.yaml" with:
    """
    ---
    name: Karl
    """
    When I run `filegen -y input.yaml template.erb`
    Then the output should contain:
    """
    Hello Karl!
    """

    @wip
  Scenario: YAML file as input (long)
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('name') %>!
    """
    And a file named "input.yaml" with:
    """
    ---
    name: Karl
    """
    When I run `filegen --yaml_file input.yaml template.erb`
    Then the output should contain:
    """
    Hello Karl!
    """
