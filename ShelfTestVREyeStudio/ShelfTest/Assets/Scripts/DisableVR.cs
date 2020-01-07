using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.VR;

public class DisableVR : MonoBehaviour
{


	private void Awake ()
	{
		VRSettings.LoadDeviceByName ("Oculus");
		VRSettings.enabled = false;
	}


 


}
