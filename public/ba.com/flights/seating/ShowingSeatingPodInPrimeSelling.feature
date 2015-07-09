Feature: Showing seating pod in prime seat selling

  In order to sell more seats
  As a ba.com business
  I want to show free seats on the passenger details page

  @Seating_Free_For_Economy_Selling_Class_Y_Booking
  Scenario: Seating is free for the Flexible booking on long haul flights
    Given I book my trip with:
      | From              | HKG |
      | To                | LHR |
      | Flight Class      | M   |
      | Ticket Type       | Y   |
      | number of infants | 0   |
    When I view my seat selection
    Then "GeneralSideSeat" the seats are available for free

  @Seating_Free_For_First_Class_Booking
  Scenario: Seating is free for the First class and Flexible Booking
    Given I book my trip with:
      | From              | NYC |
      | To                | LHR |
      | Flight Class      | F   |
      | Ticket Type       | F   |
      | number of infants | 0   |
    When I view my seat selection
    Then "GeneralSeat" the seats are available for free

  @Seating_Free_For_Customer_Travelling_With_Infant
  Scenario: Seating is free for the World Traveller Plus class booking customer travelling with Infant
    Given I book my trip with:
      | From              | LGW |
      | To                | MCO |
      | Flight Class      | W   |
      | Ticket Type       | E   |
      | number of infants | 1   |
    When I view my seat selection
    Then "GeneralSideSeat" the seats are available for free

  @wip
  Scenario: Seating pod displayed for Multiple carrier booking with eligible flight sector
    Given I travel as Standard and book my trip with:
      | From             | LHR      |
      | To               | DUR      |
      | Flight Class     | M        |
      | Ticket Type      | FLEXIBLE |
      | Number Of Infant | 0        |
    When I choose seat for my inbound segment
    Then Seating option is displayed

  @Seating_Pod_Displayed_For_Premier_Customer_Test @Stubbed
  Scenario: Seating pod displayed for Premier Customer
    Given I travel as Premier and book my trip with:
      | From             | LGW    |
      | To               | JER    |
      | Flight Class     | J      |
      | Ticket Type      | LOWEST |
      | Number Of Infant | 0      |
    When I choose seat for my inbound segment
    Then Seating option is displayed



