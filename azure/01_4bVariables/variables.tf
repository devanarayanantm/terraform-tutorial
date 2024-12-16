variable "resource_group_name" {
  type = string
  
  #type: the type of the variable.  others can access like var.resource_group_name.type
  #description: description of the variable. others can access like var.resource_group_name.description
  #default default value. others can access like var.resource_group_name
  #This content could be inside the same .tf file.
  #If you skip default value in the variable, you may be forced to enter while execture the terraform apply
  
  #terraform.tfvars will be auto loaded for variables.
  #Alterntively <anything>.auto.tfvars will also be autoloaded but not <anything>.tfvars
}