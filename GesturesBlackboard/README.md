# Gestures Blackboard Application

This VR Application recognizes  24 Romanian sign-language static gestures, each one corresponding to  a letter of the alphabet.

## Hardware requirements

* PC
* [Oculus Rift headset](https://www.oculus.com/rift)
* [Leap Motion controller](https://www.leapmotion.com/) mounted on the VR headset. Please see this link for more details: https://developer.leapmotion.com/documentation/v4/vrar.html



## Software requirements

* Windows 10
* [Oculus application](https://www.oculus.com/setup/)
* [Leap Motion controller VR Setup software](https://developer.leapmotion.com/vr-setup)


## Installing

You can simply download the whole repository or run the following commands to clone just this project:

```
git clone --depth 1 --quiet --no-checkout "https://github.com/ardrei/vr-apps" Unity
cd Unity
git checkout master -- GesturesBlackboard/
```

## Running the application

Double-click on the ```GesturesBlackboard.exe``` file to start the application. You'll see a board with pictures for 24 Romanian sign-language static gestures. Once you execute a particular one (using any hand) the corresponding picture will flicker signaling that the system has detected it.

## Demo
You can check a short gif demo of the application below:

![](GIF/GesturesBlackboard.gif)
