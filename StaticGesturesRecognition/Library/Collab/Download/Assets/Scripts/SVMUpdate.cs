using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Leap.Unity;
using Leap;
using LeapInternal;

public class SVMUpdate : MonoBehaviour  // update for the SVM feature vector in case hands are detected in the scene
{
	private Controller controller;
    private Frame frame;
    private List<Hand> hands;
    private double[] inputVectorLeft, inputVectorRight;

    private double[] SetSVMParams(Hand hand) // calculate the 9 dimensional vector that is used as input for the SVM model
    {
        double[] svmParams = new double[9];

        svmParams[0] = (hand.Fingers[0].TipPosition - hand.Fingers[1].TipPosition).Magnitude;
        svmParams[1] = (hand.Fingers[1].TipPosition - hand.Fingers[2].TipPosition).Magnitude;
        svmParams[2] = (hand.Fingers[2].TipPosition - hand.Fingers[3].TipPosition).Magnitude;
        svmParams[3] = (hand.Fingers[3].TipPosition - hand.Fingers[4].TipPosition).Magnitude;  // calculate the 4 distances between consective finger tips positions
        svmParams[4] = (hand.Fingers[0].TipPosition - hand.PalmPosition).Magnitude;
        svmParams[5] = (hand.Fingers[1].TipPosition - hand.PalmPosition).Magnitude;
        svmParams[6] = (hand.Fingers[2].TipPosition - hand.PalmPosition).Magnitude;
        svmParams[7] = (hand.Fingers[3].TipPosition - hand.PalmPosition).Magnitude;
        svmParams[8] = (hand.Fingers[4].TipPosition - hand.PalmPosition).Magnitude; // calculate the 5 distances between finger tips and hand palm position
        //Debug.Log(svmParams[0]);
        return svmParams;
    }



    // Use this for initialization
    void Start ()
	{
		controller = new Controller ();
        inputVectorLeft = new double[9];
        inputVectorRight = new double[9];
    }

 
	// Update is called once per frame
	void Update ()
	{
        frame = controller.Frame();
        hands = frame.Hands;  // get detected hands in scene

        Array.Clear(inputVectorLeft, 0, 9); 
        Array.Clear(inputVectorRight, 0, 9);  

        if (frame.Hands.Count != 0)   // at least one hand detected
        {
            foreach (Hand hand in hands)
            {
                if (hand.IsLeft)
                {
                    //SetLineRenderer(hand);
                    //Debug.Log(hand.Fingers[0].TipPosition);
                    inputVectorLeft = SetSVMParams(hand);
                }
                if (hand.IsRight)
                {
                    //SetLineRenderer(hand);
                    //Debug.Log(leftHandModel.GetPalmPosition());
                    inputVectorRight = SetSVMParams(hand);
                }
            }
        }
    }

    public double[] getInputVectorLeft()
    {
        return inputVectorLeft;
    }

    public double[] getInputVectorRight()
    {
        return inputVectorRight;
    }


}
 
 
