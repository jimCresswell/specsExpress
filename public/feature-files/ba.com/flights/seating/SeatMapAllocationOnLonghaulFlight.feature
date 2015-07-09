Feature: Seating Allocation on LongHaul flights in Prime selling Booking

  Based on customer type, departing date, cabin and flight
  As a ba.com business
  I want to provide the eligible seat (s) to the customer

  @wip @Example-PrimeSelling-SeatMap_Test
  Scenario: General Seats available for customer travelling in World Traveller Plus class
    Given I am Standard customer travelling in W class on boeing_747 aircraft
    When I proceed to view seat selection for my flight segment
    Then General seats are available in the flight


  @wip @Example-PrimeSelling-SeatMap-Time-bound_Test
  Scenario: General Seats available for customer travelling in World Traveller Plus class in next 15 days
    Given I am Standard customer travelling in J class on boeing_747 aircraft within next 15 days
    When I proceed to view seat selection for my flight segment
    Then General seats are available in the flight

