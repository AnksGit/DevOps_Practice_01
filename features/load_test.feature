Feature: Load test 
 
 Scenario Outline: Load test API

  Given there are <users> users 
  And each user hit the <api> simultaniously
  Then each user should get a response within <max_time>

   Examples:
    |users |  api          | max_time |
    | 10   |  getcustomer  | 2000     |
