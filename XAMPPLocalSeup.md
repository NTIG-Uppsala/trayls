# XAMPP Local Setup

## Installation guild for [XAMPP](https://www.apachefriends.org/index.html)

- Download [XAMPP](https://www.apachefriends.org/index.html)


## installation
  - Run .exe
  - Click yes on antivirus pop-up
  - Click ok on the warning
  #### start setup
  - Click next on setup
  - (optional) Uncheck filezila, mercury and tomcat
  - Click next
  - Chose installations folder
  - Click next
  - Click finish button
  - And your done



### Configure XAMP
  - Click Config (right top corner)
  - Click Service and port setting
  - Change the main port to 8080
  - Save and go back to the control panel
  - Click on the config button for apache
  - Click on apache(http.conf) 
  - In the text document change the listen port to 8080(you can find it with ctrl+f and search for "listen")
  - Next, change the ServerName localhost:80 to ServerName localhost:8080 (use the same way as the last step to find it)
  - Save and close the text file.

## Try to start XAMPP by clicking start on apache and MySQL, if the names of the modules turn green you are good to go. <br>click on the admin button for MySQL to go to the PHPMyAdmin page.



### if you wanna import a database follow this
  - Open PHPMyAdmin
  - Click on the new button on the left side 
  - Add a name to the database 
  - Click on create 
  - Click on the import tab at the top of the page
  - Click on the choose button and import a zipped folder of the database you wanna add
  - Click the go button on the bottom right corner
