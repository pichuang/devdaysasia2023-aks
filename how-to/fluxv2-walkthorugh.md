# Flux v2 Walkthrough

```bash
$ wget https://github.com/fluxcd/flux2/releases/download/v2.0.1/flux_2.0.1_linux_amd64.tar.gz
flux_2.0.1_linux_amd64.tar.gz  100%[===================================================>]  18.06M  5.53MB/s    in 3.4s

$ tar zxvf flux_2.0.1_linux_amd64.tar.gz
flux

$ sudo install flux /usr/local/bin
$ kubectl cluster-info
Kubernetes control plane is running at https://xxxxxxxxxxxxxx.hcp.eastus2.azmk8s.io:443
CoreDNS is running at https://xxxxxxxxxxxxxx.hcp.eastus2.azmk8s.io:443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://xxxxxxxxxxxxxx.hcp.eastus2.azmk8s.io:443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

$ flux version
fluent-bit: 1.7.4
flux: v2.0.1
fluxconfig-agent: 1.7.4
fluxconfig-controller: 1.7.4
helm-controller: v0.31.2
kustomize-controller: v0.35.1
notification-controller: v0.33.0
source-controller: v0.36.1

$ flux check
► checking prerequisites
✔ Kubernetes 1.27.1 >=1.24.0-0
► checking controllers
✔ fluxconfig-agent: deployment ready
► mcr.microsoft.com/azurek8sflux/fluxconfig-agent:1.7.4
► mcr.microsoft.com/azurek8sflux/fluent-bit:1.7.4
✔ fluxconfig-controller: deployment ready
► mcr.microsoft.com/azurek8sflux/fluxconfig-controller:1.7.4
► mcr.microsoft.com/azurek8sflux/fluent-bit:1.7.4
✔ helm-controller: deployment ready
► mcr.microsoft.com/oss/fluxcd/helm-controller:v0.31.2
✔ kustomize-controller: deployment ready
► mcr.microsoft.com/oss/fluxcd/kustomize-controller:v0.35.1
✔ notification-controller: deployment ready
► mcr.microsoft.com/oss/fluxcd/notification-controller:v0.33.0
✔ source-controller: deployment ready
► mcr.microsoft.com/oss/fluxcd/source-controller:v0.36.1
► checking crds
✔ alerts.notification.toolkit.fluxcd.io/v1beta2
✔ buckets.source.toolkit.fluxcd.io/v1beta2
✔ fluxconfigs.clusterconfig.azure.com/v1alpha1
✔ gitrepositories.source.toolkit.fluxcd.io/v1beta2
✔ helmcharts.source.toolkit.fluxcd.io/v1beta2
✔ helmreleases.helm.toolkit.fluxcd.io/v2beta1
✔ helmrepositories.source.toolkit.fluxcd.io/v1beta2
✔ imagepolicies.image.toolkit.fluxcd.io/v1beta2
✔ imagerepositories.image.toolkit.fluxcd.io/v1beta2
✔ imageupdateautomations.image.toolkit.fluxcd.io/v1beta1
✔ kustomizations.kustomize.toolkit.fluxcd.io/v1beta2
✔ ocirepositories.source.toolkit.fluxcd.io/v1beta2
✔ providers.notification.toolkit.fluxcd.io/v1beta2
✔ receivers.notification.toolkit.fluxcd.io/v1beta2
✔ all checks passed

# https://fluxcd.io/flux/cheatsheets/troubleshooting/
$ kubectl get events -n flux-system --field-selector type=Warning
No resources found in flux-system namespace.

$ kubectl get kustomizations.kustomize.toolkit.fluxcd.io -A
NAMESPACE   NAME                  AGE   READY   STATUS
flux        flux-config-podinfo   27m   True    Applied revision: main@sha1:56de8967c251c692f1f2b34dadf945cdcf698b7c

$ kubectl get gitrepositories.source.toolkit.fluxcd.io -A
NAMESPACE   NAME          URL                                               AGE   READY   STATUS
flux        flux-config   https://github.com/pichuang/devdaysasia2023-aks   28m   True    stored artifact for revision 'main@sha1:56de8967c251c692f1f2b34dadf945cdcf698b7c'
```