using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using LitJson;
using System.IO;


public class RayView : MonoBehaviour
{

	private Camera fpsCam;
	private RaycastHit hit;
	private double x;
	private double y;
	private JsonData rayJson;
	public Data data;
    private string s = "";
    private int i = 1;
    private int j;
    public GameObject gameObject;
    public SaveVars saveVars;
    public int ID;

    void Start ()
	{
		fpsCam = GetComponent<Camera> ();
        gameObject = GameObject.Find("SaveVars");
        saveVars = gameObject.GetComponent<SaveVars>();
        ID = saveVars.GetID();
        j = SceneManager.GetActiveScene().buildIndex - 1;
    }

    public string GetString()
    {
        return s;
    }

    public void ResetString()
    {
        s = "";
    }

    void FixedUpdate ()
	{
		Vector3 lineOrigin = fpsCam.ViewportToWorldPoint (new Vector3 (0.5f, 0.5f, 0));
		Debug.DrawRay (lineOrigin, fpsCam.transform.forward * 50f, Color.green);
		RaycastHit hit;

		int layerMask = 1 << 9;

		if (Physics.Raycast (lineOrigin, fpsCam.transform.forward, out hit, 100f, layerMask)) {
			
			//	Debug.Log ("contact in x = " + hit.textureCoord.x + " y = " + hit.textureCoord.y);
			//  Vector2 pixelUV = hit.textureCoord;
			//  Debug.Log(" time : " + Time.time + " " + pixelUV.ToString("F4")   );
			// x = pixelUV.x;
			// y = pixelUV.y;
			Data data = new Data ();
			data.SetData (Time.time, hit.textureCoord.x, hit.textureCoord.y);
			rayJson = JsonMapper.ToJson (data);
            s = s + rayJson.ToString() + ",";
        //    File.AppendAllText (Application.dataPath + "/ray.vtr", s);			
		} else {
			Data data = new Data ();
			data.SetData (Time.time, 0d, 0d);
			rayJson = JsonMapper.ToJson (data);
            s = s + rayJson.ToString() + ",";
        //    File.AppendAllText (Application.dataPath + "/ray.vtr", rayJson.ToString () + ",");
		}

        i++;
        if ( i == 90 )
        {
            File.AppendAllText(Application.dataPath + "/Data/eye_" + ID + "_" + j + ".vtr", s);
            s = "";
            i = 0;
        }
    }

	public class Data
	{
		public double time;
		public double x;
		public double y;


		public Data ()
		{

		}

		public void SetData (double time, double x, double y)
		{
			this.time = time;
			this.x = x;
			this.y = y;

		}

	}

    
}
