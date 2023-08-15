# How to Create Service Principle


```bash
az cloud set --name AzureChinaCloud
az login
az account set --subscription="20000000-0000-0000-0000-000000000000"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/20000000-0000-0000-0000-000000000000" -n sp-devdaysasia2023
```

Expected Output:

```dotnetcli
$ az ad sp create-for-rbac --role="Contributor" -n sp-devdaysasia2023 --scopes="/subscriptions/20000000-0000-0000-0000-000000000000"
Creating 'Contributor' role assignment under scope '/subscriptions/20000000-0000-0000-0000-000000000000'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "yyyyyyyyyyy",
  "displayName": "sp-devdaysasia2023",
  "password": "xxxxxxxxxxxxxxxx",
  "tenant": "zzzzzzzzzzzz"
}
``````

## Variable Mapping

| GitHub Action Secrets | Azure Service Principle | Value |
|----------------|-------------------------|-------|
| AZURE_CLIENT_ID | appId | yyyyyyyyyyy |
| AZURE_SUBSCRIPTION_ID | subscriptionId | 20000000-0000-0000-0000-000000000000 |
| AZURE_CLIENT_SECRET | password | xxxxxxxxxxxxxxxx |
| AZURE_TENANT_ID | tenant | zzzzzzzzzzzz |

![](/images/env-secrets.png)

## References

- [azurerm - Azure Provider: Authenticating using a Service Principal with a Client Secret][1]

[1]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret