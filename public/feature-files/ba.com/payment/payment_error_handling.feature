Feature: Payment error handling

  So that time is not wasted with bad requests to a bank
  As a British Airways customer
  I want my payment card details validated and to be provided with reasons for failure

  @wip
  Scenario: Incorrect card number

  @wip
  Scenario: Incorrect postal code

  @wip
  Scenario: Missing card expiry date

  @wip
  Scenario: Missing address

  @wip
  Scenario Outline: Incorrect security code
    Given I pay for my booking using <card>
    Examples:
      | card |
      | Visa |
      | Amex |