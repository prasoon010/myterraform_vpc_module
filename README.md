# myterraform_modules

Clone the repo to your terraform project folder using below command
```
$ git clone https://github.com/prasoon010/myterraform_vpc_module.git
```

Sample main.tf file to use the vpc module is given below
```
$cat main.tf

module "vpc" {
  source = "./myterraform_vpc_module/aws_vpc"

  project     = "moh" 
  environment = "dev"
  region      = "us-east-1"
  vpc_cidr    = "172.16.0.0/16"
  cidr_newbit = 5
  single_nat_gateway = true
  public_subnet = {
    name  = "dmz"
    count = 3
  }
  private1_subnet = {
    name  = "app-layer"
    count = 3
  }
  private2_subnet = {
    name  = "db-layer"
    count = 3
  }

}
```

# Variables:

project - enter your project name(string)

environment - enter your project environment name(string)

region - enter region where you want to provision the vpc(sting)

vpc_cidr - enter valid private cidr block(sting)

cidr_newbit - (number)
```
   eg: 
       if vpc cidr block is 172.16.0.0/16 and cidr_netbit is 5
       subnet cidr blocks will be 172.16.0.0/21, 172.16.8.0/21, 172.16.16.0/21 ...172.16.248.0/21 (total 16 subnet cidr blocks available)
       
       if vpc cidr block is 172.16.0.0/16 and cidr_netbit is 4
       subnet cidr blocks will be 172.16.0.0/20, 172.16.16.0/20, 172.16.32.0/20 .... 172.16.240.0/20 (total 16 subnet cidr bocks available)
```

single_nat_gateway - enable single az nat-gateway (bool)

*_subnet = {
    name  = "<desired name>"
    count = <number of subnet to create(bigger value limited by az)>
  }
  
 

Run using terraform init, plan, apply commands (make sure you have awscli configured in your machine. If you are using any custom awscli profile, you can mention variable "profile = <your profile name>" in the main.tf file, default profile is 'default'

```
Note: 
1. By default module creates multi-az nat-gateway, specify 'single_nat_gateway = true' explicitly in the main.tf file to create single-az nat-gateway
2. If you are using multi-az nat-gateway, make sure public_subnet count is set to a value greater than or equal to count of private1_subnet or private2_subnet(whichever is greater), else you will get error.
3. If you want to create public subnets only, set count for private subnets as zero(for two tier architecture, set private2_subnet count as zero if you need only public_subnet and private1_subnet)
4. You can use different vpc cidr block, subnets will get the cidr blocks automatically based on the cidr_netbit value   
5. Suppose if the you have entered a subnet count value greater than the availability zones in the region, the subnet creation count will be limited at the number of availability zone
```
