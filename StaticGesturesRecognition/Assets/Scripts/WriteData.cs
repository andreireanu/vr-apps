using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using LitJson;

public class WriteData : MonoBehaviour  // write a json file with training data for SVM model, with the first value being vector class id
{

	public bool writeInputVectors; // write input vectors to the drive 
	public int id; // id of the gesture
	public int noOfInputVectors; // number of input vectors to write
	private int counter;
	private SVMUpdate svmupdate;
	private Writer writer;
	private JsonData trainValJson;
	private double[] inputVector;

	public class Writer
	{
		public int v0;
		public double v1;
		public double v2;
		public double v3;
		public double v4;
		public double v5;
		public double v6;
		public double v7;
		public double v8;
		public double v9;

		public void SetfeatureArray(double[] featureArray, int id)
		{
			this.v0 = id;
			this.v1 = System.Math.Round(featureArray[0], 4);
			this.v2 = System.Math.Round(featureArray[1], 4);
			this.v3 = System.Math.Round(featureArray[2], 4);
			this.v4 = System.Math.Round(featureArray[3], 4);
			this.v5 = System.Math.Round(featureArray[4], 4);
			this.v6 = System.Math.Round(featureArray[5], 4);
			this.v7 = System.Math.Round(featureArray[6], 4);
			this.v8 = System.Math.Round(featureArray[7], 4);
			this.v9 = System.Math.Round(featureArray[8], 4);
		}
	}

	void Start()
	{
		svmupdate = GetComponent<SVMUpdate>();
		writer = new Writer();
		inputVector = new double[9];
		counter = 0;
	}

	void Update()
	{
		inputVector = svmupdate.getInputVectorLeft(); // !!! training data is collected using left hand only !!!

		if (inputVector[0] == 0 || counter > noOfInputVectors - 1) // automatically disable writing if left hand not detected or counterMax input vectors have been written
		{
			writeInputVectors = false;
			counter = 0;
		}

		if (writeInputVectors == true && inputVector[0] != 0 && counter <= noOfInputVectors - 1)
		{
			writer.SetfeatureArray(inputVector, id);
			trainValJson = JsonMapper.ToJson(writer);
			Debug.Log(trainValJson);
			File.AppendAllText(Application.dataPath + "/TrainDataJson.json", trainValJson.ToString());
			File.AppendAllText(Application.dataPath + "/TrainDataJson.json", "\n");
			counter += 1;
		}
	}
}

