targetScope = 'subscription'

param location string = deployment().location
param version string
param systemName string

resource targetResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: systemName
  location: location
  tags: {
    systemName: systemName
    infraVersion: version
  }
}

module resourcesModule 'resources.bicep' = {
  name: 'resourcesModule'
  scope: targetResourceGroup
  params: {
    location: location
    version: version
    systemName: systemName
  }
}
