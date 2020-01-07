using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bought : MonoBehaviour {

    public PosVect posVect;
    
    public class PosVect
    {
        private Vector3[] location;
        private Vector3[] oldLocation;
        private bool[] index;

        public PosVect()
        {
            location = new Vector3[12];
            oldLocation = new Vector3[12];
            index = new bool[12];

            location[0] = new Vector3(-0.873f, 2.095f, -2.509f);
            location[1] = new Vector3(-0.873f, 2.095f, -2.809f);
            location[2] = new Vector3(-0.873f, 2.095f, -3.109f);
            location[3] = new Vector3(-0.873f, 2.095f, -3.409f);
            location[4] = new Vector3(-0.873f, 1.645f, -2.509f);
            location[5] = new Vector3(-0.873f, 1.645f, -2.809f);
            location[6] = new Vector3(-0.873f, 1.645f, -3.109f);
            location[7] = new Vector3(-0.873f, 1.645f, -3.409f);
            location[8] = new Vector3(-0.873f, 1.195f, -2.509f);
            location[9] = new Vector3(-0.873f, 1.195f, -2.809f);
            location[10] = new Vector3(-0.873f, 1.195f, -3.109f);
            location[11] = new Vector3(-0.873f, 1.195f, -3.409f);

        }

        public Vector3 GetLocationValue(int i)
        {
            return location[i];
        }

        public int GetLocationIndex(Vector3 v)
        {
            int j = 99;
            for (int i = 0; i < location.Length; i++)
            {
                if (location[i] == v && index[i] == true)
                {
                    j = i;
                    break;
                }
            }
            return j;
        }

        public bool GetIndex(int i)
        {
            return index[i]; 
        }

        public void SetIndex(int i, bool b)
        {
            index[i] = b;
        }

        public int GetFreeLocation()
        {
            int j = 99;
            for (int i = 0; i < index.Length; i++)
            {
                if (index[i] == false)
                {
                    j = i;
                    break;
                } 
            }
            return j;
        }

        public void SetOldLocation(int i, Vector3 v)
        {
            oldLocation[i] = v;
        }

        public Vector3 GetOldLocation(int i)
        {
            return oldLocation[i] ;
        }




    }
    // Use this for initialization
    void Start () {
        posVect = new PosVect(); 

	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
