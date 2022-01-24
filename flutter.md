*SUBJECT TO CHANGE*


## This is a short guide to flutter.

### Syntax

For the syntax we try to follow the standard set by the sample code that came with the flutter project. Guides and other tools used during developmend has used this syntax so why shoudnt we.

Classed uses capital letter in the begginging of the classname exept when the class is a subclass and extends parent class. Then the Classname will start with a _.

Ex:

```
// This is a parent class, it will have a captial letter.
Class Parent extends StatefulWidget {
  // Calls subclass
}

//This is a subclass to Parent
Class _ParentChild extends State<Parent> {
  //Like so
}

```

We get this is hard to understand. But you will get it soon enough. Flutter can be programmed largly with the snippets provided. Use them and the syntax will follow.

## Set Up

### Install Flutter

- Download flutter from the following [link](https://docs.flutter.dev/get-started/install)
- Extract the files inside the .zip file

### Environment Variable

- Edit the Path variable to "full path"\flutter\bin
- Remember to click "OK" so it saves
- Restart the computer

### Android 

- Run "flutter doctor" in cmd
- If u get errors download Android Studio
- Set up the emulator [guide here](https://github.com/NTIG-Uppsala/trayls/blob/main/android-studio.md)
- Run "flutter doctor" again

### Visual Studio Code

- Open the folder "trayls\frontend\trayls"
- Download the "Flutter" extension
- Click this button
- ![image](https://user-images.githubusercontent.com/62390271/150762227-6d9c61b7-85d7-45b9-81a0-55655e4d6769.png)
- Select the emulator (run without cold boot)
- type "flutter run" in terminal

