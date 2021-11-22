# walking-motivation


## Brief explanation 
The purpose of this project is to make an app that motivates you to go outside and move.
A mobile app that gives you motivating tasks, new routes will emerge so that every trip will be new and exciting.


## Technical specification

**NOTE**

***The development environment is subject to change***

### Ide

|Program|Version|
|---|---|
|Visual Studio Code|1.62.2 (user setup)|

### Operating system

|OS|Version|
|---|---|
|Microsoft Windows 10 Education|10.0.19042|
|Microsoft Windows 11 Home|10.0.22000|

### Language

|Language|Version|
|---|---|
|Kotlin|1.5.31|
|Python|3.9.6|
|Swift|5.1|

**What language where**

Python for backend

Kotling for the Android app

Swift for IOS development


### Coding standard

#### Python

```
#Comments here function overview
def camelCasing():
  #Comments here for specifics
  print("We use camelCasing")
  
  if pythonSyntax == "weird":
    return print("We know")
  else:
    return print("No it is weird")

```

#### Kotlin

- camelCasing
- PascalCasing Classnames
- wraping chains new line for every .

```
val anchor = owner
    ?.firstChild!!
    .siblings(forward = true)
    .dropWhile { it is PsiComment || it is PsiWhiteSpace }

```
- trailing comma

```
class Person(
    val firstName: String,
    val lastName: String,
    val age: Int, // trailing comma
)
```

#### Swift

- PascalCasing for function, classes
- camelCasing for variable

### VS Code extension

|Extension|Version|
|---|---|
|Kotlin Language|1.7.1|
|Code Runner|0.11.6|

### API Testing framework

|Program|Version|
|---|---|
|Postman|9.1.4 win32 10.0.22000 / x64|

## Definition of Done (DoD)

- Make sure that the code is readable and concise, also add comments.
- The code should not be in main branch if the program is not running, nor should there be any errors. All code must therefore pass a pull request whenever the code is pulled.
- Make sure that the product is presentable when presentation is due.
- Commit messages and description needs to be clear.
- For code to be in main branch, it needs to be approved by at least 2 other people.
- Move over the corresponding 'Trello note' to 'Done'.
- DoD requirements need to be met.


## Other

- Many commits
- Must push at the end of the day
- Pull to main when feature is done
