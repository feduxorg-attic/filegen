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
    When I run `filegen --yaml-file input.yaml template.erb`
    Then the output should contain:
    """
    Hello Karl!
    """
  
  Scenario: Define order of data sources for lookup (env first)
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('NAME') %>!
    """
    And a file named "input.yaml" with:
    """
    ---
    NAME: Karl
    """
    And I set the environment variables to:
      | variable | value |
      | NAME     | Egon  |
    When I run `filegen --yaml-file input.yaml --data-sources env,yaml template.erb`
    Then the output should contain:
    """
    Hello Egon!
    """

  Scenario: Define order of data sources for lookup (yaml first)
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('NAME') %>!
    """
    And a file named "input.yaml" with:
    """
    ---
    NAME: Karl
    """
    And I set the environment variables to:
      | variable | value |
      | NAME     | Egon  |
    When I run `filegen --yaml-file input.yaml --data-sources yaml,env template.erb`
    Then the output should contain:
    """
    Hello Karl!
    """

  Scenario: Leaving out a data source
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('NAME') %>!
    """
    And a file named "input.yaml" with:
    """
    ---
    NAME: Karl
    """
    And I set the environment variables to:
      | variable | value |
      | NAME     | Egon  |
    When I run `filegen --yaml-file input.yaml --data-sources yaml template.erb`
    Then the output should contain:
    """
    Hello Karl!
    """
