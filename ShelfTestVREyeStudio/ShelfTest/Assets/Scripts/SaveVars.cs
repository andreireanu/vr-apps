using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SaveVars : MonoBehaviour
{

	public int ID;
	public InputField inputField;



 
	void FixedUpdate ()
	{
		ID = int.Parse (inputField.text);
	}

	public int GetID ()
	{
		return ID;
	}
}
