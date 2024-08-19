# resource "azurerm_service_plan" "example" {
#   name                = var.serviceplan_name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   os_type             = "Linux"
#   sku_name            = "S1"
# }

# resource "azurerm_linux_web_app" "main" {
#   name                = var.appservice_name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   service_plan_id     = azurerm_service_plan.example.id

#   site_config {
#     app_command_line = ""
#   }

#   app_settings = {
#     "WEBSITE_RUN_FROM_PACKAGE" = "1"
#   }
# }

# resource "azurerm_app_service_source_control" "main" {
#   app_id     = azurerm_linux_web_app.main.id
#   branch     = "main"
#   repo_url   = "https://github.com/RameshKrishnanNaraKrish/static_website"
# }

# resource "azurerm_source_control_token" "example" {
#   type  = "GitHub"
#   token = var.github_token
# }


resource "azurerm_storage_account" "main" {
  name                     = "tfappserrameshstorage"
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
    error_404_document = "404.html"
  }

  timeouts {
    create = "10m"
    delete = "10m"
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "https://github.com/RameshKrishnanNaraKrish/static_website/main/index.html"
}
