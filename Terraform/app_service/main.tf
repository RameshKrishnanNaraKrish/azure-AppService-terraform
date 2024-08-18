resource "azurerm_static_web_app" "example" {
  name                = var.appservice_name
  resource_group_name = var.resource_group_name
  location            = var.location
}