## NodePort

1. **NodePort Service exposes a hostport/nodeport on `every node` in the cluster, `also creaets the ClusterIP Service` that can forward the reqeust into single/multiple backend pods**

2. **NodePort service is an extension of ClusterIP service. A ClusterIP Service, to which the NodePort Service routes, is automatically created.**

3. **in Other Words: NodePort exposes the service on each Node’s IP at a static port (the NodePort). Each node proxies that port into your Service. So, external traffic has access to fixed port on each Node. It means any request to your cluster on that port gets forwarded to the service.**

4. **You can contact the NodePort Service, from outside the cluster, by requesting `<NodeIP>:<NodePort>.`**

5. **Node port must be in the `range of 30000–32767`. Manually allocating a port to the service is optional. If it is undefined, Kubernetes will automatically assign one.**

6. **If you are going to choose node port explicitly, ensure that the port was not already used by another service.**

## Use Cases

1. **When you want to enable external connectivity to your service/application.**

2. **Using a NodePort gives you the freedom to set up your own load balancing solution, to configure environments that are not fully supported by Kubernetes, or even to expose one or more nodes’ IPs directly.**

3. **Prefer to place a load balancer above your nodes to avoid node failure.**
