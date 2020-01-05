using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Leap.Unity;
using Leap;
using LeapInternal;

public class SVMStart : MonoBehaviour
{
    public Camera camera;
	private Controller controller;
	public Frame frame;
	public List<Hand> hands;
	//private Hand firstHand;
	public double[] inputVectorLeft, inputVectorRight;  // 9 dimensional vector calculated for each hand

	public HandModel leftHandModel, rightHandModel;
	//public List<HandModel> listHandModel;
	public bool leftHand, rightHand; // if left hand or right hand are detected and LineRenderer is active use this to display the distances between key hand elements
	public LineRenderer lineRenderer; // lineRenderer (for Debug only)
    public CapsuleHand capsuleHand;

    /*
	public double[] SetSVMParams (HandModel handModel)
	{
		var dVal = new double[9];
		var v = new Vector3 (0f, 0f, 0f);
		v = handModel.GetPalmPosition ();
		FingerModel thumb = handModel.fingers [0];
		FingerModel index = handModel.fingers [1];
		FingerModel middle = handModel.fingers [2];
		FingerModel ring = handModel.fingers [3];
		FingerModel pinky = handModel.fingers [4];
		dVal [0] = Vector3.Distance (thumb.GetTipPosition (), v) * 100;
		dVal [1] = Vector3.Distance (index.GetTipPosition (), v) * 100;
		dVal [2] = Vector3.Distance (middle.GetTipPosition (), v) * 100;
		dVal [3] = Vector3.Distance (ring.GetTipPosition (), v) * 100;
		dVal [4] = Vector3.Distance (pinky.GetTipPosition (), v) * 100;
		dVal [5] = Vector3.Distance (thumb.GetTipPosition (), index.GetTipPosition ()) * 100;
		dVal [6] = Vector3.Distance (index.GetTipPosition (), middle.GetTipPosition ()) * 100;
		dVal [7] = Vector3.Distance (middle.GetTipPosition (), ring.GetTipPosition ()) * 100;
		dVal [8] = Vector3.Distance (ring.GetTipPosition (), pinky.GetTipPosition ()) * 100;
		return dVal;
	}
    */

    public Vector3 LeapToWorldCoordinates(Leap.Vector vector)
    {
        float x = vector.x;
        float y = vector.y;
        float z = vector.z;

         return new Vector3(-x - 19f, -z -19f, y + 120f) /1000f;
       // return new Vector3(0 , 0, y + 120f)  /1000f ;
    }

 

    public void SetLineRenderer (Hand hand)  // set the lineRenderer (for Debug only)
    {
        //Finger thumb = hand.Fingers [0];
        //Finger index = hand.Fingers [1];
        //Finger middle = hand.Fingers [2];
        //Finger ring = hand.Fingers [3];
        //Finger pinky = hand.Fingers [4];

         /*v1
         Quaternion q2 = camera.transform.rotation;
         Vector3 v2 = q2 * LeapToWorldCoordinates(hand.PalmPosition)  ;
        */
           
        //  Vector3 rotatedPoint = q1.eulerAngles + LeapToWorldCoordinates(hand.PalmPosition);
        // Vector3 v = q1 * LeapToWorldCoordinates(hand.PalmPosition);
        // Debug.Log(q1.eulerAngles);
        Quaternion q1 = camera.transform.rotation;
        Vector3 vRotate = q1.eulerAngles;
        Vector3 v = LeapToWorldCoordinates(hand.PalmPosition);
        Vector3 vector = Quaternion.Euler(vRotate.x, vRotate.y, vRotate.z) * v;
       // Vector v2 = hand.PalmPosition * Quaternion.Euler(vRotate.x, vRotate.y, vRotate.z);

        lineRenderer.SetPosition (0, new Vector3(0f, 0f, 0f));
        Vector3 tempV = new Vector3(v.x, v.y, v.z);
        Vector test = new Vector(1000, 0 , 0);

        lineRenderer.SetPosition(1, camera.transform.position + q1 * LeapToWorldCoordinates(hand.Fingers[2].TipPosition));
       //Debug.Log("Camera : " + camera.transform.position.ToString() + "Tip position " + (LeapToWorldCoordinates(hand.Fingers[0].TipPosition)).ToString());
      //  lineRenderer.SetPosition (2,  v2 + camera.transform.position);
     //   lineRenderer.SetPosition(3, new Vector3(0f, 0f, 0f));
      //  lineRenderer.SetPosition(2, camera.transform.position);
      //  lineRenderer.SetPosition(3, hand.Fingers[0].TipPosition.ToVector3()   );
        // lineRenderer.SetPosition (1, hand.PalmPosition.ToVector3() / 1000f);
        
        /*
		lineRenderer.SetPosition (2, index.GetTipPosition ());
		lineRenderer.SetPosition (3, handModel.GetPalmPosition ());
		lineRenderer.SetPosition (4, middle.GetTipPosition ());
		lineRenderer.SetPosition (5, handModel.GetPalmPosition ());
		lineRenderer.SetPosition (6, ring.GetTipPosition ());
		lineRenderer.SetPosition (7, handModel.GetPalmPosition ());
		lineRenderer.SetPosition (8, pinky.GetTipPosition ());
		lineRenderer.SetPosition (9, handModel.GetPalmPosition ());
		lineRenderer.SetPosition (10, thumb.GetTipPosition ());
		lineRenderer.SetPosition (11, index.GetTipPosition ());
		lineRenderer.SetPosition (12, index.GetTipPosition ());
		lineRenderer.SetPosition (13, middle.GetTipPosition ());
		lineRenderer.SetPosition (14, middle.GetTipPosition ());
		lineRenderer.SetPosition (15, ring.GetTipPosition ());
		lineRenderer.SetPosition (16, ring.GetTipPosition ());
		lineRenderer.SetPosition (17, pinky.GetTipPosition ());
        */
    }





    // Use this for initialization
    void Start ()
	{
		controller = new Controller ();
        Debug.Log(controller.Config.ToString());
	}

 
	// Update is called once per frame
	void FixedUpdate ()
	{
        frame = controller.Frame();
        hands = frame.Hands;  // get detected hands in scene

        if (frame.Hands.Count == 0)  // no hands detected
        {
            leftHand = false;
            rightHand = false;
            inputVectorLeft = new double[0];
            inputVectorRight = new double[0];
        }
        else  // at least one hand detected
        {
            leftHand = false;
            rightHand = false;

            foreach (Hand hand in hands)
            {
                if (hand.IsLeft)
                {
                    leftHand = true;
                    //SetLineRenderer(hand);
                    //Debug.Log(leftHandModel.GetPalmPosition());

                }
            }
 


        }
    }

 
 
}
 
 
