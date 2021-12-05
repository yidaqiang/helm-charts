# The Vista Library for Kubernetes

Popular applications, provided by Vista, ready to launch on Kubernetes using Kubernetes Helm.

## TL;DR

```bash
helm repo add vista https://chart.ydq.io
helm search repo vista
helm install my-release vista/<chart>
```

## Before you begin

### Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the Helm install guide and ensure that the helm binary is in the PATH of your shell.

### Add Repo

The following command allows you to download and install all the charts from this repository:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

### Using Helm

Once you have installed the Helm client, you can deploy a Bitnami Helm Chart into a Kubernetes cluster.

Please refer to the Quick Start guide if you wish to get running in just a few commands, otherwise the Using Helm Guide provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

Useful Helm Client Commands:

- View available charts: helm search repo
- Install a chart: helm install my-release bitnami/<package-name>
- Upgrade your application: helm upgrade

## License

Copyright (c) 2021-2021 Vista

Licensed under the GNU GENERAL PUBLIC LICENSE Version 3.
