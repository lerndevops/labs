## direcotry operation 

#### pwd -- displays prsent working direcotry
```
ubuntu@naresh-vm:~$ pwd
/home/ubuntu
```
#### mkdir testdir  --- creates a new directory with name testdir 
```
ubuntu@naresh-vm:~$ mkdir testdir
```
#### ls -- list contents of current directory
```
ubuntu@naresh-vm:~$ ls
testdir
```
#### cd testdir -- change direcotry
```
ubuntu@naresh-vm:~$ cd testdir/
ubuntu@naresh-vm:~/testdir$ 
```
#### ls -l -- list contents of current dirctory with detailed output
```
ubuntu@naresh-vm:~/testdir$ ls -l
total 0
```
#### ll -- list contents of current directory with detailed output
```
ubuntu@naresh-vm:~/testdir$ ll
total 8
drwxrwxr-x 2 ubuntu ubuntu 4096 Mar 17 06:30 ./
drwxr-xr-x 6 ubuntu ubuntu 4096 Mar 17 06:30 ../
```
#### cd .. -- to come out of a directory
```
ubuntu@naresh-vm:~/testdir$ pwd
/home/ubuntu/testdir
ubuntu@naresh-vm:~/testdir$ cd ..
ubuntu@naresh-vm:~$ pwd
/home/ubuntu
```
#### rm -r testdir -- to remove a directory
```	
ubuntu@naresh-vm:~$ ls -l
total 4
drwxrwxr-x 2 ubuntu ubuntu 4096 Mar 17 06:30 testdir
ubuntu@naresh-vm:~$ rm -r testdir/
ubuntu@naresh-vm:~$ ls -l
total 0
```
