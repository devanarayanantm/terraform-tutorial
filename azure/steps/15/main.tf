#for_each with toset


# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {

#below is a set

  for_each = toset(["eastus", "eastus2", "westus"])
  name = "myrg-${each.value}" 
  location = each.key 
  # we can also use each.value as each.key = each.value in this case  
}