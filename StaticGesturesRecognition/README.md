# Static Gestures Recognition Unity project

This Unity project lets the user define and utilize her/his own static gestures in a VR application. A static gesture is defined as having a frame time duration, so the system will be able to detect an executed gesture for every frame.

## Hardware requirements

* PC
* [Oculus Rift headset](https://www.oculus.com/rift)
* [Leap Motion controller](https://www.leapmotion.com/) mounted on the VR headset. Please see this link for more details: https://developer.leapmotion.com/documentation/v4/vrar.html



## Software requirements

* Windows 10
* [Oculus application](https://www.oculus.com/setup/)
* [Unity](https://unity.com/) (tested on version 2019.2.17)
* [Leap Motion controller VR Setup software](https://developer.leapmotion.com/vr-setup)
* [python3](https://www.python.org/download/releases/3.0/) (needed for a specific step in formatting the data used for numerically defining the gestures)

## Installing

You can simply download the whole repository or run the following commands to clone just this project:

```
git clone --depth 1 --quiet --no-checkout "https://github.com/ardrei/vr-apps" Unity
cd Unity
git checkout master -- StaticGesturesRecognition/
```

## Running the application

Open the ```SampleScene``` in the ```Assets\Scenes``` folder and run it using the ```Play``` button. The system is able to detect two predefined gestures, irrespective of the hand used:<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![](Images/Gesture1.PNG)  &nbsp; &nbsp;  ![](Images/Gesture2.png)
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Gesture 1: Like
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Gesture 2: Rock'n'Roll
<br><br>
The ```Console``` will display a ```Debug``` message with the following format:
```
Left hand gesture: A -- Right hand gesture: B
```
where A and B are the detected gestures for each of the two hands. Their values are either ```1``` or ```2```, corresponding to the gestures pictured above or ```-1``` if none of the two gestures is detected. You can use the detection results for further processing by going into the ```Leap Rig``` prefab, selecting ```Hand Models```, opening the ```Classifier``` script and retrieving the ```resultLeft``` and ```resultRight``` variables (which are the variables that store the detected gestures) in the ```Update``` function.

## Defining your own gestures

In order to define you own detectable gestures please follow these instructions:

* Go to the ```Leap Rig``` prefab, select ``` Hand Models```, open the ```Classifier``` script and comment the ```Debug.Log(...)``` line in the ```Update``` function. Technically this step is not necessary but it will help you make sure the data representing your gesture is written correctly to your ```Assets``` folder.

* Enable the ```Write Data``` script and set an ```Id``` for your gesture. This is the value that will be returned once your gesture will be detected. Since the system can detect two gestures the default value has been set to ```3```.

* Start the application by pressing ```Play``` and execute the gesture you want your system to detect with your ***LEFT*** hand. Now click the ```Write Input Vectors``` boolean variable in the ```Write Data``` script. This will write a number equal to the ```No Of Input Vectors``` variable of ```json``` objects (one object per line) in the ```TrainDataJson.json``` file. The system uses a ```SVM (Support Vector Machine)``` model that is trained using this data for prediction and ***each*** ```json``` object represents ***one example*** of that gesture (***one*** input vector).

* After the data has been written the ```Write Input Vectors``` variable will untick itself. Now you can restart the process and write more ```json``` objects to the drive.  It is recommended to use between ```50``` and ```100``` examples for each gesture. Note that the value of the ```No Of Input Vectors``` has been set to ```10``` by default and that for each of the two gestures that the system can detect ```100``` examples are defined.

* Once you have enough ```json``` objects (examples) for your gesture, open a ```cmd``` window, navigate to the ```Assets``` folder and run the following command: ```python3 JsonToSVM.py```. This step will take the ```json``` data from the ```TrainDataJson.json``` file, reformat it according to the ```SVM (Support Vector Machine)``` library specifications and append it to the ```TrainData.txt``` file.

* Disable the ```Write Data``` script and uncomment the  ```Debug.Log(...)``` line in the ```Update``` function of the ```Classifier``` script and you're done! Now press the ```Play``` button and the application will be able to detect the gestures that you defined!

* One more thing: the system calculates an ***ideal*** input vector for each gesture by averaging the training data for each vector. The ```SVM (Support Vector Machine)``` prediction is validated by calculating the ```Euclidean Distance``` between the executed gesture and the ideal input vector for the predicted gesture. This value is compared to the ```Euclidean Distance``` threshold value set in the ```Classifier``` script. If the value is above the threshold the system discards the ```SVM (Support Vector Machine)``` prediction as erroneous. It is set to ```50``` (mm) by default and it will be optimal for most cases. However, if you want to define gestures that are very similar you might want to lower this value in order to be more precise when validating the ```SVM (Support Vector Machine)``` prediction as the similar gestures might be cross-detected.

## Further work
Oculus recently released the [hand tracking](https://www.oculus.com/blog/thumbs-up-hand-tracking-now-available-on-oculus-quest/) update for the [Oculus Quest](https://www.oculus.com/quest) and I intend to port the algorithm for this headset so do come back for the update!
