## deploy dashboard
```
   kubectl apply -f dashboard-v2-insecure.yml
```
### validate
```
   ensure dashboard deployment is available & pod in running state

       kubectl get deploy -n kubernetes-dashboard
       kubectl get pods -n kubernetes-dashboard
```
### Access UI
```
   kubectl get svc -n kubernetes-dashboard ( note port number ex: 30605)
   
   open the broser and hit -- http://ip:port  (if deployed in aws use publicip)
      ex: http://3.14.249.66:30605/
   
   skip the login to get in !!     
```
