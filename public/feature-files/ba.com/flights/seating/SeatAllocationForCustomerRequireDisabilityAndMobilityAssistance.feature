Feature: Seating allocation for customer requires disability and mobility assistance through manage my booking

  Based on customer disability and mobility assistance requirement
  As a ba.com business
  I want to provide the eligible seats displayed to the customer

  @Exit_Seat_Not_Available_Test
  Scenario: No Exit seat available for customer requires disability and mobility assistance
    Given A customer requires disability and mobility assistance
    When They view seat selection in manage my booking
    Then Exit seats are not available in the flight

  @Upper_Deck_Seat_Not_Available_Test
  Scenario: Seats accessible through staircase not available for a customer require special assistance
    Given A customer requires disability and mobility assistance
    When They view seat selection in manage my booking
    Then seats are not available in the flight upper deck

  @wip
  Scenario: Customer travelling with infant not eligible for exit row

  @wip
  Scenario: Customer travelling with infant can sit where additional oxygen masks are provided
