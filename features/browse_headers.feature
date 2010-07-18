Feature: Browse Headers
  So that I can find headers of interest
  As Eve
  I want to browse headers to see what is available

  Background:
	Given the browse headers page exists and contains the browse headers portlet

  Scenario: Browse headers by type
	Given I have product types named Shawl and Scarf and Table Runner
	And I have the following headers
		| item number  | type         | published |
		| 001          | Shawl        | no        |
		| 002          | Shawl        | yes       |
		| 003          | Scarf        | no        |
		| 004          | Table Runner | yes       |
		| 005          | Shawl        | yes       |
		| 006          | Table Runner | yes       |
		| 007          | Table Runner | yes       |
	When I go to the browse headers page
	And I browse headers by type Shawl
	Then I should not see "001"
	And I should see "002"
	And I should not see "003"
	And I should not see "004"
	And I should see "005"
	And I should not see "006"
	And I should not see "007"
