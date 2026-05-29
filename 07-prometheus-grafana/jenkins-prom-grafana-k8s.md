# Monitoring Jenkins Pipelines with Prometheus & Grafana on Kubernetes

## Architecture

Jenkins -> Prometheus Plugin -> Prometheus (K8s) -> Grafana (K8s)

## Step 1 - Install Jenkins Prometheus Plugin

Manage Jenkins -> Plugins -> Available Plugins -> Prometheus Metrics Plugin

Validate:

curl http://JENKINS_IP:8080/prometheus

## Step 2 - Create Monitoring Namespace

kubectl create namespace monitoring

## Step 3 - Create Prometheus ConfigMap

prometheus-config.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring

data:
  prometheus.yml: |
    global:
      scrape_interval: 15s

    scrape_configs:
    - job_name: 'jenkins'
      metrics_path: /prometheus
      static_configs:
      - targets:
        - JENKINS_IP:8080

Apply:
kubectl apply -f prometheus-config.yaml

## Step 4 - Deploy Prometheus

Create Deployment and Service (NodePort 30090).

Validate:
kubectl get pods -n monitoring
kubectl get svc -n monitoring

Access:
http://NODE_IP:30090

Status -> Targets -> jenkins UP

## Step 5 - Deploy Grafana

Deploy grafana/grafana image.

Expose using NodePort 30300.

Login:
admin / admin123

## Step 6 - Configure Prometheus Datasource

URL:
http://prometheus.monitoring.svc.cluster.local:9090

Save & Test

## Step 7 - Create Dashboard

Successful Builds:
increase(default_jenkins_builds_success_build_count[1h])

Failed Builds:
increase(default_jenkins_builds_failed_build_count[1h])

Build Duration:
rate(default_jenkins_builds_duration_milliseconds_sum[5m])
/
rate(default_jenkins_builds_duration_milliseconds_count[5m])

Active Executors:
default_jenkins_executor_count_value

Queue Size:
default_jenkins_queue_size_value

## Step 8 - Generate Data

Run Jenkins pipelines and observe metrics.

## Bonus

Deploy Pushgateway for stage-level metrics:
Checkout, Compile, Test, Package, Docker Build, Deploy.
