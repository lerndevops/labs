# End-to-End Guide: Prometheus + Grafana on Kubernetes

This guide deploys Prometheus and Grafana into a Kubernetes cluster, configures Prometheus to scrape a broad set of Kubernetes metrics, and provisions Grafana dashboards ready for a live demonstration.

This version of the guide is tuned for a self-managed `kubeadm` cluster with `1` control-plane node and `2` worker nodes.
It also assumes the cluster nodes are GCP VMs, so Grafana and Prometheus are exposed using `NodePort` instead of `kubectl port-forward`.

## 1. What You Will Deploy

You will install:

- `Prometheus Operator`
- `Prometheus`
- `Alertmanager`
- `Grafana`
- `kube-state-metrics`
- `prometheus-node-exporter`

You will also apply:

- Three custom Grafana dashboards
- One sample metrics-producing application
- One post-install `ServiceMonitor` for custom app scraping
- One `kubeadm` control plane scrape manifest for `etcd`, `kube-scheduler`, and `kube-controller-manager`

## 2. Prerequisites

You need the following on your machine:

- `kubectl`
- `helm` 3.x
- Access to a Kubernetes cluster running Kubernetes `1.25+`

Quick Helm install if Helm is not already present:

```bash
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

Check access first:

```bash
kubectl cluster-info
kubectl get nodes
helm version
```

## 3. Files in This Repository

Main files:

- [README.md](/Users/nareshwar/prom-grafana/README.md)
- [monitoring/helm-values/kube-prometheus-stack-values.yaml](/Users/nareshwar/prom-grafana/monitoring/helm-values/kube-prometheus-stack-values.yaml)
- [monitoring/manifests/demo-app.yaml](/Users/nareshwar/prom-grafana/monitoring/manifests/demo-app.yaml)
- [monitoring/post-install/demo-app-servicemonitor.yaml](/Users/nareshwar/prom-grafana/monitoring/post-install/demo-app-servicemonitor.yaml)
- [monitoring/manifests/grafana-dashboard-cluster-overview.yaml](/Users/nareshwar/prom-grafana/monitoring/manifests/grafana-dashboard-cluster-overview.yaml)
- [monitoring/manifests/grafana-dashboard-namespace-health.yaml](/Users/nareshwar/prom-grafana/monitoring/manifests/grafana-dashboard-namespace-health.yaml)
- [monitoring/manifests/grafana-dashboard-workload-performance.yaml](/Users/nareshwar/prom-grafana/monitoring/manifests/grafana-dashboard-workload-performance.yaml)
- [monitoring/kubeadm/kubeadm-control-plane-scrape.yaml](/Users/nareshwar/prom-grafana/monitoring/kubeadm/kubeadm-control-plane-scrape.yaml)
- [scripts/cleanup.sh](/Users/nareshwar/prom-grafana/scripts/cleanup.sh)

## 4. Why This Approach

This setup uses the Prometheus Community `kube-prometheus-stack` chart because it already packages the standard Kubernetes monitoring stack and Prometheus Operator integration.

As of the latest chart package listing I verified, `kube-prometheus-stack` version `83.6.0` is available as an OCI/package release from the Prometheus Community charts package registry.

## 5. Create the Monitoring Namespace

```bash
kubectl create namespace monitoring
```

If it already exists, Kubernetes will report that and continue safely.

## 6. Apply the Pre-Install Manifests

Apply all repository manifests first:

```bash
kubectl apply -f monitoring/manifests/
```

This creates:

- Grafana dashboard ConfigMaps
- A sample application in the `demo-metrics` namespace
- The sample application Service

This step is safe before Helm install because it does not create any CRD-backed objects.

Verify:

```bash
kubectl get ns monitoring demo-metrics
kubectl -n demo-metrics get deploy,svc
```

## 7. Add the Helm Repository

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

Optional verification:

```bash
helm search repo prometheus-community/kube-prometheus-stack --versions | head
```

## 8. Install the Monitoring Stack

Install the pinned chart:

```bash
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --version 83.6.0 \
  -f monitoring/helm-values/kube-prometheus-stack-values.yaml
