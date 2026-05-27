#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HELM_RELEASE="${HELM_RELEASE:-monitoring}"
HELM_NAMESPACE="${HELM_NAMESPACE:-monitoring}"
HELM_CHART_VERSION="${HELM_CHART_VERSION:-83.6.0}"
WORKER_NODE_NAME="${WORKER_NODE_NAME:-}"
WORKER_SSH_TARGET="${WORKER_SSH_TARGET:-}"
PROMETHEUS_PVC_NAME="${PROMETHEUS_PVC_NAME:-prometheus-monitoring-kube-prometheus-prometheus-db-prometheus-monitoring-kube-prometheus-prometheus-0}"
GRAFANA_PVC_NAME="${GRAFANA_PVC_NAME:-monitoring-grafana}"
CONTROL_PLANE_LABEL_PRIMARY="node-role.kubernetes.io/control-plane"
CONTROL_PLANE_LABEL_FALLBACK="node-role.kubernetes.io/master"

usage() {
  cat <<'EOF'
Usage:
  scripts/reset-and-install-local-pv.sh --worker-node <k8s-node-name> --worker-ssh <user@host>

Required:
  --worker-node   Kubernetes worker node name to label with monitoring-storage=true
  --worker-ssh    SSH target for that same worker node, used to create local PV directories

Optional environment variables:
  HELM_RELEASE
  HELM_NAMESPACE
  HELM_CHART_VERSION
  PROMETHEUS_PVC_NAME
  GRAFANA_PVC_NAME

What the script does:
  1. Labels one worker node for local monitoring storage
  2. Creates /data/monitoring/grafana and /data/monitoring/prometheus on that worker over SSH
  3. Applies the local StorageClass and PersistentVolumes
  4. Uninstalls the existing Helm release if present
  5. Deletes the old Grafana and Prometheus PVCs if present
  6. Reapplies pre-install manifests
  7. Installs or upgrades kube-prometheus-stack
  8. Applies the demo ServiceMonitor
  9. Applies the kubeadm control plane scrape manifest
EOF
}

log() {
  printf '\n[%s] %s\n' "$(date +%H:%M:%S)" "$*"
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --worker-node)
      WORKER_NODE_NAME="${2:-}"
      shift 2
      ;;
    --worker-ssh)
      WORKER_SSH_TARGET="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$WORKER_NODE_NAME" || -z "$WORKER_SSH_TARGET" ]]; then
  usage
  exit 1
fi

require_cmd kubectl
require_cmd helm
require_cmd ssh
require_cmd sed

cd "$REPO_ROOT"

log "Creating monitoring namespace if needed"
kubectl create namespace "$HELM_NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

log "Labeling storage worker node"
kubectl label node "$WORKER_NODE_NAME" monitoring-storage=true --overwrite

log "Preparing local storage directories on worker $WORKER_SSH_TARGET"
ssh "$WORKER_SSH_TARGET" "sudo mkdir -p /data/monitoring/grafana /data/monitoring/prometheus && sudo chmod 777 /data/monitoring/grafana /data/monitoring/prometheus"

log "Applying local storage class and persistent volumes"
kubectl apply -f monitoring/storage/local-pv.yaml

log "Applying pre-install manifests"
kubectl apply -f monitoring/manifests/

log "Adding and updating Helm repository"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update prometheus-community

if helm status "$HELM_RELEASE" -n "$HELM_NAMESPACE" >/dev/null 2>&1; then
  log "Uninstalling existing Helm release $HELM_RELEASE"
  helm uninstall "$HELM_RELEASE" -n "$HELM_NAMESPACE"
fi

log "Deleting old PVCs if they exist"
kubectl delete pvc -n "$HELM_NAMESPACE" "$GRAFANA_PVC_NAME" --ignore-not-found=true
kubectl delete pvc -n "$HELM_NAMESPACE" "$PROMETHEUS_PVC_NAME" --ignore-not-found=true

log "Installing monitoring stack"
helm upgrade --install "$HELM_RELEASE" prometheus-community/kube-prometheus-stack \
  --namespace "$HELM_NAMESPACE" \
  --version "$HELM_CHART_VERSION" \
  -f monitoring/helm-values/kube-prometheus-stack-values.yaml

log "Applying post-install ServiceMonitor"
kubectl apply -f monitoring/post-install/

log "Resolving kubeadm control plane internal IP"
CONTROL_PLANE_IP="$(kubectl get node -l "${CONTROL_PLANE_LABEL_PRIMARY}" -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' 2>/dev/null || true)"
if [[ -z "$CONTROL_PLANE_IP" ]]; then
  CONTROL_PLANE_IP="$(kubectl get node -l "${CONTROL_PLANE_LABEL_FALLBACK}" -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')"
fi

if [[ -z "$CONTROL_PLANE_IP" ]]; then
  echo "Could not determine control plane internal IP from kubeadm node labels" >&2
  exit 1
fi

log "Applying kubeadm control plane scrape manifest for $CONTROL_PLANE_IP"
sed "s/KUBEADM_CONTROL_PLANE_IP/${CONTROL_PLANE_IP}/g" monitoring/kubeadm/kubeadm-control-plane-scrape.yaml | kubectl apply -f -

log "Current PVC status"
kubectl get pvc -n "$HELM_NAMESPACE"

log "Current PV status"
kubectl get pv

log "Current monitoring services"
kubectl get svc -n "$HELM_NAMESPACE" monitoring-grafana monitoring-kube-prometheus-prometheus

log "Install sequence completed"
