Feature: Error handling

  As a user
  I want to get good error message
  In order to fix my mistakes

  @wip
  Scenario: Missing file name
    When I run `filegen`
    Then the output should contain:
    """
    Error
    """
