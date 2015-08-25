Feature: Parsing specifications

  So that I can easily identify different parts of specifications
  As a user
  I want to see features broken down into logical parts such as scenarios, features, tables, tags etc

  General notes:
  Features are the top level entity.
  Backgrounds, Scenarios and Scenario Outlines belong to Features.
  Steps can belong to Backgrounds, Scenarios and Scenario Outlines.
  Rows can belong to Steps (data table) or Examples.
  Examples belong to Scenario Outlines.
  Doc Strings belong to Steps.
  Tags and Comments belong to Features and Scenarios.


  # Slightly confusing because this is a feature about features.
  Background: A feature file exists
    Given the feature file
      """
      # A feature comment.
      @myFeatureLevelTag1 @myFeatureLevelTag2
      Feature: Feature title

        Some descriptive text, sometimes a "user story"

        # An example background in text block in a background.
        Background: Backgrounds exist
          Given there is a background

        # A scenario comment.
        @myScenarioLevelTag1 @myScenarioLevelTag2
        Scenario: Scenario 1
          Given something is true
          And something else is true
          But a third thing is not true
          When an action happens
          Then there is an outcome

        Scenario: Scenario 2
          Given I have an "argument"
          When I have a table data:
            | column name 1 | column name 2       |
            | a table value | another table value |
          Then I expect
            \"\"\" the-type-of-content
            A block of text
            On mulptiple lines.
            \"\"\"

        Scenario Outline: A collection of related examples
          Given I have a <placeholder>
          When I compare it to <another placeholder>
          Then the expected outcome is <a third lovely placeholder>

          Examples: Examples with a title
            some description of the examples
            | placeholder | another placeholder | a third lovely placeholder |
            | value1-1    | value1-2            | value1-3                   |
            | value2-1    | value2-2            | value2-3                   |

      Feature: coping with multiple features in a file.
      """

  @parsing
  Scenario: Parse titles
    When I parse this specification
    Then I get a feature with title "Feature title"
    And I get a background with the title "Backgrounds exist"
    And I get scenarios with titles
      | Scenario 1 |
      | Scenario 2 |
    And I get a scenario outline with the title "A collection of related examples"
    And I get a set of examples with the title "Examples with a title"

  @parsing
  Scenario: Parse tags
    When I parse this specification
    Then feature tags are associated with features
      | @myFeatureLevelTag1 |
      | @myFeatureLevelTag2 |
    And scenario tags are associated with scenarios
      | @myScenarioLevelTag1 |
      | @myScenarioLevelTag2 |

  @parsing
  Scenario: Parse comments
    When I parse this specification
    Then feature comments are associated with features
      | # A feature comment. |
    And scenario comments are associated with scenarios
      | # A scenario comment. |

  @parsing
  Scenario: Parse steps
    When I parse this specification
    Then the "first" scenario has steps with the names
      | something is true   |
      | there is an outcome |
    And the "second" scenario has steps with the names
      | I have an "argument" |
      | I expect             |

    @parsing
    Scenario: Parse example data
      When I parse this specification
      Then scenario outlines have example data
        | value1-1 |
        | value2-3 |

    @parsing
    Scenario: Parse table data
      When I parse this specification
      Then steps with tables have that table data
        | a table value       |
        | another table value |

    @parsing
    Scenario: Parse doc strings
      When I parse this specification
      Then steps with doc strings have that doc string content
        | A block of text\nOn mulptiple lines. |
