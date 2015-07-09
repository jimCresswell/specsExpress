Feature: Seating in Manage My Booking

  As I BA.com customer
  I want to be able to manage my seats through manage my booking application
  So that I can reserve and manage my seats

  @Fully_Flexible_Customer_Seating_Test @Stubbed
  Scenario: As a Fully Flexible class customer reserve any seat for free
    Given I travel as Standard Flexible F class customer accessing my booking summary page
    When I view seat selection for my outbound segment
    Then All seats available with "no extra" cost

  @Restricted_Class_Customer_Seating_Test @Stubbed
  Scenario: As a Restricted class (M Cabin) customer reserve any seat with extra cost
    Given I travel as Standard restricted M class customer accessing my booking summary page
    When I view seat selection for my inbound segment
    Then All seats available with "extra" cost

  @HandBaggageOnly_Customer_Seating_Test @Stubbed
  Scenario: Hand Baggage Only Booking customer can reserve seat with extra cost
    Given I travel as Standard Flexible HandBaggage class customer accessing my booking summary page
    When I view seat selection for my inbound segment
    Then All seats available with "extra" cost

  @Mobile
  Scenario: As a Fully Flexible Class Customer Choose My Seat
    Given I travel as Standard Flexible A class customer accessing my booking summary page
    When I view seat selection for my inbound segment
    Then All seats available with "no extra" cost

  @Mobile @wip @example
  Scenario: As an economy class customer reserve my seat with extra cost
    Given I travel as Standard restricted O class customer accessing my booking summary page
    When I view seat selection for my inbound segment
    Then All seats available with "extra" cost




