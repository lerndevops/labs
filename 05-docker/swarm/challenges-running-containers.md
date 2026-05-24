## Container-based applications brings many challenges to IT & DevOps teams mostly 

### There are two types of challenges 
``` 
   1. managing the underlying infrastructure on which these apps are running
   2. managing the actual applications, which is especially challenging in upstream environments (like PROD).
```

##### While application portability (i.e. being able to run the same application on any Linux host) is still the leading driver for the adoption of Linux Containers, another key advantage is being able to optimize server utilization so that you can use every bit of compute. 

##### In DEV/TEST environments, which typically represent the majority of compute resource consumption in an organization, optimizing server utilization can lead to significant cost savings.


### DevOps Engineers and Infrastructure operators still struggle with Some Questions as below

> **How can I group servers across different clouds OR in a datacenter into clusters that map to business groups, development teams, or application projects ?**

> **How do I monitor these clusters and get insight into the resource consumption by different groups or users?**

> **How do I set up networking across servers in a cluster so that containers across multiple hosts can communicate with each other?**

> **How do I define my own capacity-based placement policy so that I can use every bit of compute in a cluster?**

> **How can I automatically scale out the cluster to meet the demands of the developers for new container-based application deployments?**

### Once the application is deployed, there are several requirements for managing them in production?
```
  1) High Availability -- distributed hosts/regions
  2) Backups
  3) Monitoring & Alerts
  4) Auto-Scaling
  5) Continuous Delivery for Enterprise Apps
  6) Service Discovery
  7) Logging
  8) Integration with Existing Services
  9) Auditing
```
