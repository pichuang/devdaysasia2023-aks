# Demo: Integrating Azure OpenAI and Azure Kubernetes Service to build Your Own Intelligent Apps

- Last Updated: `20230814`
- STATUS: `WIP, DO NOT USE`
- TODO
  - [ ] GitHub Workflow and Terraform setup
    - [ ] [Use the Azure login action with OpenID Connect][9]
  - [ ] Create AKS and surrounding services
  - [ ] Put a Customer GPT Service on AKS + GitOps

## Description

## Components Version

|                       Azure Service                      | Support Agreement |        Version       |
|:--------------------------------------------------------:|:-----------------:|:--------------------:|
| [Azure Kubernetes Service][6]                            | GA                | 1.27.1               |
| [Azure Service Mesh (a.k.a Istio Service Mesh)][5]       | Preview           | 1.17                 |
| [Azure Monitor managed service for Prometheus][4]        | GA                |                      |
| [Azure Managed Grafana][3]                               | GA                | v9.5.6 (859a2654d3)  |
| Azure AI services - Azure OpenAI (AOAI)                  | GA                | gpt-35-turbo (0301)  |

## Architecture

## References

- [pichuang/k8s-deployment-strategies-azure-edition][7]
- [terraform-github-actions/GitHub Actions Workflows for Terraform][8]
- [Use the Azure login action with OpenID Connect][9]

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