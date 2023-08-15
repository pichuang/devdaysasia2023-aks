# Demo: Integrating Azure OpenAI and Azure Kubernetes Service to build Your Own Intelligent Apps

[![Run Azure Login with OpenID Connect](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/test-oidc-login.yml/badge.svg?branch=main)](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/test-oidc-login.yml)
[![Run the Demo Infrastructure](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/deploy-infra.yml/badge.svg?branch=main)](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/deploy-infra.yml)

- Last Updated: `20230816`
- STATUS: `WIP, DO NOT USE`
- TODO
  - [x] GitHub Workflow and Terraform setup
    - [x] [Use the Azure login action with OpenID Connect][9]
    - [x] Apply Terraform to create resource group via GitHub Workflows
    - [x] Destroy resource group via GitHub Workflows
  - [x] Create AKS
    - [x] VNET
    - [x] Public AKS
    - [x] Enable Azure Service Mesh
  - [ ] Surrounding Services
    - [ ] Azure Log Analytics Workspace
    - [ ] Azure Monitor managed service for Prometheus
    - [ ] Azure Managed Grafana
    - [ ] Azure OpenAI
  - [ ] Put a Customer GPT Service on AKS + GitOps
    - [x] Flux Podinfo
    - [x] Canary Deployment with Azure Service Mesh
    - [ ] AOAI Application

## Description

## Components Version

|                       Azure Service                      | Support Agreement |        Version       |
|:--------------------------------------------------------:|:-----------------:|:--------------------:|
| [Azure Kubernetes Service][6]                            | Preview           | 1.27.1               |
| [Azure Service Mesh (a.k.a Istio Service Mesh)][5]       | Preview           | 1.17                 |
| GitOps Flux v2                                           | GA                | v2.0.1               |
| [Azure Monitor managed service for Prometheus][4]        | GA                |                      |
| [Azure Managed Grafana][3]                               | GA                | v9.5.6 (859a2654d3)  |
| Azure AI services - Azure OpenAI (AOAI)                  | GA                | gpt-35-turbo (0301)  |

## Architecture

## References

- [pichuang/k8s-deployment-strategies-azure-edition][7]
- [terraform-github-actions/GitHub Actions Workflows for Terraform][8]
- [Use the Azure login action with OpenID Connect][9]
- [Using OIDC with Terraform in GitHub Actions][10]
- [stefanprodan/podinfo][10]

## Seminar Information

- Name: [DevDays Asia 2023](https://www.digitimes.com.tw/seminar/DevDaysAsia2023/en/agenda.html)
- Agenda: `Integrating Azure OpenAI and Azure Kubernetes Service to build Your Own Intelligent Apps`
- Spearker: Phil Huang @pichuang
- Date: `Wed., Sep. 13, 2023`

[1]: https://www.digitimes.com.tw/seminar/DevDaysAsia2023/en/agenda.html
[2]: https://github.com/grafana/grafana/blob/main/CHANGELOG.md#956-2023-07-11
[3]: https://learn.microsoft.com/en-us/azure/managed-grafana/
[4]: https://learn.microsoft.com/en-Us/azure/azure-monitor/essentials/prometheus-metrics-overview
[5]: https://learn.microsoft.com/en-us/azure/aks/istio-about
[6]: https://learn.microsoft.com/en-us/azure/aks/
[7]: https://github.com/pichuang/k8s-deployment-strategies-azure-edition
[8]: https://github.com/Azure-Samples/terraform-github-actions
[9]: https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-openid-connect
[10]: https://colinsalmcorner.com/using-oidc-with-terraform-in-github-actions/
[11]: https://github.com/stefanprodan/podinfo