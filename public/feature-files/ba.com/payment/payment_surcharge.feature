Feature: Payment surcharge

    In order to neutralise cost of processing payment
    As a business owner
    I want to apply a surcharge to a booking based on payment type

  @wip
  Scenario: Surcharge is not applied when using payment registered in a country that does not attract payment surcharge
    Given I have payment card registered in a country that does not attract payment surcharge
    When I pay for my booking
    Then I am not charged payment surcharge

  @wip
  Scenario: Surcharge is applied when using payment registered in a country that does attract payment surcharge
    Given I have payment card registered in a country that does attract payment surcharge
    When I pay for my booking
    Then I am charged payment surcharge according to currency

  @wip
  Scenario: Bookings with avios do not attract payment surcharge
    Given I have a booking
    When I pay for it with avios points
    Then the payment surcharge is not being applied

  @wip
  Scenario: Changing billing country removes the surcharge
    Given I have flights departing surcharge attracting country in my booking
    And I select same country as my billing country
    When I change to another billing country
    Then surcharge is removed from my booking

  @wip
  Scenario: Changing billing country adds the surcharge
    Given I have flights departing surcharge attracting country in my booking
    And I select a different country as my billing country
    When I change billing country to my departure country
    Then surcharge is added to my booking