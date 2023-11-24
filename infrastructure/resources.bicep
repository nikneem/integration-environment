param systemName string
param location string
param version string

resource appConfiguration 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: '${systemName}-appcfg'
  location: location
  tags: {
    systemName: systemName
    infraVersion: version
  }
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
  name: uniqueString(systemName)
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

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: '${systemName}-kv'
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enabledForDeployment: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: true
    enableSoftDelete: false
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
  }
}

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: '${systemName}-log'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${systemName}-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    IngestionMode: 'LogAnalytics'
    WorkspaceResourceId: logAnalytics.id
  }
}
