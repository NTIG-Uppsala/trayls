# Backend

## Location

Virtual Windows Desktop on a Server In School

## Login

[Login Credentials and how to acces it](https://docs.google.com/document/d/1g7ZcIb5wSdSshiwk7GOTtf9IkKcU2Mrd5tcn-gWG4bU/)

Ask a teacher to give you access to read the google document

## Continue on existing Setup

### Database

#### Open SQL

- Open XAMPP control panel
- Start Apache
- Start MySQL
- Click "Admin" for MySQL

click Here to view the Database

IMAGE SOON

#### Tabs

IMAGE SOON

##### Structure

- Click to look at the database tables
- Click on the specific table to view its data

##### SQL

- Used to input MySQL code

## Server

- Open File Explorer
- Find the Directory  **C:\Users\miniadmin\Documents\walking-motivation\sqlnode**
 or Open the shortcut on Desktop
- Open the CMD
- Run **node .**
- Server should now be running

## Config file

- Find the directory **C:\Users\miniadmin\Documents**
- Open **trayls.json**
- Contains password

## API Calls

### Get requests

#### task

- Gets a random task from database
- Have no req

#### points

- Gets the points from a user
- Require mail in body

#### currTask

- Gets the current task from a user
- Require mail in body

### Post requests

#### user

- Adds a new user to the database
- Greets a returning user
- Require mail in body

#### accTask

- Accepts the current task of the user
- Require mail in body
- Require task_id in body

### Put requests

#### changeTask

- Changes the status of a users active task(2 = Completed, 3 = Cancelled)
- Require mail in body
- Require status in body

### Delete request

#### user

- removed user from database
- Require mail in body
- Require pw in body
