using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using LitJson;
using UnityEngine.SceneManagement;

public class Record : MonoBehaviour
{
	private bool b;
	private JsonData json;
	private First first = new First ();
	public SaveVars saveVars;
	public GameObject gameObject;
	private int ID;

   
	private int doritos, laysClassic, laysHot, laysBarbeque, laysMax, colaCan, fantaBottle, pepsiBottle, colaPet, dornaPet, pepsiPet, mirindaPet;

	public class First
	{
		public int ID;
		public int raft;
		public string name;

		public void SetData (int ID, int raft, string name)
		{
			this.ID = ID;
			this.raft = raft;
			this.name = name;
		}
	}

	void Start ()
	{
		gameObject = GameObject.Find ("SaveVars");
		saveVars = gameObject.GetComponent<SaveVars> ();
		ID = saveVars.GetID ();

	}

	public int GetDoritos ()
	{
		return doritos;
	}

	public void UpDoritos ()
	{
		doritos++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "doritos");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		}                                          
	}

	public void DownDoritos ()
	{
		doritos--;
	}

	public int GetLaysClassic ()
	{
		return laysClassic;
	}

	public void UpLaysClassic ()
	{
		laysClassic++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "laysClassic");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		}  
	}

	public void DownLaysClassic ()
	{
		laysClassic--;
	}

	public int GetLaysHot ()
	{
		return laysHot;
	}

	public void UpLaysHot ()
	{
		laysHot++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "laysHot");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		}  
	}

	public void DownLaysHot ()
	{
		laysHot--;
	}

	public int GetLaysBarbeque ()
	{
		return laysBarbeque;
	}

	public void UpLaysBarbeque ()
	{
		laysBarbeque++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "laysBarbeque");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownLaysBarbeque ()
	{
		laysBarbeque--;
	}

	public int GetLaysMax ()
	{
		return laysMax;
	}

	public void UpLaysMax ()
	{
		laysMax++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "laysMax");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownLaysMax ()
	{
		laysMax--;
	}

	public int GetColaCan ()
	{
		return colaCan;
	}

	public void UpColaCan ()
	{
		colaCan++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "colaCan");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownColaCan ()
	{
		colaCan--;
	}

	public int GetFantaBottle ()
	{
		return fantaBottle;
	}

	public void UpFantaBottle ()
	{
		fantaBottle++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "fantaBottle");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownFantaBottle ()
	{
		fantaBottle--;
	}

	public int GetPepsiBottle ()
	{
		return pepsiBottle;
	}

	public void UpPepsiBottle ()
	{
		pepsiBottle++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "pepsiBottle");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownPepsiBottle ()
	{
		pepsiBottle--;
	}

	public int GetColaPet ()
	{
		return colaPet;
	}

	public void UpColaPet ()
	{
		colaPet++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "colaPet");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownColaPet ()
	{
		colaPet--;
	}

	public int GetDornaPet ()
	{
		return dornaPet;
	}

	public void UpDornaPet ()
	{
		dornaPet++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "dornaPet");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownDornaPet ()
	{
		dornaPet--;
	}

	public int GetPepsiPet ()
	{
		return pepsiPet;
	}

	public void UpPepsiPet ()
	{
		pepsiPet++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "pepsiPet");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownPepsiPet ()
	{
		pepsiPet--;
	}

	public int GetMirindaPet ()
	{
		return mirindaPet;
	}

	public void UpMirindaPet ()
	{
		mirindaPet++;
		if (!b) { 
			first.SetData (ID, SceneManager.GetActiveScene ().buildIndex - 1, "mirindaPet");
			json = JsonMapper.ToJson (first);
			File.AppendAllText (Application.dataPath + "/Data/DataFirst.json", json.ToString () + ","); 
			b = true;
		} 
	}

	public void DownMirindaPet ()
	{
		mirindaPet--;
	}

}




