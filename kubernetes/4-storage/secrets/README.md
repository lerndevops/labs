## Secrets

> A Secret is an object that contains a small amount of sensitive data such as a `password,` a `token,` or a `key`. 

> Such information might otherwise be put in a Pod specification or in a container image. 

> **`Using a Secret means that you don't need to include confidential data in your application code.`**

> Because Secrets can be created independently of the Pods that use them, there is less risk of the Secret (and its data) being exposed during the workflow of creating, viewing, and editing Pods. 

> Kubernetes, and applications that run in your cluster, can also take additional precautions with Secrets, such as avoiding writing secret data to nonvolatile storage.

### [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)

### [MORE INFO](https://kubernetes.io/docs/concepts/configuration/secret/)
