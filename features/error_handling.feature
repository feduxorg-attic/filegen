Feature: Error handling

  As a user
  I want to get good error message
  In order to fix my mistakes

  Scenario: Missing file name
    When I run `filegen`
    Then the output should contain:
    """
    Template file name is missing.
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

  Scenario: Non existing YAML-file
    Given a file named "template.erb" with:
    """
    Hello <%= lookup('name') %>!
    """
    When I run `filegen -y input.yaml template.erb`
    Then the stderr should contain:
    """
    Yaml-file "input.yaml" not found
    """
