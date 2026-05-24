## file operations 

### Create Files 
```
touch abc.txt -- creates a empty file 
ls -l -- lists the contents in current directory
```
```
VI Editor 

vi abc.txt -- creates & opens the file in read only mode if the file is not exist 

	to edit the file, press 'i' on keyboard for INSERT mode & then you can write anything

	once required text is entered press 'ESC' on keyboard to back readonly mode

	press ':wq' on keyboard -- to save & come out of the file

	press ':q' on keyboard -- to come out of the file without saving

	press ':wq!' on keyboard -- to save forcefully & come out of the file

	press ':q!' on keyboard -- to come out of the file forcefully without saving

  ## note: vi is a file editor, you can use any editor you like by installing it on your machine
```

### check / view the file contents 

```
cat abc.txt -- writes the content of file into terminal & exits 
```

```
more abc.txt -- writes the content of file on terminal page by page 

##to move to next page need to hit space bar on keyboard 
```
```
less abc.txt -- open the file on terminal & can be read line by line (use arrows to scroll up & down) 		  
	               
## to comeout need to press 'q' on the key board
```

### remove the file(s)
```
rm abc.txt -- to remove a file 
```
