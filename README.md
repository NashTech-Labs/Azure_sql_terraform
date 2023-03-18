# Azure_sql_terraform
This Terraform configuration defines the necessary resources to provision an Azure SQL Database. It creates a resource group to contain the SQL Server and database resources. It then provisions a SQL Server with a specified version, administrator login, and firewall rule to allow all connections to the server. After that, it creates a SQL Database with a specified edition, collation, and maximum size, as well as a requested service objective name.

Finally, the Terraform configuration outputs the connection string for the SQL Database, which can be used to connect to the database from other applications.

To use this Terraform configuration, you would need to replace the values for the name, location, administrator_login, and administrator_login_password parameters with your own values. You can also adjust the settings for the SQL Server and database resources to meet your specific requirements.