output "cli_kube_config" {

  value = "az aks get-credentials --resource-group rg-devdaysasia2023 --name aks-devdaysasia2023 --overwrite-existing"

}

output "cli_enable_port_forward" {
  value = "kubectl -n chatgpt-lite port-forward svc/chatgpt-lite 3000:3000"
}