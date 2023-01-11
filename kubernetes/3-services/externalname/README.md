## ExternalName

1. **Services of type ExternalName map a Service to a DNS name, not to a typical selector such as my-service.**

2. **You specify these Services with the `spec.externalName` parameter.**

3. **It maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value.**

4. **No proxying of any kind is established.**

## Use Cases

1. **This is commonly used to create a service within Kubernetes to represent an external datastore like a database that runs externally to Kubernetes.**

2. **You can use that `ExternalName` service (as a local service) when Pods from one namespace to talk to a service in another namespace.**
