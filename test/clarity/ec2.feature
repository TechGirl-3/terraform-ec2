Feature: EC2 instance should be compliant

  #Feature
  Scenario: EC2 should have encrypted EBS volume attached
    Given Terraform
    And a "aws_ebs_volume" of type "resource"
    Then attribute "encrypted" equals "true"

  #Compliance
  Scenario: EC2 should have tags
    Given Terraform
    And a "aws_instance" of type "resource"
    And "our component is <component>"
    When attribute "tags" exists
    Then attribute "tags" matches regex "<tag-key>.*"
    And attribute "tags" matches regex "<tag-key>.*"

    Examples:
    | tag-key | component |
    | Name   | aws_instance      |
    | application   | aws_instance      |
    | test | aws_instance |


  #Security
  Scenario: Security Group
    Given Terraform
    And a "aws_security_group" of type "resource"
    And "our component is <component>"
    When attribute "ingress" exists
    Then attribute "ingress" matches regex "from_port.*<port>"
    Then attribute "ingress" matches regex "to_port.*<port>"

    Examples:
    | port | component |
    | 22   | aws_security_group       |
    | 80   | aws_security_group       |


  #Security
  Scenario: EC2 should not have public access
    Given Terraform
    And a "aws_instance" of type "resource"
    When attribute "associate_public_ip_address" exists
    Then attribute "associate_public_ip_address" equals "false"

  #Feature
  Scenario: Valid value for EBS volume
    Given Terraform
    And a "aws_ebs_volume" of type "resource"
    When attribute "size" exists
    Then attribute "size" is always greater than 0
