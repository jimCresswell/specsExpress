Feature: Seating is not available in prime seat selling

  Based on Booking circumstances
  As a ba.com business
  Seating not offered in prime selling

  @wip
  Scenario: Seating is not available for departing over 250 days
    Given I travel as Standard and book my trip with:
      | From            | LHR    |
      | To              | PHL    |
      | Flight Class    | F      |
      | Ticket Type     | LOWEST |
      | Departure After | 300    |
    When I choose seat for my inbound segment
    Then Seating option is not displayed

  Scenario: Seating is not available in other flight operator
    Given I travel as Standard and book my trip with:
      | From            | LGW      |
      | To              | BCN      |
      | Flight Class    | M        |
      | Ticket Type     | FLEXIBLE |
      | Flight Operator | Vueling  |
    When I continue from booking passenger details
    Then Seating option is not displayed