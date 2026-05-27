# Kubernetes Monitoring Demo with Prometheus and Grafana

This repository contains an end-to-end Kubernetes monitoring setup built around the Prometheus Community `kube-prometheus-stack` Helm chart.

It is designed for two goals:

1. Deploy Prometheus and Grafana quickly in a Kubernetes cluster.
2. Demonstrate cluster, node, pod, workload, and custom application metrics in front of an audience.

What is included:

- A pinned `kube-prometheus-stack` values file.
- Preloaded Grafana dashboards via ConfigMaps.
- A sample application that exposes Prometheus metrics.
- A post-install `ServiceMonitor` for the sample application.
- A `kubeadm` control plane scraping manifest for `etcd`, `kube-scheduler`, and `kube-controller-manager`.
- A reset/install script for the local-PV workflow.
- A step-by-step guide that the audience can repeat later.

## Repository Layout

- `monitoring/helm-values/kube-prometheus-stack-values.yaml`
- `monitoring/manifests/demo-app.yaml`
- `monitoring/post-install/demo-app-servicemonitor.yaml`
- `monitoring/storage/local-pv.yaml`
- `monitoring/manifests/grafana-dashboard-cluster-overview.yaml`
- `monitoring/manifests/grafana-dashboard-namespace-health.yaml`
- `monitoring/manifests/grafana-dashboard-workload-performance.yaml`
- `monitoring/kubeadm/kubeadm-control-plane-scrape.yaml`
- `scripts/reset-and-install-local-pv.sh`

## Quick Start

Follow the full runbook in [docs/END_TO_END_GUIDE.md](/Users/nareshwar/prom-grafana/docs/END_TO_END_GUIDE.md).

The short version is:

```bash
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

kubectl create namespace monitoring
kubectl apply -f monitoring/manifests/

kubectl label node WORKER_NODE_NAME monitoring-storage=true
kubectl apply -f monitoring/storage/local-pv.yaml

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --version 83.6.0 \
  -f monitoring/helm-values/kube-prometheus-stack-values.yaml

kubectl apply -f monitoring/post-install/

CONTROL_PLANE_IP=$(kubectl get node -l node-role.kubernetes.io/control-plane -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
sed "s/KUBEADM_CONTROL_PLANE_IP/${CONTROL_PLANE_IP}/g" monitoring/kubeadm/kubeadm-control-plane-scrape.yaml | kubectl apply -f -
```

Get a worker node external IP and open Grafana through the NodePort:

```bash
kubectl get nodes -o wide
```

Open `http://WORKER_NODE_EXTERNAL_IP:32000` and sign in with:

- User: `admin`
- Password: `prom-grafana-demo`

To run the full reset-and-install flow in one command:

```bash
chmod +x scripts/reset-and-install-local-pv.sh
./scripts/reset-and-install-local-pv.sh \
  --worker-node WORKER_NODE_NAME \
  --worker-ssh USER@WORKER_NODE_EXTERNAL_IP
```

## What Gets Scraped

This setup covers the standard metrics that are realistically available from inside most Kubernetes clusters:

- Kubernetes API server metrics
- Prometheus Operator metrics
- Prometheus metrics
- Alertmanager metrics
- Grafana metrics
- Node exporter metrics from every node
- Kube-state-metrics object state metrics
- Kubelet metrics
- cAdvisor container metrics
- `/metrics/probes` kubelet probe metrics
- Demo application metrics through a `ServiceMonitor`

Optional support is also included for:

- `kube-scheduler`
- `kube-controller-manager`
- `etcd`

For your `kubeadm` cluster, this repo includes a dedicated manifest to scrape those control plane targets from the single control-plane node.

## Notes

- The pinned `kube-prometheus-stack` chart version in this repo requires Kubernetes `1.25+`.
- The `kubeadm` control plane manifest assumes a `1 master / 2 worker` topology and a single control-plane node IP.
- Grafana is exposed on NodePort `32000` and Prometheus on NodePort `32090`.
- On GCP, allow inbound firewall access to TCP `32000` and `32090` to reach those services from your browser.
- Persistent storage uses static local PVs through the `local-monitoring` storage class.
- Label exactly one worker node with `monitoring-storage=true` and create `/data/monitoring/grafana` and `/data/monitoring/prometheus` on that node before install.
- “All metrics possible” in Kubernetes is not a literal guarantee. Some metrics are unavailable on managed control planes, disabled by security policy, or hidden behind vendor integrations.
- This repo aims for the broadest practical in-cluster coverage with a clean demo path.
