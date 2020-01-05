using LibSVMsharp;
using LibSVMsharp.Extensions;
using LibSVMsharp.Helpers;
using System;
using System.Collections.Generic;
using UnityEngine;


public class Classifier : MonoBehaviour
{

	private SVMProblem trainingSet;
	private SVMModel model;
	private SVMUpdate svmData;
	private double[] inputVectorLeft, inputVectorRight;
	private double[][] avgArray;
	private int resultLeft, resultRight;
	public int euclideanDistance;

	double[][] CalculateAverageInputVector(SVMProblem trainingSet, SVMModel model)
	/// helper function that calculates the ideal input vector for each class by averaging all the vectors in each class
	/// working with un-normalised values 
	{
		double[] noEachClass = new double[model.ClassCount];
		double[][] avgArray = new double[model.ClassCount][];

		for (int i = 0; i < model.ClassCount; i++)
		{
			avgArray[i] = new double[9];
		}

		for (int i = 0; i < trainingSet.Length; i++)
		{
			for (int j = 0; j < 9; j++)
			{
				avgArray[(int)trainingSet.Y[i] - 1][j] += trainingSet.X[i][j].Value;
			}
			noEachClass[(int)trainingSet.Y[i] - 1] += 1;
		}

		for (int i = 0; i < model.ClassCount; i++)
		{
			for (int j = 0; j < 9; j++)
			{
				avgArray[i][j] /= noEachClass[i];
			}
		}

		return avgArray;
	}

	double EuclideanDistance(double[] a, double[] b)
	// helper function that calculate the Euclidean Distance between two nine dimensional vectors
	{
		double squareSum = 0f;
		for (int i = 0; i < 9; i++)
		{
			squareSum += Math.Pow(a[i] - b[i], 2);
		}

		return Math.Sqrt(squareSum);
	}

	int Predict(double[] testArray)
	// take the input array, transform it into a SVMProblem and predict the gesture
	{
		List<SVMNode> nodes = new List<SVMNode>();
		var testSet = new SVMProblem();

		for (int i = 0; i < 9; i++)
		{
			SVMNode node = new SVMNode();
			node.Index = Convert.ToInt32(i + 1);
			node.Value = Convert.ToDouble(testArray[i]);
			nodes.Add(node);
		}

		testSet.Add(nodes.ToArray(), 1);
		testSet = testSet.Normalize(SVMNormType.L2);

		double[] testResults = testSet.Predict(model);

		return (int)testResults[0];
	}

	void Start()
	// generate the model on startup and calculate ideal vector for each class
	{
		trainingSet = SVMProblemHelper.Load(Application.dataPath + "/TrainData.txt");
		trainingSet = trainingSet.Normalize(SVMNormType.L2);

		SVMParameter parameter = new SVMParameter();
		parameter.Type = SVMType.C_SVC;
		parameter.Kernel = SVMKernelType.POLY;
		parameter.C = 100;
		parameter.Gamma = 1;

		model = trainingSet.Train(parameter);

		svmData = GetComponent<SVMUpdate>();
		avgArray = CalculateAverageInputVector(SVMProblemHelper.Load(Application.dataPath + "/TrainData.txt"), model);
		euclideanDistance = 50;
	}

	void Update()
	{
		inputVectorLeft = svmData.getInputVectorLeft();
		inputVectorRight = svmData.getInputVectorRight();

		resultLeft = Predict(inputVectorLeft);
		if (EuclideanDistance(inputVectorLeft, avgArray[resultLeft - 1]) > 50)
		{
			resultLeft = -1;
		}
	
		resultRight = Predict(inputVectorRight);
		if (EuclideanDistance(inputVectorRight, avgArray[resultRight - 1]) > 50)
		{
			resultRight = -1;
		}

		Debug.Log("Left hand gesture: " + resultLeft + " -- " + "Right hand gesture: " + resultRight);
	}




}
