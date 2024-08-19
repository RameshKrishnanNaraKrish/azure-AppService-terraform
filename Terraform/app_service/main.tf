resource "azurerm_service_plan" "example" {
  name                = var.serviceplan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "main" {
  name                = var.appservice_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    app_command_line = ""
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_app_service_source_control" "main" {
  app_id     = azurerm_linux_web_app.main.id
  branch     = "main"
  repo_url   = "https://github.com/RameshKrishnanNaraKrish/static_website"
}
