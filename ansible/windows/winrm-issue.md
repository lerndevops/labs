### with winrm there is an issue with connection as shown in error message below, this is an issue with the latest release of pywinrm where it will ignore the server_cert_validation kwarg if REQUESTS_CA_BUNDLE or CURL_CA_BUNDLE environment variables are set. It has been fixed in the master branch but a release hasn't been made with the changes.

##### Error message as below

`Failed to connect to the host via PSRP: HTTPSConnectionPool(host='35.188.96.89', port=5986): Max retries exceeded with url: /wsman (Caused by SSLError(SSLError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:897)'),))",`


## To get around this, you have 5 options

1) Install latest pywinrm from the master branch directly

2) Use the 0.2.2 version of pywinrm which didn't have this issue (you loose out on message encryption :( )

3) Use pypsrp instead. Need to install with pip install pypsrp and set the following vars in your inventory (Note: this requires Ansible 2.7)

```
ansible_user: devops
ansible_password: today@1234
ansible_connection: psrp
#ansible_port: 55986
ansible_psrp_transport: basic 
ansible_psrp_cert_validation: ignore
```

4) Don't use SSL with winrm

5) Find out where in windows that these env vars are being set and see if they can be unset
