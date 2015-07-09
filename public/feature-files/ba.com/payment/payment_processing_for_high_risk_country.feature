Feature: Payment processing for high risk countries

    System performs additional checks as a part of payment process for the booking from high risk countries

    In order to prevent fraud and money loss
    As a business owner
    I want to make additional checks when dealing with customers from high risk countries

  # Glossary
  #
  # High risk countries: Angola, Nigeria, Sierra Leone, Ghana, Jamaica

  @wip
  Scenario: Correct amount is charged based on fares selected
    Given I have added flights to the booking
    When I pay for the booking
    Then I am being charged the sum of all legs in the booking

  @wip @needsClarification
  Scenario: Block cards after 3 failed attempts
    Given I have added flights to my booking
    When I enter valid card number but other details are invalid
    And I try to submit this information more than 3 times
    Then I get an error message saying that my card is blocked

  @wip
  Scenario: Additional security checks are carried out when third party pays for the booking
    Given I have added flights to my booking
    When third party pays for my booking
    Then additional security checks are carried out

  @wip
  Scenario: High risk countries only allow secure online payment cards
    Given I depart from high risk country
    When I get to the payment page
    Then I am only offered secure online payment cards

  @wip
  Scenario: Error page displayed when trying to pay with non secure card when flying from high risk country
    Given I depart from high risk country
    When I pay for my booking using non secure online payment card
    Then I can't complete my booking