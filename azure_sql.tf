# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group for the SQL Database
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "eastus"
}

# Create a SQL Server
resource "azurerm_sql_server" "server" {
  name                         = "my-sql-server"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "password"

  tags = {
    environment = "dev"
  }
}

# Create a firewall rule to allow connections to the SQL Server
resource "azurerm_sql_firewall_rule" "rule" {
  name                = "allow-all"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

# Create a SQL Database
resource "azurerm_sql_database" "db" {
  name                = "my-sql-database"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 1
  requested_service_objective_name = "S0"
}

# Output the connection string for the SQL Database
output "connection_string" {
  value = "Server=tcp:${azurerm_sql_server.server.fqdn},1433;Database=${azurerm_sql_database.db.name};User ID=${azurerm_sql_server.server.administrator_login}@${azurerm_sql_server.server.name};Password=${azurerm_sql_server.server.administrator_login_password};Encrypt=true;Connection Timeout=30;"
}
