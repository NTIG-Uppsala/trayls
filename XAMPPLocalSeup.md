# XAMPP Local Setup

## Installation guild for [XAMPP](https://www.apachefriends.org/index.html)

- Download [XAMPP](https://www.apachefriends.org/index.html)


## installation
  - run .exe
  - click yes on antivirus pop-up
  - click ok on the warning
  #### start setup
  - click next on setup
  - (optional) uncheck filezila, mercury and tomcat
  - click next
  - Chose installations folder
  - click next
  - click finish button
  - And your done



### Configure XAMP
  - Click Config (right top corner)
  - Click Service and port setting
  - change main poort to 8080
  - save and go back to thhe coontroll panel
  - click on the config button for apache
  - click on apache(httpd.conf) 
  - in the text document change the listen port to 8080(you can find it with ctrl+f and search for listen)
  - next change the ServerName localhost:80 to ServerName localhost:8080 (use th same way as last step to find it)
  - save and cloose the text file.

## try to start XAMPP by clicking start on apache and mysql, if the names of the modules turn green you are go to go. <br>click on the admin button for the mysql to goo to teh phpmyadmin page.



### if yooou wanna impoort a database follow this
  - open phpmyadmin
  - click on the new button on the left side 
  - add a name to the database 
  - click on create 
  - click on the import tab at the top the page
  - click on the choose button adn import a ziped foolder of the database you wanna add
  - click the go button on the bottom right corner

