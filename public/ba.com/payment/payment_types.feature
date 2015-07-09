Feature: Payment types

    In order to attract wide audience
    As a business owner
    I want to accept wide range of payment types

  @wip @needReview
  Scenario: Payment card types are offered when flying from / to low risk country
    Given I depart and arrive in a low risk country
    When I go to payment page
    Then I am offered following set of payment options:
      | Visa Debit       |
      | Visa Credit      |
      | Mastercard Debit |
      | Mastercard       |
      | Discover         |
      | Diners Club      |
      | America Express  |
      | Airplus/UATP     |
      
      @wip
      Scenario: Voucher payment
      
      @wip
      Scenario: Avios payment