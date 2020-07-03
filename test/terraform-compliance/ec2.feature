Feature: EC2 should be  Compliant

Scenario Outline: Ensure that specific tags are defined
    Given I have resource that supports tags defined
    When it contains tags
    Then it must contain <tag-key>
    And its value must not be null

    Examples:
			| tag-key           |
			| Name  |
			| application       |
 
Scenario Outline: EBS should be encrypted
    Given I have aws_ebs_volume defined
    Then must contain encrypted
    Then its value must be true

Scenario Outline: EBS should be encrypted
    Given I have aws_ebs_volume defined
    Then must contain encrypted
    Then its value must be true

Scenario Outline: EC2 should not have public access
    Given I have aws_instance defined
    Then must contain associate_public_ip_address
    Then its value must be false

Scenario Outline: EC2 should not have public access
    Given I have aws_ebs_volume defined
    Then must contain associasizete_public_ip_address
    Then its value must be greater than 0

Scenario Outline: Well-known insecure protocol exposure on Public Network for ingress traffic
    Given I have AWS Security Group defined
  	When it contains ingress
    Then it must not have <proto> protocol and port <portNumber> for 0.0.0.0/0


  Examples:
    | ProtocolName | proto | portNumber |
    | HTTP         | tcp   | 443       |
    | Telnet       | tcp   | 23         |
    | SSH          | tcp   | 22         |
    | MySQL        | tcp   | 3306       |
    | MSSQL        | tcp   | 1443       |
    | NetBIOS      | tcp   | 139        |
    | RDP          | tcp   | 3389       |
    | Jenkins Slave| tcp   | 50000      |

Scenario: Only selected ports should be publicly open
    Given I have AWS Security Group defined
    When it contains ingress
    Then it must only have tcp protocol and port 22,443 for 0.0.0.0/0

Scenario Outline: Ensure our SG an Ingress policy
    Given I have AWS Security Group defined
    Then it must contain <policy_name>

  Examples:
    | policy_name |
    | ingress     |
