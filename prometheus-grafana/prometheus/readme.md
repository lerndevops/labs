## What is Prometheus used for?

> Prometheus is an open-source software application used for event monitoring and alerting. It records real-time metrics in a time series database (allowing for high dimensionality) built using a HTTP pull model, with flexible queries and real-time alerting.

## How does Prometheus work?

> The Prometheus server works on the principle of scraping, i.e., invoking the metrics endpoints of the various nodes that it is configured to monitor. It collects these metrics at regular intervals and stores them locally.

## Why Use Prometheus for Kubernetes Monitoring

#### Two technology shifts took place that created a need for a new monitoring framework:

1. ***DevOps culture:*** Prior to the emergence of DevOps, monitoring was comprised of hosts, networks and services. Now developers need the ability to easily integrate app and business related metrics as an organic part of the infrastructure, because they are more involved in the CI/CD pipeline and can do a lot of operations-debugging on their own. Monitoring needed to be democratized, made more accessible, and cover additional layers of the stack.

2. ***Containers and Kubernetes:*** Container-based infrastructures are radically changing how we do logging, debugging, high-availability… and monitoring is not an exception. Now you have a huge number of volatile software entities, services, virtual network addresses, exposed metrics that suddenly appear or vanish. Traditional monitoring tools are not designed to handle this.


## Kubernetes monitoring with Prometheus

* 1 – The Prometheus servers need as much target auto discovery as possible.

         There are several options to achieve this:
	 
            - Consul
            - Prometheus Kubernetes SD plugin
            - The Prometheus operator and its Custom Resource Definitions
			
* 2 – Apart from application metrics, we want Prometheus to collect metrics related to the Kubernetes services, nodes and orchestration status.

        - Node exporter, for the classical host-related metrics: cpu, mem, network, etc.
        - Kube-state-metrics for orchestration and cluster level metrics: deployments, pod metrics, resource reservation, etc.
        - Kube-system metrics from internal components: kubelet, etcd, dns, scheduler, etc.
		
* 3 – Prometheus can configure rules to trigger alerts using PromQL, alertmanager will be in charge of managing alert notification, grouping, inhibition, etc.

* 4 – The alertmanager component configures the receivers, gateways to deliver alert notifications.

* 5 – Grafana can pull metrics from any number of Prometheus servers and display panels and Dashboards.
