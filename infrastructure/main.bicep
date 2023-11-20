targetScope = 'subscription'

param location string = deployment().location

var systemName = 'hexmaster-integration-environment'

resource targetResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: systemName
  location: location
}
