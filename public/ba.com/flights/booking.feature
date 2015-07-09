@jira-flights-823
Feature: Flights - bookings

  In order to provide high quality service for my customers
  As a concerned staff member
  I want to make sure flight search works correctly

  @browser
  Scenario: Return flight booking
    Given I am on the search results page for:
      | from             | LHR |
      | to               | JFK |
      | number of adults | 4   |
    When I select flights with price above 70 and continue to the booking page
    And I submit valid booking details
    Then confirmation page is displayed
