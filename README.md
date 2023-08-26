# Demo: Integrating Azure OpenAI and Azure Kubernetes Service to build Your Own Intelligent Apps

[![Run Azure Login with OpenID Connect](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/test-oidc-login.yml/badge.svg?branch=main)](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/test-oidc-login.yml)
[![Run the Demo Infrastructure](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/deploy-infra.yml/badge.svg?branch=main)](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/deploy-infra.yml)
[![Static Code Analysis](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/static-code-analysis.yaml/badge.svg)](https://github.com/pichuang/devdaysasia2023-aks/actions/workflows/static-code-analysis.yaml)

- Last Updated: `20230826`
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
  - [x] Surrounding Services
    - [x] Azure Log Analytics Workspace
    - [x] Azure Monitor managed service for Prometheus
    - [x] Azure Managed Grafana
    - [x] Azure OpenAI (AOAI): The service should be provisioned by manual, and get the API key
    - [x] Workload Identiy with OIDC
    - [x] Azure Key Vault Secret Provider
  - [x] Put a Customer GPT Service on AKS + GitOps
    - [x] Flux Podinfo
    - [x] Canary Deployment with Azure Service Mesh
    - [x] AOAI Application: [pichuang/chatgpt-lite][17]
  - [x] Static Code Analysis
    - [x] [aquasecurity/tfsec][22]: Security scanner for your Terraform code
    - [x] [stackrox/kube-linter][23]: Static analysis tool that checks Kubernetes YAML files and Helm charts to ensure the applications represented in them adhere to best practices.
    - [x] [Microsoft Security DevOps GitHub action][24]

## Prerequisites

- Create a new Resource Group
- Setup a Storage Account for Terraform State
- Setup

## Components Version

|                       Azure Service                      | Support Agreement |        Version       |
|:--------------------------------------------------------:|:-----------------:|:--------------------:|
| [Azure Kubernetes Service][6]                            | [GA][19]          | 1.27.3               |
| [Azure Service Mesh (a.k.a Istio Service Mesh)][5]       | Preview           | 1.17                 |
| GitOps Flux v2                                           | GA                | v2.0.1               |
| [Azure Monitor managed service for Prometheus][4]        | GA                |                      |
| [Azure Managed Grafana][3]                               | GA                | v9.5.6 (859a2654d3)  |
| Azure AI services - Azure OpenAI (AOAI)                  | GA                | gpt-35-turbo (0301)  |
| Azure Key Vault Secrets Provider                         | GA                |                      |
| [Microsoft Defender for Cloud - DevOps security][25]     | Preview           | v1.7.2               |

| OSS Project | Version |
|:-----------:|:-------:|
| blrchen/chatgpt-lite | latest |
| aquasecurity/tfsec | lastet (v.1.28.1) |
| stackrox/kube-linter | v1.0.4 |

## Architecture

## References

- [pichuang/k8s-deployment-strategies-azure-edition][7]
- [terraform-github-actions/GitHub Actions Workflows for Terraform][8]
- [Use the Azure login action with OpenID Connect][9]
- [Using OIDC with Terraform in GitHub Actions][10]
- [stefanprodan/podinfo][10]
- [microsoft/sample-app-aoai-chatGPT][12]
- [Microsft Build: Integrating Azure AI and Azure Kubernetes Service to build intelligent apps][13]
- [k8sgpt-ai/k8sgpt][14]
- [Empowering AI: Building and Deploying Azure AI Landing Zones with Terraform][15]
- [Building a Private ChatGPT Interface With Azure OpenAI][16]
- [mckaywrigley/chatbot-ui][17]
- [flux/mozilla-sops/#azure][18]
- [Yidadaa/ChatGPT-Next-Web][20]
- [External Secrerts Operator - GitOps using FluxCD][21]

## Seminar Information

- Name: [DevDays Asia 2023](https://www.digitimes.com.tw/seminar/DevDaysAsia2023/en/agenda.html)
- Agenda: `Integrating Azure OpenAI and Azure Kubernetes Service to build Your Own Intelligent Apps`
- Spearker: Phil Huang @pichuang
- Date: `Wed., Sep. 13, 2023`

![DevDays Asia 2023](/images/event.jpeg)

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
[12]: https://github.com/microsoft/sample-app-aoai-chatGPT
[13]: https://build.microsoft.com/en-US/sessions/84b5c64f-6cb7-48b1-8f18-25f63405b965?source=sessions
[14]: https://github.com/k8sgpt-ai/k8sgpt
[15]: https://techcommunity.microsoft.com/t5/azure-architecture-blog/empowering-ai-building-and-deploying-azure-ai-landing-zones-with/ba-p/3891249
[16]: https://techcommunity.microsoft.com/t5/azure-architecture-blog/building-a-private-chatgpt-interface-with-azure-openai/ba-p/3869522
[17]: https://github.com/pichuang/chatgpt-lite
[18]: https://fluxcd.io/flux/guides/mozilla-sops/#azure
[19]: https://azure.microsoft.com/en-us/updates/generally-available-kubernetes-127-support-in-aks/
[20]: https://github.com/Yidadaa/ChatGPT-Next-Web
[21]: https://external-secrets.io/latest/examples/gitops-using-fluxcd/
[22]: https://github.com/aquasecurity/tfsec
[23]: https://github.com/stackrox/kube-linter
[24]: https://learn.microsoft.com/en-us/azure/defender-for-cloud/github-action
[25]: https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-devops-introduction