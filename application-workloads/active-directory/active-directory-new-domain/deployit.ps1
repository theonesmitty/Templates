$resourceGroupName = "bicepRG1"# + (Get-Random -Minimum 100 -Maximum 999)
$templatePath = "https://github.com/theonesmitty/Templates/blob/master/application-workloads/active-directory/active-directory-new-domain/azuredeploy.json"
#$paramsPath = "https://github.com/theonesmitty/Templates/blob/master/application-workloads/active-directory/active-directory-new-domain/azuredeploy.parameters.json"
#$templatePath = "./azuredeploy.json"
$paramsPath = "./azuredeploy.parameters.json"
$administratorLogin = "paulsmith"
$administratorLoginPassword = ConvertTo-SecureString 'Kapper99!!22' -AsPlainText -Force
$domainName = "smittynet589.net"
$dnsPrefix = "smittynet589"
$params = @{}
$params.Add("adminUsername", "paulsmith")
$params.Add("adminPassword", 'Kapper99!!22')
$params.Add("domainName", "smittynet589")
$params.Add("dnsPrefix", "smittynet589")

New-AzResourceGroup `
  -Name $resourceGroupName `
  -Location "westus3" `
  -Force

Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
-TemplateUri $templatePath `
-TemplateParameterObject $params 
<# -adminUsername $administratorLogin `
-adminPassword $administratorLoginPassword `
-domainName $domainName `
-dnsPrefix $dnsPrefix  #>

