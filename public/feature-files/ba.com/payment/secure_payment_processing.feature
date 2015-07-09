Feature: Secure online payment

  In order to mitigate fraud risk
  As a business owner
  I want customers to feel safe and secure when using ba.com 

  @wip
  Scenario: Secure online payment cards display security frame before taking payments
    Given I have added flights to the booking
    When I pay for the booking with secure online payment card
    Then user is prompted to authenticate with their bank before payment is taken

  @wip
  Scenario: On failure to authenticate with the bank, we will display unable to process the payment page
    Given I have added flights to the booking
    When I pay with secure online payment card
    And I fail to authenticate with my bank
    Then I am presented with "We are unable to process the payment" error page