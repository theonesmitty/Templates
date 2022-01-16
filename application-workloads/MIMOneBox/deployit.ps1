Get-AzResourceGroup | ? {$_.ResourceGroupName -like "bicep*"} | Remove-AzResourceGroup -force -AsJob
$Error.Clear()
$rnd = (Get-Random -Minimum 100 -Maximum 999)
$resourceGroupName = "bicepRG1" + $rnd
$domainPrefix = "smittynet1" + $rnd
$domainName = $domainPrefix + ".net"
$templatePath = "https://raw.githubusercontent.com/theonesmitty/Templates/master/application-workloads/MIMOneBox/x.json"
$administratorLogin = "paulsmith"
$administratorLoginPassword = ConvertTo-SecureString 'Kapper99!!22' -AsPlainText -Force

$params = @{}
$params.Add("adminUsername", $administratorLogin)
$params.Add("adminPassword", $administratorLoginPassword)
$params.Add("domainName", $domainName)
$params.Add("dnsPrefix", $domainPrefix)
#$params.Add("imageOffer", "SQL2016SP1-WS2016")

New-AzResourceGroup `
  -Name $resourceGroupName `
  -Location "westus3" `
  -Force

  $successfulTest = Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName $resourceGroupName `
  -TemplateUri $templatePath `
  -TemplateParameterObject $params `
  -Name ($resourceGroupName + "_Deployment") 

if ($successfulTest.Error -eq $null) {
  New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -TemplateUri $templatePath `
    -TemplateParameterObject $params `
    -Name ($resourceGroupName + "_Deployment") `
    -asJob
}
else {

  Remove-AzResourceGroup -AsJob  $resourceGroupName -Force 

}
Write-Host ($resourceGroupName + "_Deployment")
#Get-AzResourceGroup | ? {$_.ResourceGroupName -like "bicep*"} | Remove-AzResourceGroup -force -AsJob