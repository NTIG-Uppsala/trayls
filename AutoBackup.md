# AutoBackup

## Create backup batch flie

### this file can lay anywhere

### useded to acces XAMPP CMD

```
cd "C:\Users\miniadmin\server\mysql\bin"
```

### Acces teh database and expoerts the data to a local folder and adds the dates.

```
mysqldump -u root trayls > "C:\Users\miniadmin\Documents\backups\%date:~-4,4%-%date:~-10,2%-%date:~-7,2%%time:~0,2%.%time:~3,2%.sql"
```

### in the end it should look like this 

```
cd "C:\Users\miniadmin\server\mysql\bin"

mysqldump -u root trayls > "C:\Users\miniadmin\Documents\backups\%date:~-4,4%-%date:~-10,2%-%date:~-7,2%%time:~0,2%.%time:~3,2%.sql"
```

## Create a schedule for the automatic database export

- open Scheduler in windows
- Click Task Scheduler libary
- Right side under Actions click "Crewate basic task"
- Add a name to the task
- Click next
- Choose how offen the task should activate 
- Click next
- Choose what time
- Choose start a program
- Click next
- Click on the browse and choose teh batvh file you created earlier
- Lasst click the finish button adn your done
