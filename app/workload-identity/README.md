# Use a workload identity with an application on Azure Kubernetes Service (AKS)

- Deploy an AKS cluster using the Azure CLI with OpenID Connect (OIDC) Issuer and managed identity.
- Create an Azure Key Vault and secret.
- Create an Azure Active Directory (Azure AD) workload identity and Kubernetes service account.
- Configure the managed identity for token federation.
- Deploy the workload and verify authentication with the workload identity.

## Workload Identity and use Managed identity

Build KV based on this [article][3] and [Tutorial: Use a workload identity with an application on Azure Kubernetes Service (AKS)
][2]

```bash
#
# 2. Export environment variables
#
# environment variables for the Azure Key Vault resource
export KEYVAULT_NAME="kv-aoai-divecode"
export KEYVAULT_SECRET_NAME="secret-helloworld"
export KEYVAULT_RESOURCE_GROUP="rg-kv"
export AKS_RESOURCE_GROUP="rg-devdaysasia2023"
export AKS_CLUSTER_NAME="aks-devdaysasia2023"
export LOCATION="eastus2"

# environment variables for the AAD application
# [OPTIONAL] Only set this if you're using a Azure AD Application as part of this tutorial
export APPLICATION_NAME="sp-devdaysasia2023-aoai"

# environment variables for the user-assigned managed identity
# [OPTIONAL] Only set this if you're using a user-assigned managed identity as part of this tutorial
# export USER_ASSIGNED_IDENTITY_NAME="<your user-assigned managed identity name>"

# environment variables for the Kubernetes service account & federated identity credential
export SERVICE_ACCOUNT_NAMESPACE="default"
export SERVICE_ACCOUNT_NAME="sa-wi-aoai"
# Output the OIDC issuer URL
export SERVICE_ACCOUNT_ISSUER="$(az aks show --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --query oidcIssuerProfile.issuerUrl -otsv)"
echo "${SERVICE_ACCOUNT_ISSUER}"

#
# 3. Create an Azure Key Vault and secret
#
az group create --name "${KEYVAULT_RESOURCE_GROUP}" --location "${LOCATION}"
az keyvault create --resource-group "${KEYVAULT_RESOURCE_GROUP}" \
   --location "${LOCATION}" \
   --name "${KEYVAULT_NAME}"
az keyvault secret set --vault-name "${KEYVAULT_NAME}" \
   --name "${KEYVAULT_SECRET_NAME}" \
   --value "HelloWorld\!"

#
# 4. Create an AAD application or user-assigned managed identity and grant permissions to access the secret
#
az ad sp create-for-rbac --name "${APPLICATION_NAME}"
export APPLICATION_CLIENT_ID="$(az ad sp list --display-name "${APPLICATION_NAME}" --query '[0].appId' -otsv)"
export TENANT_ID="$(az ad sp list --display-name "${APPLICATION_NAME}" --query '[0].appOwnerOrganizationId' -otsv)"
az keyvault set-policy --name "${KEYVAULT_NAME}" \
 --secret-permissions get \
 --spn "${APPLICATION_CLIENT_ID}"

#
# 5. Create a Kubernetes service account
#
cat << EOF > sa.yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${SERVICE_ACCOUNT_NAME}
  namespace: ${SERVICE_ACCOUNT_NAMESPACE}
  annotations:
    azure.workload.identity/client-id: ${APPLICATION_CLIENT_ID:-$USER_ASSIGNED_IDENTITY_CLIENT_ID}
    azure.workload.identity/tenant-id: ${TENANT_ID}
EOF
cat sa.yaml
kubectl apply -f sa.yaml

kubectl get sa "${SERVICE_ACCOUNT_NAME}" -n "${SERVICE_ACCOUNT_NAMESPACE}" -o yaml

#
# 6. Establish federated identity credential between the identity and the service account issuer & subject
#
export APPLICATION_OBJECT_ID="$(az ad app show --id ${APPLICATION_CLIENT_ID} --query id -otsv)"
echo ${APPLICATION_OBJECT_ID}

cat << EOF > params.json
{
  "name": "kubernetes-federated-credential",
  "issuer": "${SERVICE_ACCOUNT_ISSUER}",
  "subject": "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:${SERVICE_ACCOUNT_NAME}",
  "description": "Kubernetes service account federated credential",
  "audiences": [
    "api://AzureADTokenExchange"
  ]
}
EOF

cat params.json

az ad app federated-credential create --id "${APPLICATION_OBJECT_ID}" --parameters @params.json
az ad app federated-credential list --id "${APPLICATION_OBJECT_ID}"

#
# 7. Deploy workload
#
export KEYVAULT_URL="$(az keyvault show -g ${KEYVAULT_RESOURCE_GROUP} -n ${KEYVAULT_NAME} --query properties.vaultUri -o tsv)"
echo ${KEYVAULT_URL}

cat << EOF > pod-quick-start.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: quick-start
  namespace: ${SERVICE_ACCOUNT_NAMESPACE}
  labels:
    azure.workload.identity/use: "true"
spec:
  serviceAccountName: ${SERVICE_ACCOUNT_NAME}
  containers:
    - image: ghcr.io/azure/azure-workload-identity/msal-python
      name: oidc
      env:
      - name: KEYVAULT_URL
        value: ${KEYVAULT_URL}
      - name: SECRET_NAME
        value: ${KEYVAULT_SECRET_NAME}
  nodeSelector:
    kubernetes.io/os: linux
EOF
cat pod-quick-start.yaml


cat << EOF > pod-jump.yaml
apiVersion: v1
kind: Pod
metadata:
  name: jump
  namespace: ${SERVICE_ACCOUNT_NAMESPACE}
spec:
  containers:
  - image: smallstep/step-cli
    name: step-cli
    command:
    - /bin/sh
    - -c
    - cat /var/run/secrets/tokens/test-token | step crypto jwt inspect --insecure
    volumeMounts:
    - mountPath: /var/run/secrets/tokens
      name: test-token
  serviceAccountName: ${SERVICE_ACCOUNT_NAME}
  volumes:
  - name: test-token
    projected:
      sources:
      - serviceAccountToken:
          path: test-token
          expirationSeconds: 3600
          audience: test
EOF
kubectl logs jump -n ${SERVICE_ACCOUNT_NAMESPACE} | jq -r '.payload.iss'
```

[2]: https://learn.microsoft.com/en-us/azure/aks/learn/tutorial-kubernetes-workload-identity
[3]: https://azure.github.io/azure-workload-identity/docs/quick-start.html#5-create-a-kubernetes-service-account
