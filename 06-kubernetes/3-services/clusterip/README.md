## ClusterIP

> **ClusterIP is the default and most common service type**

> **assume that the `ClsuterIP` service will `act as internal virtual LoadBalancer`, that can forward the request into one / group of pods.**

> **Kubernetes will assign a cluster-internal IP address to ClusterIP service. This makes the service only reachable within the cluster.**

> **You cannot make requests to service (pods) from outside the cluster.**

> **You can optionally set cluster IP in the service definition file.**

### Use Cases

1. **Inter service `communication within the cluster`. For example, communication between the front-end and back-end components of your app.**
