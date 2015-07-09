Feature: Accept payments for customer booking with additional products

  So that I can successfully pay together
  As a British Airways customer
  I want to book flight with additional products

  @wip
  Scenario: Booking with hotel
  Given I have flight and hotel booking
  When I pay for this booking
  Then payment goes through and confirmation page is displayed

  @wip
  Scenario: Booking with car
  Given I have flight and car booking
  When I pay for this booking
  Then payment goes through and confirmation page is displayed

  @wip
  Scenario: Booking with insurance
  Given I have flight and insurance booking
  When I pay for this booking
  Then payment goes through and confirmation page is displayed