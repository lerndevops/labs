#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HELM_RELEASE="${HELM_RELEASE:-monitoring}"
HELM_NAMESPACE="${HELM_NAMESPACE:-monitoring}"
DEMO_NAMESPACE="${DEMO_NAMESPACE:-demo-metrics}"
CONTROL_PLANE_LABEL_PRIMARY="node-role.kubernetes.io/control-plane"
CONTROL_PLANE_LABEL_FALLBACK="node-role.kubernetes.io/master"

log() {
  printf '\n[%s] %s\n' "$(date +%H:%M:%S)" "$*"
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_cmd kubectl
require_cmd helm
require_cmd sed

cd "$REPO_ROOT"

CONTROL_PLANE_IP="$(kubectl get node -l "${CONTROL_PLANE_LABEL_PRIMARY}" -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' 2>/dev/null || true)"
if [[ -z "$CONTROL_PLANE_IP" ]]; then
  CONTROL_PLANE_IP="$(kubectl get node -l "${CONTROL_PLANE_LABEL_FALLBACK}" -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' 2>/dev/null || true)"
fi

if [[ -n "$CONTROL_PLANE_IP" ]]; then
  log "Deleting kubeadm control plane scrape resources for $CONTROL_PLANE_IP"
  sed "s/KUBEADM_CONTROL_PLANE_IP/${CONTROL_PLANE_IP}/g" monitoring/kubeadm/kubeadm-control-plane-scrape.yaml | kubectl delete -f - --ignore-not-found=true
else
  log "Skipping kubeadm control plane scrape cleanup because control plane IP could not be resolved"
fi

if helm status "$HELM_RELEASE" -n "$HELM_NAMESPACE" >/dev/null 2>&1; then
  log "Uninstalling Helm release $HELM_RELEASE"
  helm uninstall "$HELM_RELEASE" -n "$HELM_NAMESPACE"
else
  log "Helm release $HELM_RELEASE not present"
fi

log "Deleting post-install and pre-install manifests"
kubectl delete -f monitoring/post-install/ --ignore-not-found=true
kubectl delete -f monitoring/manifests/ --ignore-not-found=true

log "Deleting namespaces if present"
kubectl delete namespace "$HELM_NAMESPACE" --ignore-not-found=true
kubectl delete namespace "$DEMO_NAMESPACE" --ignore-not-found=true

log "Cleanup completed"
