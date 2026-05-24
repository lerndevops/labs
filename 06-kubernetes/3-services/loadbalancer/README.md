## LoadBalancer

1. **LoadBalancer service is an extension of NodePort service. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.**

2. **It integrates NodePort with cloud-based load balancers.**

3. **It exposes the Service externally using a cloud provider’s load balancer.**

4. **Each cloud provider (AWS, Azure, GCP, etc) has its own native load balancer implementation. The cloud provider will create a load balancer, which then automatically routes requests to your Kubernetes Service.**

5. **Traffic from the external load balancer is directed at the backend Pods. The cloud provider decides how it is load balanced.**

6. **The actual creation of the load balancer happens asynchronously.**

7. **Every time you want to expose a service to the outside world, you have to create a new LoadBalancer and get an IP address.**

## Use Cases

> **When you are using a cloud provider to host your Kubernetes cluster**
