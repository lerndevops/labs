linux basic commands

direcotry operation 

        pwd -- displays prsent working direcotry
	mkdir testdir  --- create a directory 
	cd testdir -- change direcotry
	ls -- list contents of current directory
	ls -l -- list contents of current dirctory with detailed output
	ll -- list contents of current directory with detailed output
	cd .. -- to come out of a directory 
        rm -r testdir -- to remove a directory
	

file operations 

	touch abc.txt -- creates a empty file 
        ls -l -- lists the contents in current directory
	cat abc.txt -- writes the content of file into terminal & exits 
	more abc.txt -- writes the content of file on terminal page by page ( to move to next page need to hit space bar on keyboard )
	less abc.txt -- open the file on terminal & can be read line by line (use arrows to scroll up & down) 		  
	                to 	comeout need to press 'q' on the key board
	rm abc.txt -- to remove a file 
	
	vi abc.txt -- opens the file in read only mode
				  to edit the file, press 'i' on keyboard for INSERT mode & then you can write anything
				  once required text is entered press 'ESC' on keyboard to back readonly mode
				  press ':wq' on keyboard -- to save & come out of the file
				  press ':q' on keyboard -- to come out of the file without saving
				  press ':wq!' on keyboard -- to save forcefully & come out of the file
				  press ':q!' on keyboard -- to come out of the file forcefully without saving
	              ( note: vi is an file editor, you can use any editor you like by installing it on your machine )

copy/rename/move operations 

	for these operations we can always use absolute paths or relative paths accrodingly 
	these commands expects source & dest values 
	
	cp one.txt two.txt  -- makes a copy of one.txt names it to two.txt in current directory
	cp /home/one.txt /tmp/one.txt -- makde a copy of one.txt to /tmp 
	cp -r abcdir/ newdir/ -- makes a copy of abcdir & names it to newdir in current dirctory 
	cp -r /home/abcdir /tmp/abcdir -- makes a copy of abcdir to /tmp
	
	mv one.txt new.txt --- renames one.txt to new.txt in current path
	mv one.txt /tmp --- moves to one.txt to /tmp
	mv testdir newdir -- renames testdir to newdir in crrent path 
	mv newdir /tmp --- moves newdir to /tmp path


file/directory permissions 

	drwxr-xr-x 2 naresh devops     4096 Jun 18 07:59 aws/
	-rw-r--r-- 1 naresh devops   20276 Feb 20 04:17 ansible.cfg

	-rw-r--r--  OR drwxr-xr-x   ---> are the read/write/execute permission for a file or directory in linux 
	naresh -- is the owner of the file / directory 
	devops -- group owns the the file / direcotry 
	
	how to update the owner & group for a file/dir 

		chown ( change owner ) is the command to update the owners of dir/file 
		note: note that you need to have previliges to update the permissions for a file/directory
		
			chown owner:group filename/dirname
			chown ravi:dbadmin filename/dirname -- updates the owner & group of the file/directory to ravi & dbadmin
	
	how to update the read,write & execute permissions for a file/dir
	
		we can see read,write,execute permission as below 
	
		-/d    ---> denotes if it is a file or directory ( - means file / d means directory ) 
		rwx    ---> means read,write & execute permissions for super user ( root )
		rw-    ---> means read,write permissions for the owner of the file ( ex: naresh as above )  
		r--    ---> means read only permissions for others ( whoever login to the machine ) 
    
		r  -- Permission to read the file.
		w  -- Permission to write (or delete) the file.
		x  -- Permission to execute the file, or, in the case of a directory, search it.
	
		chmod ( change mode ) is the command to update the read/write/execute permissions for a file/directory
		
		r = 4, w = 2, x = 1
		
		- | rwx  | rwx  | rwx
		- | 421  | 421  | 421
		
		to update the permissions we can sum 421 
		means, if super user needs to have read,write & exeute give 7 ( same applicable for owner & others )
		       if the owner need to read & write give 6 ( same applicable for root & others )
			   if other need to have only read give 4  ( same applicable for root & owner )
			   
			   so 
			   
			   chmod 777 file/dir -- rwx for root, rwx for owner, rwx for others 
			   chmod 764 file/dir -- rwx for root, rw for owner, r for others 
			   chmod 755 fire/dir -- rwx for root, rw for owner, rw for others
			   chmod 400 firl/dir -- r for root, for owner/other no permissions
			   
		like wise we can update the permissions as needed
