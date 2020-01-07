using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Leap.Unity;
using Leap;
using LeapInternal;
using System.IO;
using System;

public class InteractionCollider : MonoBehaviour
{


    private ParticleSystem particleLauncher;
    private float duration = 1f;
    private bool enable;
    public Record record;
    public RecordOut recordOut;
    private string s;
    private string callString, callStringOut;
    private Collider collider;

    private Vector3[] vectorPositionInit;
    public Bought bought;

    IEnumerator MovePlayer(GameObject gameObject, int k)
    {

        yield return new WaitForSeconds(duration);
        gameObject.transform.position = bought.posVect.GetLocationValue(k);
        gameObject.transform.Rotate(0, -90, 0);
        collider = GetComponent<Collider>();
        collider.enabled = true;

    }


    void OnTriggerEnter(Collider other)
    {
        


       Collider thisCollider = GetComponent<Collider>();
       CapsuleCollider capsuleCollider = other as CapsuleCollider;
       s = capsuleCollider.ToString(); 
       int j = bought.posVect.GetLocationIndex(gameObject.transform.position);
       int k = bought.posVect.GetFreeLocation();

        if ( s == "1 (UnityEngine.CapsuleCollider)" && j == 99 && k != 99)
            {
            
            particleLauncher = GetComponent<ParticleSystem>();
            enable = GetComponent<ParticleSystem>().emission.enabled;
            enable = true;
            particleLauncher.Play();  

            collider = GetComponent<Collider>();
            collider.enabled = false;
            callString = "Up" + gameObject.tag;
            record.Invoke(callString, 0f);
            bought.posVect.SetOldLocation(k, gameObject.transform.position);
            bought.posVect.SetIndex(k, true);
            StartCoroutine(MovePlayer(gameObject, k));
            gameObject.transform.parent = bought.transform;

            return;
        }
        
        if (s == "1 (UnityEngine.CapsuleCollider)" && j != 99)
        {
            callString = "Down" + gameObject.tag;
            record.Invoke(callString, 0f);
            callStringOut = "Up" + gameObject.tag;
            recordOut.Invoke(callStringOut, 0f);
            bought.posVect.SetIndex(j, false);
            gameObject.transform.position = bought.posVect.GetOldLocation(j);
            gameObject.transform.Rotate(0, 90, 0);
            gameObject.transform.parent = record.transform;
            return;
        }   
    }   



    		


}


