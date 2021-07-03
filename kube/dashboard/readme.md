## deploy dashboard
```
   kubectl apply -f dashboard-insecure.yml
```
### validate
```
   ensure dashboard deployment is available & pod in running state

       kubectl get deploy 
       kubectl get pods 
```
### Access UI
```
   kubectl get svc ( note port number ex: 30605)
   
   open the broser and hit -- http://ip:port  (if deployed in aws use publicip)
      ex: http://3.14.249.66:30605/
   
   skip the login to get in !!     
```
