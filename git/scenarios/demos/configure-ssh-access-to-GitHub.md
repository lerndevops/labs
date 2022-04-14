## Configure SSH Access to GitHub 

> If you are using Windows open **`Git Bash.`** If you are using Mac or Linux open your **`Terminal.`**

##### Before you generate an SSH key, you can check to see if you have any existing SSH keys.
- List the contents of your ~/.ssh directory OR $HOME/.ssh
```
# ls -l $HOME/.ssh

Example:

nareshwar@mbpro ~ % ls -l $HOME/.ssh
total 0
```
 
##### Check the directory listing to see if you already have a public SSH key. By default the filenames of the public keys are one of the following;
```
id_dsa.pub 
id_ecdsa.pub 
id_ed25519.pub 
id_rsa.pub
```

##### If you see an existing public and private key pair listed that you would like to use on your Bitbucket, GitHub (or similar) account you can copy the contents of the id_*.pub file.

##### If not, you can `create a new public and private key pair` with the following command;
```
nareshwar@mbpro ~ % ssh-keygen     

# Note: Press the Enter or Return key to accept the default location. Enter and re-enter a passphrase when prompted, or leave it empty.

Generating public/private rsa key pair.
Enter file in which to save the key (/Users/nareshwar/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/nareshwar/.ssh/id_rsa
Your public key has been saved in /Users/nareshwar/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:T8vCGKYDYJaDnt+JgMovFPStD7b4UNdIJ9L9rDx0/YQ nareshwar@mbpro.local
The key's randomart image is:
+---[RSA 3072]----+
|                 |
|... . .          |
|+=...+ o         |
|=oo.o.= o . .    |
|.+o..oooS+.E .   |
|o.+=+o++o+ .o    |
|oooo*o.+o +  .   |
| oo. o  ..       |
|  oo             |
+----[SHA256]-----+

```

##### the above generates a public & priavate key pairs as below
```
nareshwar@mbpro ~ % ls -l $HOME/.ssh
-rw-------   1 nareshwar  staff  2610 Apr 14 13:04 id_rsa
-rw-r--r--   1 nareshwar  staff   575 Apr 14 13:04 id_rsa.pub
```

##### Now, Copy the Content of `id_rsa.pub` from your terminal 

```
nareshwar@mbpro ~ % cat $HOME/.ssh/id_rsa.pub

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDs6nZRA2f6SrdnQYc519TfZq0icaKGszUbZP/G5OAC83hL1LpijyYkw+pNvjkTePcm0Yfpj2IY8L8iJe+zwm41VeBYtrDSYocae1nKlSofWdf2UNaOEJYyXhMK1TNGALXMtoj6d0fCbEIcF4+6QapciiH3kCZ3eyRJAXS4oud9ucDAZv+WxqeWmYspbMvIcWHEl3yBxg+K5yVIJ5AkG4SPC5REYMz9oJf50y0bhHpFZTbwx3ijIkhtaZT8MIRsRFhAoQscQ2aNsaIqTCsNAwwGTMkZBcLG7j6xrISqEIAvUi9r+bZLhrIkV2KmUMMxDmLBYRogeMvT6QHknC+ZDKmGXTUd84a8WkW32WUzxXgzglr1VMxzSq+UKgffVAgK7vd6k+/DQ0t9FmRUP1cONt1jERuDpHRDeDndF//lqJJ9JmQRnzCuv4aWd6eAgWDT2QwGQrOc9jCyjRYguobRFDs3+KOCxLjyP2xX6TwyFABkRZ29EmnX0Guc2mc= nareshwar@mbpro.local
```


