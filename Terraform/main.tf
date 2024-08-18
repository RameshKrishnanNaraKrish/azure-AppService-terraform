module "resource_group" {
  source = "./resource_group"
  
    resource_group_name = "${var.prefix}-resources"
    location = var.location

}


module "app_service" {
  source = "./app_service"
  
    appservice_name = "${var.prefix}-appservice"
    location            = module.resource_group.resource_group_location
    resource_group_name = module.resource_group.resource_group_name

}