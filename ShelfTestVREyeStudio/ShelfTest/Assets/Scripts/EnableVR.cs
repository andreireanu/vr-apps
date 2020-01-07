using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.VR;

public class EnableVR : MonoBehaviour
{

	private void Awake ()
	{
		VRSettings.LoadDeviceByName ("Oculus");
		VRSettings.enabled = true;


	}
}
  
