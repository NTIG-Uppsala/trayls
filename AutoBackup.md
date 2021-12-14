# AutoBackup

## Create a backup batch file

### this file can lay anywhere

### used to access XAMPP CMD

```
cd "C:\Users\miniadmin\server\mysql\bin"
```

### Access the database and exports the data to a local folder and add the current date.

```
mysqldump -u root trayls > "C:\Users\miniadmin\Documents\backups\%date:~-4,4%-%date:~-10,2%-%date:~-7,2%%time:~0,2%.%time:~3,2%.sql"
```

### in the end it should look like this 

```
cd "C:\Users\miniadmin\server\mysql\bin"

mysqldump -u root trayls > "C:\Users\miniadmin\Documents\backups\%date:~-4,4%-%date:~-10,2%-%date:~-7,2%%time:~0,2%.%time:~3,2%.sql"
```

## Create a schedule for the automatic database export

- Open Scheduler in windows
- Click Task Scheduler library
- On- Right side under actions click "Create basic task"
- Add a name to the task
- Click next
- Choose how often the task should activate 
- Click next
- Choose what time
- Choose to start a program
- Click next
- Click on the browse and choose the batch file you created earlier
-Finally, click the Finish button, and your done
