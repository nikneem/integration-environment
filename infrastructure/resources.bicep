param systemName string
param location string

var safeName = replace(systemName, '-', '')

resource appConfiguration 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: '${systemName}-appcfg'
  location: location
  sku: {
    name: 'Free'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    createMode: 'Default'
    enablePurgeProtection: false
  }
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: '${safeName}acr'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: false
    publicNetworkAccess: 'Enabled'
  }
}
