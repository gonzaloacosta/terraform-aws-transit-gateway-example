# Terraform AWS Transit Gateway example

## Scenarios

In this examples you are found two common scenario to manage AWS Transit Gateways.

1. [Scenario 1](./scenario_1)

- Objective

We will be route two different private networks from one origin vpc to another destination vpc in a common aws profile.

```tf
cd scenario_1/

terraform init
terraform apply
```

2. [Scenario 2](./scenario_2)

We will be route two different private networks from one origin vpc to another destination vpc in in different aws profiles using Resource Access Management (RAM) to share a Transit Gateway created in a Origin VPC

```tf
cd scenario_2/

terraform init
terraform apply
```

## Module example resources

Module will created examples resources:

- VPC
- 2 subnets (private and public)
- 1 instance in public subnet
- 1 instance in private subnet



