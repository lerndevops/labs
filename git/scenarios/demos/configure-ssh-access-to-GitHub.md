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

# take the output of above command & copy to notepad 
```
![ssh-key](https://github.com/lerndevops/labs/blob/master/static/git/ssh-key.png)

##### Goto Your GitHub Account --> Settings --> Configure SSH-KEYS as below

![deploy-ssh-keys](https://github.com/lerndevops/labs/blob/master/static/git/github-deploy-ssh-keys.png)

##### copy github project ssh url 

![ssh-url](https://github.com/lerndevops/labs/blob/master/static/git/github-project-ssh-url.png)

##### From Your `Git Bash` OR `Mac` OR `Linux` Terminal 

```
git clone git@github.com:lerndevops/project007.git -- clone project with ssh url 
cd project007                                      -- get inside the project folder 
git remote -v                                      -- check the remote url configured as ssh url 
echo "hello" > 5.xml                               -- modify any file 
git commit -am "mod 5.xml"                         -- add & commit file in local 
git push -u origin main                            -- push to remote github / it shouldn't ask any credentials 
```