```

This guide pins the version deliberately so the audience runs the same chart layout.
Grafana and Prometheus persistence are disabled in this demo setup, so no PVs or storage classes are required.

## 9. Apply the Post-Install ServiceMonitor

Now that the Prometheus Operator CRDs exist, apply the demo application `ServiceMonitor`:

```bash
kubectl apply -f monitoring/post-install/
```

Verify:

```bash
kubectl -n demo-metrics get servicemonitor
```

## 10. Apply the `kubeadm` Control Plane Scrape Manifest

Your `kubeadm` control plane usually runs `etcd`, `kube-scheduler`, and `kube-controller-manager` as static pods on the control-plane node. Those metrics are worth scraping explicitly for a demo.

Get the single control-plane node internal IP:

```bash
kubectl get node -l node-role.kubernetes.io/control-plane -o wide
```

If your cluster still uses the older node label, use this instead:

```bash
kubectl get node -l node-role.kubernetes.io/master -o wide
```

Export it into a shell variable:

```bash
CONTROL_PLANE_IP=$(kubectl get node -l node-role.kubernetes.io/control-plane -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
echo "$CONTROL_PLANE_IP"
```

Fallback for older clusters:

```bash
CONTROL_PLANE_IP=$(kubectl get node -l node-role.kubernetes.io/master -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
echo "$CONTROL_PLANE_IP"
```

Apply the manifest after replacing the placeholder:

```bash
sed "s/KUBEADM_CONTROL_PLANE_IP/${CONTROL_PLANE_IP}/g" monitoring/kubeadm/kubeadm-control-plane-scrape.yaml | kubectl apply -f -
```

This creates headless Services, Endpoints, and `ServiceMonitor` objects for:

- `kube-scheduler`
- `kube-controller-manager`
- `etcd`

Verify:

```bash
kubectl -n kube-system get svc,endpoints | grep -E 'kube-scheduler-external|kube-controller-manager-external|etcd-external'
kubectl -n monitoring get servicemonitor
```

## 11. Wait for the Pods

```bash
kubectl -n monitoring get pods -w
```

Wait until the main components are `Running`:

- `monitoring-grafana`
- `prometheus-monitoring-kube-prometheus-prometheus-0`
- `alertmanager-monitoring-kube-prometheus-alertmanager-0`
- `monitoring-kube-state-metrics`
- `monitoring-prometheus-node-exporter-*`
- `monitoring-kube-prometheus-operator-*`

## 12. Confirm the NodePort Services

This repo exposes:

- Grafana on NodePort `32000`
- Prometheus on NodePort `32090`

Verify:

```bash
kubectl -n monitoring get svc monitoring-grafana monitoring-kube-prometheus-prometheus
```

Expected service types:

- `monitoring-grafana` -> `NodePort`
- `monitoring-kube-prometheus-prometheus` -> `NodePort`

If you are using GCP VMs, make sure your VPC firewall allows inbound TCP:

- `32000`
- `32090`

Then get a reachable node IP:

```bash
kubectl get nodes -o wide
```

Use a worker node external IP if available, or another reachable node IP from your network path.

## 13. Verify Prometheus Targets

Open Prometheus in your browser:

```bash
http://WORKER_NODE_EXTERNAL_IP:32090/targets
```

Expected healthy targets usually include:

- `kube-state-metrics`
- `node-exporter`
- `prometheus`
- `alertmanager`
- `grafana`
- `kubelet`
- `apiserver`
- `prometheus-operator`
- `prometheus-example-app`
- `kube-scheduler-external`
- `kube-controller-manager-external`
- `etcd-external`

On your `kubeadm` cluster, the three control-plane targets above should appear after the manifest from step 10 is applied.

## 14. Open Grafana

Open Grafana in your browser:

```bash
http://WORKER_NODE_EXTERNAL_IP:32000
```

Login:

- Username: `admin`
- Password: `prom-grafana-demo`

## 15. Verify the Dashboards

In Grafana, open:

- `Kubernetes Cluster Overview`
- `Kubernetes Namespace Health`
- `Kubernetes Workload Performance`

You will also see the upstream dashboards that ship with the chart.

## 16. Demo Flow for an Audience

Use this order in a live demonstration:

1. Show cluster nodes in `kubectl get nodes`.
2. Show the NodePort services with `kubectl -n monitoring get svc`.
3. Show Prometheus targets in `http://WORKER_NODE_EXTERNAL_IP:32090/targets`.
4. Point out the control-plane targets `etcd-external`, `kube-scheduler-external`, and `kube-controller-manager-external`.
5. Open `Kubernetes Cluster Overview` to explain cluster-wide CPU, memory, and pod counts.
6. Open `Kubernetes Namespace Health` to compare namespaces.
7. Open `Kubernetes Workload Performance` to explain pod/container resource usage.
8. Show the `demo-metrics` namespace and the sample application.
9. In Prometheus, query:
   - `up`
   - `kube_pod_status_phase`
   - `rate(container_cpu_usage_seconds_total[5m])`
   - `container_memory_working_set_bytes`
   - `rate(scheduler_pod_scheduling_attempts_count[5m])`
   - `etcd_mvcc_db_total_size_in_bytes`
   - `http_requests_total{job="prometheus-example-app"}`

## 17. `kubeadm` Notes for 1 Master and 2 Workers

This repository already fits your `1` control-plane and `2` worker topology.

- `prometheus-node-exporter` runs as a DaemonSet and will cover all three nodes.
- `kube-state-metrics`, Prometheus Operator, Grafana, Prometheus, and Alertmanager run as standard workloads and do not require a dedicated change for two workers.
- The only cluster-specific input you must provide is the control-plane node IP in the `kubeadm` scrape manifest.
- Because the cluster is on GCP VMs, this repo exposes Grafana and Prometheus with `NodePort` so they are reachable without SSH tunneling or local port-forwarding.
- Because persistence is disabled, a pod restart clears Prometheus data and Grafana local state.

If later you move to a highly available `kubeadm` control plane, extend:

- [monitoring/kubeadm/kubeadm-control-plane-scrape.yaml](/Users/nareshwar/prom-grafana/monitoring/kubeadm/kubeadm-control-plane-scrape.yaml)

Add more control-plane IPs under each `Endpoints` object.

## 18. Troubleshooting

If Grafana is up but dashboards show no data:

```bash
kubectl -n monitoring get servicemonitor
kubectl -n monitoring get prometheus
kubectl -n monitoring logs deploy/monitoring-kube-prometheus-operator
```

If the browser cannot reach Grafana or Prometheus:

```bash
kubectl -n monitoring get svc monitoring-grafana monitoring-kube-prometheus-prometheus
kubectl get nodes -o wide
```

Then verify the GCP firewall allows inbound TCP `32000` and `32090` to the node you are using.

If `etcd`, scheduler, or controller-manager targets are missing:

```bash
echo "$CONTROL_PLANE_IP"
kubectl -n kube-system get endpoints kube-scheduler-external kube-controller-manager-external etcd-external
kubectl -n kube-system get pods -o wide
```

On `kubeadm`, verify the control plane pods are present on the control-plane node and that their metric ports are reachable.

If the sample application does not appear in Prometheus targets:

```bash
kubectl -n demo-metrics get pod,svc,servicemonitor
kubectl -n demo-metrics describe servicemonitor prometheus-example-app
```

If Prometheus pods stay pending:

```bash
kubectl -n monitoring describe pod prometheus-monitoring-kube-prometheus-prometheus-0
```

## 19. Cleanup

To remove everything from this repository:

```bash
chmod +x scripts/cleanup.sh
./scripts/cleanup.sh
```

The script:

- resolves the kubeadm control-plane IP automatically when possible
- removes the control-plane scrape resources
- uninstalls the Helm release
- deletes the manifest objects from this repo
- deletes the `monitoring` and `demo-metrics` namespaces

If you also want to remove the Prometheus Operator CRDs:

```bash
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd scrapeconfigs.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
```

Do not remove CRDs if another Prometheus Operator installation still uses them.
