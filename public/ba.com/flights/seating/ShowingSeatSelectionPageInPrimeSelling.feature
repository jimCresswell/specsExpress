Feature: Showing seat selection page in prime selling

  In order to sell more seats
  As a ba.com business
  I want to show paid for seats on a separate seat selection page

  @SeatingWithExtraCost_Premium_Economy_Booking_Test @Stubbed
  Scenario: Display seating on Seat Selection Page for Premium Economy Class Traveller on Multi carrier
    Given I travel as Standard and book my trip with:
      | From                   | LHR    |
      | To                     | BNE    |
      | Flight Class           | W      |
      | Ticket Type            | LOWEST |
      | Number Of Infant       | 0      |
    When I continue from booking passenger details
    Then seats are displayed with extra cost
    And I paid successfully and verified my booking

  @wip
  Scenario: Display seating on Seat Selection Page for Economy Class Traveller on Multi carrier
    Given I travel as Standard and book my trip with:
      | From                   | LHR    |
      | To                     | LIM    |
      | Flight Class           | M      |
      | Ticket Type            | LOWEST |
      | Number Of Infant       | 0      |
    When I continue from booking passenger details
    Then seats are displayed with extra cost

  @wip @FlightsWithConnectionByFlightOperator
  Scenario: Flight selection by given operator and
    Given I travel as Standard and book my trip with:
      | From            | LHR                |
      | To              | MEL                |
      | Flight Class    | M                  |
      | Ticket Type     | LOWEST             |
      | Flight Operator | Qantas Airways Ltd |

