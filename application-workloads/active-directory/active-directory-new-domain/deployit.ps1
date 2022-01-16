$resourceGroupName = "bicepRG" + (Get-Random -Minimum 100 -Maximum 999)
$templatePath = "./azuredeploy.json"
$paramsPath = "./azuredeploy.parameters.json"
$administratorLogin = "paulsmith"
$administratorLoginPassword = ConvertTo-SecureString 'Kapper99!!22' -AsPlainText -Force
$domainName = "smittynet589.net"
$dnsPrefix = "smittynet589"

New-AzResourceGroup `
  -Name $resourceGroupName `
  -Location "westus3"

Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
-TemplateFile $templatePath `
-TemplateParameterFile $paramsPath `
-adminUsername $administratorLogin `
-adminPassword $administratorLoginPassword `
-domainName $domainName `
-dnsPrefix $dnsPrefix