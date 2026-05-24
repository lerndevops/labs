## copy / rename / move files OR Directories 

> for these operations we can always use absolute paths or relative paths accrodingly

> these commands expects source & dest values 

> "cp" is the command we use copy files or directories 

> "mv" is the command we use mv or rename the files or directories 

### COPY Operations 

```
cp one.txt two.txt  
  -- makes a copy of one.txt names it to two.txt in current directory
```
```
cp /home/one.txt /tmp/one.txt 
  -- makes a copy of one.txt from /home to /tmp
```
```
cp -r abcdir/ newdir/ 
  -- makes a copy of abcdir & names it to newdir in current dirctory
```
```
cp -r /home/abcdir /tmp/abcdir 
  -- makes a copy of abcdir from /home to /tmp
```	

### MOVE / RENAME Operations 
```
1) mv one.txt new.txt --- renames one.txt to new.txt in current path

2) mv one.txt /tmp --- moves to one.txt to /tmp

3) mv testdir newdir -- renames testdir to newdir in crrent path 

4) mv newdir /tmp --- moves newdir to /tmp path
```
