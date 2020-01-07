using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Leap.Unity;
using Leap;
using LeapInternal;
using System.IO;
using LitJson;
using UnityEngine.SceneManagement;

public class Write : MonoBehaviour
{

	public JsonData json, jsonOut;
	public ShelfData shelfData, shelfDataOut;
	public Record record;
    public RecordOut recordOut;
    public GameObject gameObject;
	public SaveVars saveVars;
	public int ID;
    private bool b;


	// Use this for initialization
	void Start ()
	{
		gameObject = GameObject.Find ("SaveVars");
		saveVars = gameObject.GetComponent<SaveVars> ();
		ID = saveVars.GetID ();

	}
	
	// Update is called once per frame
	void Update ()
	{
		
	}

	public void WriteData ()
	{
        if (!b)
        {
            ShelfData shelfData = new ShelfData();
            shelfData.SetData(ID, SceneManager.GetActiveScene().buildIndex - 1, record.GetDoritos(), record.GetLaysClassic(), record.GetLaysHot(), record.GetLaysBarbeque(), record.GetLaysMax(), record.GetColaCan(), record.GetFantaBottle(), record.GetPepsiBottle(), record.GetColaPet(), record.GetDornaPet(), record.GetPepsiPet(), record.GetMirindaPet());
            json = JsonMapper.ToJson(shelfData);
            File.AppendAllText(Application.dataPath + "/Data/DataAll.json", json.ToString() + ",");

            ShelfData shelfDataOut = new ShelfData();
            shelfDataOut.SetData(ID, SceneManager.GetActiveScene().buildIndex - 1, recordOut.GetDoritos(), recordOut.GetLaysClassic(), recordOut.GetLaysHot(), recordOut.GetLaysBarbeque(), recordOut.GetLaysMax(), recordOut.GetColaCan(), recordOut.GetFantaBottle(), recordOut.GetPepsiBottle(), recordOut.GetColaPet(), recordOut.GetDornaPet(), recordOut.GetPepsiPet(), recordOut.GetMirindaPet());
            jsonOut = JsonMapper.ToJson(shelfDataOut);
            File.AppendAllText(Application.dataPath + "/Data/DataOut.json", jsonOut.ToString() + ",");

            b = true;
        }

	}


	public class ShelfData
	{
		public int ID;
		public int raft;
        public int doritos, laysClassic, laysHot, laysBarbeque, laysMax, colaCan, fantaBottle, pepsiBottle, colaPet, dornaPet, pepsiPet, mirindaPet;

        public void SetData (int ID, int raft, int doritos, int laysClassic, int laysHot, int laysBarbeque, int laysMax, int colaCan, int fantaBottle, int pepsiBottle, int colaPet, int dornaPet, int pepsiPet, int mirindaPet)
		{
			this.ID = ID;
			this.raft = raft;
			this.doritos = doritos;
            this.laysClassic = laysClassic;
            this.laysHot = laysHot;
            this.laysBarbeque = laysBarbeque;
            this.laysMax = laysMax;
            this.colaCan = colaCan;
            this.fantaBottle = fantaBottle;
            this.pepsiBottle = pepsiBottle;
            this.colaPet = colaPet;
            this.dornaPet = dornaPet;
            this.pepsiPet = pepsiPet;
            this.mirindaPet = mirindaPet;
        }
 
	}

}

 